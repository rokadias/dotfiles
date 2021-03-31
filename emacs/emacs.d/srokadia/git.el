(defun vc-git-checkout-branch (arg)
  (interactive "sNew Branch Name: ")
  (shell-command (concat "git checkout -b " arg)))

(defun vc-git-rebase ()
  (interactive)
  (async-shell-command "EDITOR='emacsclient -c' git rebase -i origin/master"))

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
