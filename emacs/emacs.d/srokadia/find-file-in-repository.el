(when (package-installed-p 'find-file-in-repository)
  (require 'find-file-in-repository)
  (when is-w32
    (defun ffir-shell-command (command file-separator working-dir)
      "Executes 'command' and returns the list of printed files in
   the form '((short/file/name . full/path/to/file) ...). The
   'file-separator' character is used to split the file names
   printed by the shell command and is usually set to \\n or \\0"
      (let ((command-output (shell-command-to-string
                             (format "cd %s && %s"
                                     (shell-quote-argument working-dir) command))))
        (let ((files (delete "" (split-string command-output file-separator))))
          (mapcar (lambda (file)
                    (cons file (expand-file-name file working-dir)))
                  files)))))

  (defun ffir-ido-find-file-other-window (file-list)
    "Actually find file to open in other window, using ido."
    (add-hook 'ido-setup-hook 'ffir-ido-setup)
    (unwind-protect
        (let* ((file (ido-completing-read "Find file in repository: "
                                          (mapcar 'car file-list)))
               (path (or (cdr (assoc file file-list)) file)))
          (cond
           (file (find-file-other-window path))
           ((eq ido-exit 'fallback) (ido-find-file-other-window))))
      (remove-hook 'ido-setup-hook 'ffir-ido-setup)))

  (defun ffir-find-file (file-list)
  "Actually find file to open, without using ido."
  (let ((file (completing-read "Find file in repository: "
                               (mapcar 'car file-list))))
    (find-file-other-window (cdr (assoc file file-list)))))

  (defun find-file-in-repository-other-window ()
  "find-file-in-repository-other-window will autocomplete all files in the
   current git, mercurial or other type of repository, using
   ido-find-file-other-window when available. When the current file is not
   located inside of any repository, falls back on a regular
   find-file operation."
  (interactive)
  (let ((repo-directory (ffir-locate-dominating-file
                         default-directory
                         (lambda (directory)
                           (ffir-directory-contains-which-file
                            ffir-repository-types directory))))
        (home-dir (format "%s/" (getenv "HOME"))))
    ;; check whether we are in a supported repository type
    (if (and repo-directory
             (not (and ffir-avoid-HOME-repository
                       (equal (expand-file-name repo-directory)
                              (expand-file-name home-dir)))))
        ;; auto-complete files tracked by the repository system
        (let* ((repo-directory (expand-file-name repo-directory))
               (file-list (funcall (ffir-directory-contains-which-file
                                    ffir-repository-types repo-directory)
                                   repo-directory)))
          (funcall (ffir-when-ido 'ffir-ido-find-file-other-window 'ffir-find-file-other-window)
                   file-list))
      ;; fall back on regular find-file when no repository can be found
      (let ((find-file (ffir-when-ido 'ido-find-file-other-window 'find-file-other-window)))
        (command-execute find-file-other-window)))))
  )
