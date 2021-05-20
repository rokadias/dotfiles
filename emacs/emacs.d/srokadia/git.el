(defun vc-git-checkout-branch (arg)
  (interactive "sNew Branch Name: ")
  (shell-command (concat "git checkout -b " arg)))

(defun vc-git-main-branch ()
  (let* ((remote (shell-command-to-string "git remote show origin | grep 'HEAD branch:'")))
    (replace-regexp-in-string ".*HEAD branch: \\([^ ]*\\).*\n" "\\1" remote)))

(defun vc-git-rebase ()
  (interactive)
  (async-shell-command (concat "EDITOR='emacsclient -c' git rebase -i origin/" (vc-git-main-branch))))

(defun vc-git-push (prompt)
  (let* ((branch (vc-git--current-symbolic-ref (buffer-file-name (current-buffer))))
         (extra-args (list "--set-upstream" "origin" branch)))
    (when prompt (add-to-list 'extra-args "--force"))
    (vc-git--pushpull "push" nil extra-args)))

(defun vc-git--current-symbolic-ref (file)
  (let* (process-file-side-effects
         (str (vc-git--run-command-string nil "symbolic-ref" "HEAD")))
    (vc-file-setprop file 'vc-git-symbolic-ref
                     (if str
                         (if (string-match "^\\(refs/heads/\\)?\\(.+\\)$" str)
                             (match-string 2 str)
                           str)))))

(defun vc-git-view-kill ()
  (interactive)
  (let ((remote (vc-git-remote)))
    (when remote
      (let ((file-url (vc-git-view-url remote)))
        (kill-new file-url)))))

(defun vc-git-view ()
  (interactive)
  (let ((remote (vc-git-remote)))
    (when remote
      (let ((file-url (vc-git-view-url remote)))
        (kill-new file-url)
        (browse-url file-url)))))

(defun vc-git-view-url (remote)
  (vc-git-file-operation-url remote "tree"))

(defun vc-git-blame ()
  (interactive)
  (let ((remote (vc-git-remote)))
    (when remote
      (let ((file-url (vc-git-blame-url remote)))
        (kill-new file-url)
        (browse-url file-url)))))

(defun vc-git-blame-url (remote)
  (vc-git-file-operation-url remote "blame"))

(defun vc-git-file-operation-url (remote operation)
  (concat remote
          "/"
          operation
          "/master"
          (vc-git-get-relative-path)
          "#L"
          (number-to-string (count-lines 1 (point)))))

(defun vc-git-get-relative-path()
  (let* ((root (string-trim (shell-command-to-string "git rev-parse --show-toplevel")))
         (replaced-root (replace-regexp-in-string "\\\\" "/" root)))
    (replace-regexp-in-string replaced-root "" buffer-file-name)))

(defun vc-git-remote ()
  (let ((remotes (string-trim (shell-command-to-string "git remote get-url origin"))))
    (replace-regexp-in-string
     "\\.git"
     ""
     (replace-regexp-in-string "ssh" "https" remotes)
     )
    )
  )
