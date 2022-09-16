(require 'vc)
(defun vc-git-checkout-branch (retrieve-arg arg)
  (interactive "P\nsNew Branch Name: ")
    (let* ((working-files (shell-command-to-string "git status --porcelain -uno")))
      (when (> (length working-files) 1) (vc-git-stash "vc-git-checkout-branch"))
      (when retrieve-arg (vc-git-retrieve-main-branch))
      (sleep-for 10)
      (shell-command (concat "git checkout -b " arg (if retrieve-arg (concat " origin/" (vc-git-main-branch)) "")))
      (vc-retrieve-tag (string-trim (shell-command-to-string "git rev-parse --show-toplevel")) arg)
      (when (> (length working-files) 1) (vc-git-stash-pop "0"))))

(defun vc-git-main-branch ()
  (let* ((remote (shell-command-to-string "git remote show origin | grep 'HEAD branch:'")))
    (replace-regexp-in-string ".*HEAD branch: \\([^ ]*\\).*\n" "\\1" remote)))

(defun vc-git--sync-pushpull (command extra-args)
  (let* ((root (vc-git-root default-directory))
	 (buffer (format "*vc-git : %s*" (expand-file-name root)))
	 (git-program vc-git-program)
         ;; Make a copy of the args so that we can alter it
         (full-args (append extra-args nil)))
    (add-to-list 'full-args command)
    (apply #'vc-git-command buffer 0 nil full-args)
    (with-current-buffer buffer
      (vc-run-delayed
        (vc-compilation-mode 'git)
        (setq-local compile-command
                    (concat git-program " " command " "
                            (mapconcat #'identity extra-args " ")))
        (setq-local compilation-directory root)
        ;; Either set `compilation-buffer-name-function' locally to nil
        ;; or use `compilation-arguments' to set `name-function'.
        ;; See `compilation-buffer-name'.
        (setq-local compilation-arguments
                    (list compile-command nil
                          (lambda (_name-of-mode) buffer)
                          nil))))
    (vc-set-async-update buffer)))

(defun vc-git-retrieve-main-branch ()
  (interactive)
  (vc-git--sync-pushpull "fetch" (list "origin" (vc-git-main-branch)))
  (when (and (get-buffer-window "*vc-git*") (> (length (window-list)) 1))
    (delete-window (get-buffer-window "*vc-git*"))))

(defun vc-git-rebase ()
  (interactive)
  (let* ((working-files (shell-command-to-string "git status --porcelain -uno"))
         (branch (vc-git--current-symbolic-ref (buffer-file-name (current-buffer)))))
    (when (> (length working-files) 1) (vc-git-stash "vc-git-checkout-branch"))
    (vc-git-retrieve-main-branch)
    (async-shell-command (concat "EDITOR='emacsclient -c' git rebase -i origin/" (vc-git-main-branch)))
    (when (> (length working-files) 1) (vc-git-stash-pop "0"))
  ))

(defun vc-git-rebase-continue ()
  (interactive)
    (async-shell-command (concat "EDITOR='emacsclient -c' git rebase --continue")))

(defun vc-git-rebase-abort ()
  (interactive)
    (async-shell-command (concat "EDITOR='emacsclient -c' git rebase --abort")))

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
  (let* ((working-files (shell-command-to-string "git status --porcelain -uno"))
         (branch (vc-git--current-symbolic-ref (buffer-file-name (current-buffer)))))
    (when (> (length working-files) 1) (vc-git-stash "vc-git-checkout-branch"))
    (vc-git-retrieve-main-branch)
    (async-shell-command (concat "EDITOR='emacsclient -c' git merge origin/" (vc-git-main-branch)))
    (when (> (length working-files) 1) (vc-git-stash-pop "0"))
  ))

(defun vc-git-new-push (prompt)
  (let* ((branch (vc-git--current-symbolic-ref (buffer-file-name (current-buffer))))
         (extra-args (list "--set-upstream" "origin" branch)))
    (when prompt (add-to-list 'extra-args "--force"))
    (vc-git--pushpull "push" nil extra-args)))

(advice-add 'vc-git-push :override #'vc-git-new-push)

(defun vc-git-compile-buffer-successful-p (buffer)
  (with-current-buffer buffer
    (save-excursion
      (goto-char (point-max))
      (save-match-data
        (re-search-backward "Running \"[^\"]*\"" nil t 1)
        (and
         (not (re-search-forward "fatal" nil t 1))
         (not (re-search-forward "error" nil t 1))
         (not (re-search-forward "rejected" nil t 1))))))
  )

(require 'notifications)
(defun vc-git-close-if-succesful(a b c)
  (let* ((starts-with-vc-git (lambda (buffer) (string-prefix-p "*vc-git" (buffer-name buffer))))
         (all-window-buffers (seq-map #'window-buffer (window-list)))
         (vc-git-buffers (seq-filter starts-with-vc-git all-window-buffers)))

    (dolist (buffer vc-git-buffers)
      (if (and (vc-git-compile-buffer-successful-p buffer) (> (length (window-list)) 1))
          (progn
            (notifications-notify :title "VC GIT" :body "Git Command SUCCESSFUL!")
            (delete-window (get-buffer-window buffer)))
        (select-window (get-buffer-window buffer)))
      ))
  )
(add-hook 'vc-post-command-functions #'vc-git-close-if-succesful)

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
          (number-to-string (get-current-line-number))))

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
