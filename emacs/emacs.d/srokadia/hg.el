;; mercurial
(require 'vc-hg)

(defun hg-pull (&optional arg)
  (interactive "P")
  (shell-command
   (concat "hg pull" (if arg "" " -u") "&")))

(global-set-key [(control x) ?v ?w] '(lambda () (interactive) (shell-command "hg view&")))
(global-set-key [(control x) ?v ?>] '(lambda () (interactive) (shell-command "hg push&")))
(global-set-key [(control x) ?v ?.] '(lambda () (interactive) (shell-command "hg out&")))
(global-set-key [(control x) ?v ?<] 'hg-pull)
(global-set-key [(control x) ?v ?\,] '(lambda () (interactive) (shell-command "hg in&")))

(defun vc-hg-annotate-command (file buffer &optional revision)
  "Execute \"hg annotate\" on FILE, inserting the contents in BUFFER. Optional arg REVISION is a revision to annotate from."
  (vc-hg-command buffer 0 file "blame"
                 (when revision (concat "-r" revision))))

(defun vc-hg-view ()
  (interactive)
  (let ((paths (vc-hg-paths)))
    (when paths
      (let ((file-url (vc-hg-view-url paths)))
        (kill-new file-url)
        (browse-url file-url)))))

(defun vc-hg-view-url (paths)
  (vc-hg-file-operation-url paths "file"))

(defun vc-hg-blame ()
  (interactive)
  (let ((paths (vc-hg-paths)))
    (when paths
      (let ((file-url (vc-hg-blame-url paths)))
        (kill-new file-url)
        (browse-url file-url)))))

(defun vc-hg-blame-url (paths)
  (vc-hg-file-operation-url paths "annotate"))

(defun vc-hg-file-operation-url (paths operation)
  (concat paths
          "/"
          operation
          "/"
          (vc-hg-get-current-changeset-hash)
          (vc-hg-get-relative-path)
          "#l"
          (number-to-string (count-lines 1 (point)))))

(defun vc-hg-paths ()
  (let ((paths (shell-command-to-string "hg paths")))
    (if (string-match "default" paths)
        (string-trim (replace-regexp-in-string "default\s*=\s*" "" paths))
      nil)))

(defun vc-hg-get-current-changeset-hash ()
  (let ((qparent (retrieve-changeset-hash (shell-command-to-string "hg log -r qparent"))))
    (if qparent
        qparent
        (retrieve-changeset-hash (shell-command-to-string "hg identify")))))

(defun vc-hg-get-relative-path ()
  (let ((root (string-trim (shell-command-to-string "hg root"))))
    (replace-regexp-in-string
       "\\\\"
       "/"
       (replace-regexp-in-string root "" buffer-file-name))))

(defun retrieve-changeset-hash (text)
  (let ((re-changeset ".*\\([a-f0-9]\\{12\\}\\)\\(.*\n.*\\)*"))
    (if (string-match re-changeset text)
        (string-trim (replace-regexp-in-string re-changeset "\\1" text))
      nil)))
