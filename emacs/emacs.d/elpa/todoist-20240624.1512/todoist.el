;;; todoist.el --- Extension for interacting and managing todoist tasks -*- lexical-binding: t; -*-

;; Copyright (C) 2019, Adrien Brochard

;; This file is NOT part of Emacs.

;; This  program is  free  software; you  can  redistribute it  and/or
;; modify it  under the  terms of  the GNU  General Public  License as
;; published by the Free Software  Foundation; either version 2 of the
;; License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT  ANY  WARRANTY;  without   even  the  implied  warranty  of
;; MERCHANTABILITY or FITNESS  FOR A PARTICULAR PURPOSE.   See the GNU
;; General Public License for more details.

;; You should have  received a copy of the GNU  General Public License
;; along  with  this program;  if  not,  write  to the  Free  Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
;; USA

;; Package-Version: 20240624.1512
;; Package-Revision: 205c730a4615
;; Author: Adrien Brochard
;; Keywords: todoist task todo comm
;; URL: https://github.com/abrochard/emacs-todoist
;; License: GNU General Public License >= 3
;; Package-Requires: ((dash "2.15.0") (transient "0.1.0") (org "8.3.5") (emacs "25.3"))

;;; Commentary:

;; Emacs extension for interacting with the task tracking service todoist

;;; Setup:
;; Get your token (https://todoist.com/app/settings/integrations
;; and shove it as (setq todoist-token "XXXXXXXX")

;;; Usage:

;; M-x todoist to pull up tasks
;; C-x t for the task menu
;; C-x p for the project menu

;;; Code:

(require 'dash)
(require 'transient)
(require 'org)
;; (require 'org-refile) why is it gone?
(require 'json)
(require 'url)
(require 'url-http)

(defvar url-http-end-of-headers)  ; silence byte-compiler warnings

(defvar todoist-token
  (getenv "TODOIST_TOKEN"))

(defconst todoist-url
  "https://api.todoist.com/rest/v2")

(defconst todoist-buffer-name
  "*todoist*")

(defgroup todoist nil
  "Interface for todoist.com, a task tracking tool."
  :group 'extensions
  :group 'tools
  :link '(url-link :tag "Repository" "https://github.com/abrochard/emacs-todoist"))

(defcustom todoist-timeout nil
  "Timeout in second to reach todoist API."
  :group 'todoist
  :type 'number)

(defcustom todoist-backing-buffer nil
  "File location of the todoist backing buffer."
  :group 'todoist
  :type 'string)

(defcustom todoist-show-all nil
  "If not nil, show all tasks un-collapsed."
  :group 'todoist
  :type 'bool)

(defcustom todoist-refile-todo-keyword "TODO"
  "If not nil, add `org-todo' keyword when refiling."
  :group 'todoist
  :type 'string)

(defcustom todoist-use-scheduled-instead-of-deadline nil
  "If not nil, use SCHEDULED instead of DEADLINE in org files."
  :group 'todoist
  :type 'bool)

(defvar todoist--cached-projects nil)

(defvar todoist--cached-sections nil)

(defun todoist--query (method endpoint &optional data)
  "Main function to interact with Todoist api.

METHOD is http method string.
ENDPOINT is the endpoint string.
DATA is the request body."
  (let ((url (concat todoist-url endpoint))
        (url-request-method method)
        (url-request-extra-headers (append`(("Authorization" . ,(concat "Bearer " todoist-token)))
                                          (when data '(("Content-Type". "application/json")))))
        (url-request-data (if data
                              (encode-coding-string (json-encode data) 'utf-8)))
        (response nil))
    (with-current-buffer (url-retrieve-synchronously url nil nil todoist-timeout)
      (let ((status (todoist--parse-status-code)))
        (unless (string-match-p "2.." status)
          (throw 'bad-response (format "Bad status code returned: %s" status))))
      (goto-char url-http-end-of-headers)
      (setq response (unless (string-equal (buffer-substring (point) (point-max)) "\n") ;; no body
                    (json-read-from-string (decode-coding-region (point) (point-max) 'utf-8 t))))
      (kill-buffer (current-buffer)) ;; kill the buffer to free up some memory
      response)))

(defun todoist--parse-status-code ()
  "Parse the todoist response status code."
  (save-excursion
    (goto-char (point-min))
    (re-search-forward "HTTP/1.1 \\([0-9]\\{3\\}\\)")
    (match-string-no-properties 1)))

(defun todoist--task-id (task)
  "Get the task id.

TASK is the task object."
  (assoc-default 'id task))

(defun todoist--task-date (task)
  "Get the task due date.

TASK is the task object"
  (assoc-default 'date (assoc-default 'due task)))

(defun todoist--task-content (task)
  "Get the task content.

TASK is the task object."
  (assoc-default 'content task))

(defun todoist--task-project-id (task)
  "Get the task project id.

TASK is the task object"
  (assoc-default 'project_id task))

(defun todoist--task-section-id (task)
  "Get the task section id.

TASK is the task object"
  (assoc-default 'section_id task))

(defun todoist--section-id (section)
  "Get the section id.

SECTION is the section object"
  (assoc-default 'id section))

(defun todoist--section-project-id (section)
  "Get the section project id.

SECTION is the section object"
  (assoc-default 'project_id section))

(defun todoist--section-name (section)
  "Get the section name.

SECTION is the section object"
  (assoc-default 'name section))

(defun todoist--project-id (project)
  "Get the project id.

PROJECT is the project object."
  (assoc-default 'id project))

(defun todoist--project-name (project)
  "Get the project name.

PROJECT is the project object."
  (assoc-default 'name project))

(defun todoist--task-description (task)
  "Get the description.

TASK is the task object"

    (assoc-default 'description task))

(defun todoist--task-is-sectionless (task)
  "Get if a task has not been assigned to a section.

TASK is the task object"
  (null (todoist--task-section-id task)))

(defun todoist--task-in-section (task section)
  "Get if a task is in the supplied section.

TASK is the task object
SECTION is the section object"
  (equal (todoist--task-section-id task) (todoist--section-id section)))

(defun todoist--task-in-project (task project)
  "Get if a task is in the supplied project.

TASK is the task object
PROJECT is the project object"
  (equal (todoist--task-project-id task) (todoist--project-id project)))

(defun todoist--filter-tasks (project tasks &optional section)
  "Get subset of tasks under a project.

PROJECT the project.
TASKS the list of tasks."
  (-filter (lambda (task)
             (and (todoist--task-in-project task project)
                  (or (null section) (todoist--task-in-section task section))))
           tasks))

(defun todoist--insert-heading (level str &optional todo)
  "Insert a org heading at a certain depth.

LEVEL is the level.
STR is the heading title.
TODO is optional to make this a todo heading."
  (goto-char (point-max))
  (if todo
      (insert (format "\n%s TODO %s" (make-string level ?*) str))
    (insert (format "\n%s %s" (make-string level ?*) str))))

(defun todoist--insert-task (task level todo)
  "Insert the task as 'org-mode' bullet.

TASK is the task.
LEVEL is the ord heading level.
TODO is boolean to show TODO tag."
  (todoist--insert-heading level (todoist--task-content task) todo)
  (when (todoist--task-date task)
    (if todoist-use-scheduled-instead-of-deadline
      (org-schedule nil (todoist--task-date task))
      (org-deadline nil (todoist--task-date task))))
  (org-set-property "TODOIST_ID" (format "%s" (todoist--task-id task)))
  (org-set-property "TODOIST_PROJECT_ID" (format "%s" (todoist--task-project-id task)))
  (goto-char (point-max))
  (when-let ((description (todoist--task-description task))
             (not-empty (> (length description) 0)))
    (insert (replace-regexp-in-string (rx line-start) (make-string level ?\s) description))))

(defun todoist--insert-project (project sections tasks)
  "Insert the current project and matching tasks as org bullet list.

PROJECT the project object.
SECTIONS is the list of all sections
TASKS the list of all tasks."
  (todoist--insert-heading 2 (todoist--project-name project))
  ; If there are no sections in this project, list all tasks at level 3
  (if (or (null sections) (null (-filter (lambda (section) (equal (todoist--section-project-id section) (todoist--project-id project))) sections)))
    (mapcar (lambda (task) (todoist--insert-task task 3 nil))
      (todoist--filter-tasks project tasks))

  ; Insert this project's tasks without section_id's in the "Unsectioned" heading
  (let ((unsectioned (-filter (lambda (task) (and
                                (todoist--task-is-sectionless task)
                                (todoist--task-in-project task project))) tasks)))
    (unless (null unsectioned)
    (todoist--insert-heading 3 "Unsectioned")
    (dolist (u unsectioned) (todoist--insert-task u 4 nil))))

  ; Insert tasks under all sections
  (dolist (s sections)
  (if (equal (todoist--section-project-id s) (todoist--project-id project))
    (progn (todoist--insert-heading 3 (todoist--section-name s))
    (mapcar (lambda (task) (todoist--insert-task task 4 nil))
      (todoist--filter-tasks project tasks s)))))))

(defun todoist--inbox-id (projects)
  "Get the project id of the inbox.

PROJECTS the list of all projects."
  (todoist--project-id (-first (lambda (project) (equal (todoist--project-name project) "Inbox")) projects)))

(defun todoist--is-today (task)
  "Return non-nil if the tasks is scheduled for today or overdue.

TASK is the task."
  (and
   (todoist--task-date task)
   (time-less-p (date-to-time
                 (concat (todoist--task-date task) " 00:00:00"))
                (current-time))))

(defun todoist--insert-today (tasks)
  "Insert today's tasks.

TASKS is the list of tasks."
  (mapcar (lambda (task) (todoist--insert-task task 2 t)) (-filter 'todoist--is-today tasks)))

(defun todoist--get-projects (&optional cache)
  "Get the list of all projects.

CACHE to read from cache rather than query upstream."
  (if cache
      todoist--cached-projects
    (setq todoist--cached-projects
          (append (todoist--query "GET" "/projects") nil))))

(defun todoist--get-sections (&optional cache)
  "Get the list of all sections.

CACHE to read from cache rather than query upstream."
  (if cache
      todoist--cached-sections
    (setq todoist--cached-sections
          (append (todoist--query "GET" "/sections") nil))))

(defun todoist--get-tasks ()
  "Get the list of all tasks."
  (append (todoist--query "GET" "/tasks") nil))

(defun todoist--create-new-task (content due p)
  "Query todoist to create new task.

CONTENT is the content string.
DUE is the human friendly due string and can be empty.
P is a prefix argument to select a project."
  (todoist--query "POST" "/tasks"
                  (append `(("content" . ,content) ("due_string" . ,due))
                          (when p
                            `(("project_id" . ,(todoist--project-id (todoist--select-project))))))))

(defun todoist--fold-projects ()
  "Fold the project list."
  (save-excursion
    (goto-char (point-min))
    (re-search-forward "^\\* Projects$")
    (org-cycle)))

(defun todoist--fold-today ()
  "Fold the today list to hide properties."
  (save-excursion
    (goto-char (point-min))
    (re-search-forward "^\\* Today$")
    (org-cycle) (org-cycle)))

(defun todoist--show-all ()
  "Only fold top level."
  (org-global-cycle 3))

(defun todoist--under-cursor-task-id ()
  "Get the todoist task id of the task under the cursor."
  (save-excursion
    (org-back-to-heading)
    (org-element-property :TODOIST_ID (org-element-at-point))))

(defun todoist--parse-org-time-string (str)
  "Parse an org timestring into a simple YYYY-MM-DD string.

STR is an org time string."
  (unless (eq str nil)
    (string-match "<\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}+\\) .*>" str)
    (match-string 1 str)))


(defun todoist--select-project (&optional cache)
  "Take user input to select a project object from a list.

CACHE is optional param to get projects from cache."
  (let* ((projects (todoist--get-projects cache))
         (name (completing-read "Select project: " (mapcar 'todoist--project-name projects))))
    (-find (lambda (x) (equal (todoist--project-name x) name)) projects)))

(defun todoist--refile-handler ()
  "Delete todoist task when refiled elsewhere. Called via `org-after-refile-insert-hook'.

CAVEAT: Does not correctly handle refiling a region with multiple tasks. In this case, only the
first task will be deleted."
  (when (and (todoist--under-cursor-task-id)
             (not (equal todoist-buffer-name (buffer-name))) ;; Refiled to another buffer.
             (not org-refile-keep))
    ;; Using query directly instead of `todoist-delete-task' for performance. Since the task was
    ;; refiled there's no need to refresh the todoist buffer to remove it.
    (todoist--query "DELETE" (format "/tasks/%s" (todoist--under-cursor-task-id)))
    (org-delete-property "TODOIST_ID")
    (org-delete-property "TODOIST_PROJECT_ID")
    (unless (or (org-entry-is-todo-p)  ;; User may have already added a todo keyword, don't overwrite.
                (not todoist-refile-todo-keyword))
      (org-todo todoist-refile-todo-keyword))))

;;; interactive
;;; project management
(defun todoist-new-project (name)
  "Create a new project.

NAME is the name of the project."
  (interactive "sProject name: ")
  (todoist--query "POST" "/projects" `(("name" . ,name))))

(defun todoist-update-project ()
  "Change the name of a project."
  (interactive)
  (todoist--query "POST" (format "/projects/%s" (todoist--project-id (todoist--select-project)))
                  `(("name" . ,(read-string "New project name: ")))))

(defun todoist-delete-project ()
  "Delete a project."
  (interactive)
  (todoist--query "DELETE" (format "/projects/%s" (todoist--project-id (todoist--select-project)))))

;;; task managmement
(defun todoist-new-task (content due p)
  "Create a new task.

CONTENT is the content string.
DUE is the human friendly due string and can be empty.
P is a prefix argument to select a project."
  (interactive "sTask content: \nsDue: \nP")
  (todoist--create-new-task content due p)
  (todoist))


(defun todoist-quick-new-task (content due p)
  "Create a new task without loading the todoist-buffer.

CONTENT is the content string.
DUE is the human friendly due string and can be empty.
P is a prefix argument to select a project."
  (interactive "sTask content: \nsDue: \nP")
  (todoist--create-new-task content due p)
  (message "Task created successfully."))


(defun todoist-update-task ()
  "Update the content and due date of the task under cursor."
  (interactive)
  (let ((task-id (todoist--under-cursor-task-id))
        (content (read-string "Task content: " (org-entry-get nil "ITEM")))
        (due (if todoist-use-scheduled-instead-of-deadline
          (read-string "Task due: " (todoist--parse-org-time-string (org-entry-get nil "SCHEDULED")))
          (read-string "Task due: " (todoist--parse-org-time-string (org-entry-get nil "DEADLINE"))))))
    (todoist--query "POST" (format "/tasks/%s" task-id) `(("content" . ,content) ("due_string" . ,due)))
    (todoist)))

;; doesn't work??
;; (defun todoist-assign-task ()
;;   "Assign the task under the cursor to a specific project."
;;   (interactive)
;;   (let ((task-id (todoist--under-cursor-task-id))
;;         (project-id (todoist--project-id (todoist--select-project))))
;;     (todoist--query "POST" (format "/tasks/%s" task-id) (json-encode `(("project_id" . ,project-id))))
;;     (todoist)))

(defun todoist-delete-task ()
  "Delete the task under the cusror."
  (interactive)
  (todoist--query "DELETE" (format "/tasks/%s" (todoist--under-cursor-task-id)))
  (todoist))

(defun todoist-close-task ()
  "Close the task under the cursor, marking it as done or checking it."
  (interactive)
  (todoist--query "POST" (format "/tasks/%s/close" (todoist--under-cursor-task-id)))
  (todoist))


(defun todoist--write-to-file-if-needed ()
  "Write todoist buffer to file if backing-buffer is defined."
  (when todoist-backing-buffer
    (let ((buffer (get-file-buffer todoist-backing-buffer)))
      (when buffer
        (kill-buffer buffer)))
    (write-region nil nil todoist-backing-buffer)))

;; transient interface
(transient-define-prefix todoist-task-menu ()
  "Manage Todoist tasks."
  ["Actions"
   ("c" "Close task" todoist-close-task)
   ("n" "New task" todoist-new-task)
   ("q" "Quick new task" todoist-quick-new-task)
   ("u" "Update task" todoist-update-task)
   ("d" "Delete task" todoist-delete-task)])

(transient-define-prefix todoist-project-menu ()
  "Manage Todoist projects."
  ["Actions"
   ("n" "New project" todoist-new-project)
   ("u" "Update project" todoist-update-project)
   ("d" "Delete project" todoist-delete-project)])

(defvar todoist-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-x t") 'todoist-task-menu)
    (define-key map (kbd "C-x p") 'todoist-project-menu)
   map)
  "Keymap for `todoist-mode'.")

(define-derived-mode todoist-mode org-mode "Todoist"
  "Special mode for todoist buffers.")

;;;###autoload
(defun todoist ()
  "Main function to summon the todoist dashboard as 'org-mode'."
  (interactive)
  (let ((projects (todoist--get-projects))
         (tasks (todoist--get-tasks))
         (sections (todoist--get-sections)))
    (with-temp-buffer todoist-buffer-name
      (pop-to-buffer todoist-buffer-name)
      (delete-region (point-min) (point-max))
      (todoist-mode)
      (insert "#+title: Todoist\n")
      (todoist--insert-heading 1 "Today")
      (todoist--insert-today tasks)
      (todoist--insert-heading 1 "Projects")
      (dolist (p projects) (todoist--insert-project p sections tasks))
      (if todoist-show-all
        (todoist--show-all)
        (todoist--fold-projects)
        (todoist--fold-today))
      (todoist--write-to-file-if-needed)
      ;; Global hook, not local, because it's called from the refile destination.
      (add-hook 'org-after-refile-insert-hook #'todoist--refile-handler))))

(provide 'todoist)
;;; todoist.el ends here
