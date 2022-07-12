(require 'cl)
(require 'compile)

(defun compile-override ()
  (interactive)
  (funcall compile-fun)
  (sit-for 10000)
  (resize-compile-window)
  )

(setq compilation-removal-modes '("compilation-mode" "grep-mode" "shell-mode" "help-mode"))

(defun mode-buffer-matches-buffer-p (buffer matching-modes)
  (if (local-variable-p 'major-mode buffer)
      (seq-some
       (lambda (mode) (string-equal (buffer-local-value 'major-mode buffer) mode))
       compilation-removal-modes)
    nil)
  )

(defun remove-compile-windows (&optional removing-modes)
  (interactive)
  (let* ((modes (or removing-modes compilation-removal-modes))
         (all-window-buffers (seq-map #'window-buffer (window-list)))
         (is-remove-compile (lambda (buffer) (mode-buffer-matches-buffer-p buffer modes)))
         (compile-window-buffers (seq-filter is-remove-compile all-window-buffers))
         (compile-windows (seq-map #'get-buffer-window compile-window-buffers)))
    (seq-map #'delete-window compile-windows))
  )

(defun remove-compile-window ()
  (interactive)
  (remove-compile-windows '("compilation-mode"))
  )

(defun resize-compile-window ()
  (let* ((cw (get-buffer-window "*compilation*"))
         (h (window-height cw)))
    (when cw
      (fit-window-to-buffer cw 20 10)))
  )

(setq compile-fun
  (lambda ()
    (if (and (boundp 'project-directory) project-directory)
        (let ((default-directory project-directory))
          (pushnew project-directory compilation-search-path)
          (message "Running with default-directory")
          (compile compile-command)
          )
      (compile compile-command))))

(defun compile-pkg (&optional directory command)
  "Compile a package, moving up to the parent directory
  containing configure.ac, if it exists. Start in startdir if defined,
  else start in the current directory."
  (setq command (if command command compile-command))

  ; We've now worked out where to start. Now we need to worry about
  ; calling compile in the right directory
  (save-excursion
    (setq dir-buffer (find-file-noselect directory))
    (set-buffer dir-buffer)
    (message command)
    (compile command)
    (kill-buffer dir-buffer)))

(defun compile-override-hook ()
  (progn
    (if (not (or (get-buffer-window "*compilation*" t)
                 (get-buffer-window "*grep*" t)
                 (get-buffer-window "*Cargo Test*" t)
                 (get-buffer-window "*Cargo Build*" t)))
        (progn
          (if (get-buffer-window "*compilation*") (resize-compile-window))
          )
      )
    )
  )

(add-hook 'compilation-mode-hook 'compile-override-hook)

(defvar my-compilation-exit-code nil)
(defun my-compilation-exit-message-function (status_ code message)
  (message (concat "Compilation Exit Code: " (number-to-string code)))
  (setq my-compilation-exit-code code)
  (cons message code)
  )
(setq compilation-exit-message-function 'my-compilation-exit-message-function)

(require 'notifications)
(defun notify-compilation-result(buffer msg)
  "Notify that the compilation is finished,
close the *compilation* buffer if the compilation is successful,
and set the focus back to Emacs frame"
  (if (and (eq my-compilation-exit-code 0) (string-match "^finished" msg))
    (progn
     (resize-compile-window)
     (notifications-notify :title (concat (buffer-name buffer) " Finished") :body "Successful!! :-)")
     (unless (string= (buffer-name buffer) "*grep*")
       (remove-compile-window)))
    (progn
      (notifications-notify :title (concat (buffer-name buffer) " Finished") :body "Failure, go take a look!")
      (select-window (get-buffer-window buffer))))
  (setq current-frame (car (car (cdr (current-frame-configuration)))))
  (select-frame-set-input-focus current-frame)
  )

(add-to-list 'compilation-finish-functions
	     'notify-compilation-result)

(defun compile-markdown-mode()
  (let ((project-file (find-project-file "Makefile")))
    (when project-file
      (set (make-local-variable 'project-file) project-file)
      (set (make-local-variable 'project-directory) (file-name-directory project-file))
      (progn (message "Found project file at %s" project-file)
             (when is-cygwin
               (setq project-file (concat "$(cygpath -aw " project-file ")"))))
      (set (make-local-variable 'compile-command) "make"))))

(add-hook 'markdown-mode-hook #'compile-markdown-mode)
