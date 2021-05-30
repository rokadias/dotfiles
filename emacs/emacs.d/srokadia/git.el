(require 'vc)
(defun vc-git-checkout-branch (retrieve-arg arg)
  (interactive "P\nsNew Branch Name: ")
  (when retrieve-arg
    (let* ((working-files (shell-command-to-string "git status --porcelain")))
      (when (> (length working-files) 1) (vc-git-stash "vc-git-checkout-branch"))
      (vc-git-retrieve-main-branch)
      (when (> (length working-files) 1) (vc-git-stash-pop "0"))
      ))
  (shell-command (concat "git checkout -b " arg)))

(defun vc-git-main-branch ()
  (let* ((remote (shell-command-to-string "git remote show origin | grep 'HEAD branch:'")))
    (replace-regexp-in-string ".*HEAD branch: \\([^ ]*\\).*\n" "\\1" remote)))

(defun vc-git-retrieve-main-branch ()
  (interactive)
  (vc-retrieve-tag (vc-root-dir) (vc-git-main-branch))
  (vc-pull)
  (when (get-buffer-window "*vc-git*")
    (delete-window (get-buffer-window "*vc-git*"))))

(defun vc-git-rebase ()
  (interactive)
  (let* ((working-files (shell-command-to-string "git status --porcelain")))
    (when (> (length working-files) 1) (vc-git-stash "vc-git-checkout-branch"))
    (vc-pull)
    (async-shell-command (concat "EDITOR='emacsclient -c' git rebase -i origin/" (vc-git-main-branch)))
    (when (> (length working-files) 1) (vc-git-stash-pop "0"))
  ))

(defun vc-git-merge-continue ()
  (interactive)
    (async-shell-command (concat "EDITOR='emacsclient -c' git merge --continue")))

(defun vc-git-merge-abort ()
  (interactive)
    (async-shell-command (concat "EDITOR='emacsclient -c' git merge --abort")))

(defun vc-git-add-manually ()
  (interactive)
  (shell-command (concat "git add " (buffer-file-name (current-buffer)))))

(defun vc-git-merge-main-branch ()
  (interactive)
  (let* ((working-files (shell-command-to-string "git status --porcelain")))
    (when (> (length working-files) 1) (vc-git-stash "vc-git-checkout-branch"))
    (vc-pull)
    (async-shell-command (concat "EDITOR='emacsclient -c' git merge origin/" (vc-git-main-branch)))
    (when (> (length working-files) 1) (vc-git-stash-pop "0"))
  ))

(defun vc-git-new-push (prompt)
  (let* ((branch (vc-git--current-symbolic-ref (buffer-file-name (current-buffer))))
         (extra-args (list "--set-upstream" "origin" branch)))
    (when prompt (add-to-list 'extra-args "--force"))
    (vc-git--pushpull "push" nil extra-args)))

(advice-add 'vc-git-push :override #'vc-git-new-push)

(defun vc-git--current-symbolic-ref (file)
  (let* (process-file-side-effects
         (str (vc-git--run-command-string nil "symbolic-ref" "HEAD"))
         (short-hand (vc-git--short-ref-from-full-ref str)))
    (when (not (string-match-p (regexp-quote "vc-dir") (buffer-name)))
        (vc-file-setprop file 'vc-git-symbolic-ref short-hand))
      short-hand))

(defun vc-git--short-ref-from-full-ref (str)
  (if str
    (if (string-match "^\\(refs/heads/\\)?\\(.+\\)$" str)
        (match-string 2 str)
      str)))

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

(defun vc-new-github-pr ()
  (interactive)
  (let* ((branch (vc-git--current-symbolic-ref (buffer-file-name (current-buffer))))
         (remote (vc-git-remote))
         (new-pr-url (concat remote "/pull/new/" branch)))
    (kill-new new-pr-url)
    (browse-url new-pr-url)
  ))

(require 'ghub)
(require 'github-notifier)
(setq github-notifier-token (ghub--token "api.github.com" "rokadias" "github-review"))
(github-notifier-mode 1)
