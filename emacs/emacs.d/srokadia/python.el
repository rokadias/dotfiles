;;; python --- Saqib's python configuration.
;;; Commentary:
;;; Sets general things that I like.
;;; Code:
(defun on-python-load ()
  (require 'importmagic)
  (require 'lsp-pyright)
  (require 'python-black)
  (require 'pyenv-mode)
  (require 'flymake-ruff)
  (set-python-env-if-available)
  (lsp)
  (company-mode nil)
  (python-black-on-save-mode)
  (importmagic-mode)
  (flymake-ruff-load)
  (let ((project-file (find-project-file "\\.isort.cfg$")))
    (when project-file
      (make-local-variable 'py-isort-options)
      (setq py-isort-options (concat "--settings-path " project-file))))
  (set-check-python-compile-command)
  (pyenv-mode t))
(add-hook 'python-mode-hook #'on-python-load)

(setq python-indent-def-block-scale 1)

(with-eval-after-load "semantic/idle"
  (advice-add 'semantic-idle-scheduler-function :around #'ignore))

(defun python-get-file-path (&optional BUFFER)
  (let* ((filename (get-file-name BUFFER))
         (lsp-root (lsp--calculate-root (lsp-session) (buffer-file-name BUFFER)))
         (lsp-root-path (file-name-as-directory lsp-root)))
    (replace-regexp-in-string lsp-root-path "" filename))
  )

(defun matches-root-path(ROOT_PATH BUFFER)
  (let* ((file-path (buffer-file-name BUFFER)))
    (if (and file-path (string-prefix-p ROOT_PATH file-path)) t nil))
 )

(defun python-get-last-suitable-file-path (&optional BUFFER)
  (let* ((buf-list (buffer-list (selected-frame)))
         (lsp-root (lsp--calculate-root (lsp-session) (buffer-file-name BUFFER)))
         (lsp-root-path (file-name-as-directory lsp-root))
         (filtered-buffer-list (seq-filter (apply-partially 'matches-root-path lsp-root-path) buf-list)))
    (python-get-file-path (nth 1 filtered-buffer-list)))
  )

(defun python-get-library-path (&optional BUFFER)
  (replace-regexp-in-string "/" "." (replace-regexp-in-string ".py" "" (python-get-file-path BUFFER)))
  )

(defun python-get-last-suitable-library-path (&optional BUFFER)
  (replace-regexp-in-string "/" "." (replace-regexp-in-string ".py" "" (python-get-last-suitable-file-path BUFFER)))
  )

(defun python-copy-get-library-path (&optional BUFFER)
  "Copy the current buffer file name to the clipboard as a libary path."
  (interactive)
  (let ((library-path (python-get-library-path BUFFER)))
    (when library-path
      (kill-new library-path)
      (message "Copied library path '%s' to the clipboard." library-path))))

(defun python-copy-other-buffer-library-path ()
  "Copy the current buffer file name to the clipboard as a libary path."
  (interactive)
  (python-copy-get-library-path (other-buffer (current-buffer) t nil)))

(defun python-copy-get-file-path ()
  "Copy the current buffer file name to the clipboard as a libary path."
  (interactive)
  (let ((file-path (python-get-file-path)))
    (when file-path
      (kill-new file-path)
      (message "Copied file path '%s' to the clipboard." file-path))))

(defun set-check-python-compile-command ()
  "Set the python compile command which is just check mypy."
  (let* ((project-file (find-project-file "^mypy\\.ini$"))
         (project-parent-dir (directory-parent (directory-parent project-file)))
         (check-python-dir (file-name-as-directory (concat (file-name-as-directory project-parent-dir) "scripts")))
         (check-python-file (when (and check-python-dir (file-directory-p check-python-dir)) (car (directory-files-match check-python-dir "^check_python\\.sh$"))))
         (pyproject-file (find-project-file "^pyproject\\.toml$"))
         (pyproject-parent-dir (when (and pyproject-file (file-directory-p pyproject-file)) (directory-parent pyproject-file))))
    (cond ((and check-python-file (file-exists-p check-python-file))
      (message "Found project file at %s and check-python at %s" project-file check-python-file)
      (set (make-local-variable 'project-directory) project-parent-dir)
      (set (make-local-variable 'compile-command) (concat "set -o pipefail; unset PYENV_VERSION && " check-python-file " --nobuild" " --skip-sdk" " | sed -e 's/\\x1b\\[[0-9;]*m//g'")))
    ((and pyproject-file (file-exists-p pyproject-file))
      (message "Found project file at %s" pyproject-file)
      (set (make-local-variable 'project-directory) pyproject-parent-dir)
      (set (make-local-variable 'compile-command) (concat "set -o pipefail; unset PYENV_VERSION && poetry run mypy . | sed -e 's/\\x1b\\[[0-9;]*m//g'"))))))

(defun set-python-env-if-available ()
  "Set the python compile command which is just check mypy."
  (let* ((python-version-file (find-project-file "^\\.python-version$")))
    (when (file-exists-p python-version-file)
      (message "Found python version file at %s" python-version-file)
      (pyenv-mode-set (s-trim (f-read-text python-version-file 'utf-8))))))

(require 'lsp)
(require 'lsp-pyright)
(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-tramp-connection (lambda ()
                                          (cons (lsp-package-path 'pyright)
                                                lsp-pyright-langserver-command-args)))
  :major-modes '(python-mode)
  :remote? t
  :server-id 'pyright-remote
  :multi-root lsp-pyright-multi-root
  :priority 3
  :initialized-fn (lambda (workspace)
                    (with-lsp-workspace workspace
                      ;; we send empty settings initially, LSP server will ask for the
                      ;; configuration of each workspace folder later separately
                      (lsp--set-configuration
                       (make-hash-table :test 'equal))))
  :download-server-fn (lambda (_client callback error-callback _update?)
                        (lsp-package-ensure 'pyright callback error-callback))
  :notification-handlers (lsp-ht ("pyright/beginProgress" 'lsp-pyright--begin-progress-callback)
                                 ("pyright/reportProgress" 'lsp-pyright--report-progress-callback)
                                 ("pyright/endProgress" 'lsp-pyright--end-progress-callback))))
(setq-default post-command-hook
              (--filter (not (and (consp it)
                                  (eq (car it) 'closure)
                                  (not (-difference
                                        '(cancel-callback method buf hook workspaces id)
                                        (-map #'car (cadr it))))))
                        (default-value 'post-command-hook)))

(add-hook 'kill-buffer-hook
          (lambda ()
            (when (bound-and-true-p lsp-mode)
              (setq-default post-command-hook
                            (--filter (not (and (consp it)
                                                (eq (car it) 'closure)
                                                (not (-difference
                                                      '(cancel-callback method buf hook workspaces id)
                                                      (-map #'car (cadr it))))))
                                      (default-value 'post-command-hook))))))

(provide 'python)
;;; python.el ends here
