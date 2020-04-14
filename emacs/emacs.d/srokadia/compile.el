(require 'cl)
(require 'compile)

(defun compile-override ()
  (interactive)
  (funcall compile-fun)
  (resize-compile-window)
  )

(defun remove-compile-window ()
  (interactive)
  (let* ((cur (selected-window))
         (cw (get-buffer-window "*compilation*")))
    (if cw (delete-window cw))
    )
  )

(defun resize-compile-window ()
  (let* ((cur (selected-window))
         (cw (get-buffer-window "*compilation*"))
         (h (window-height cw)))
    (select-window cw)
    (shrink-window (- h 40))
    (select-window cur)
    )
  )

(setq compile-fun
  (lambda ()
    (message (format "Running compile-fun with %s" project-directory))
    (if project-directory
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

(defun notify-compilation-result(buffer msg)
  "Notify that the compilation is finished,
close the *compilation* buffer if the compilation is successful,
and set the focus back to Emacs frame"
  (if (string-match "^finished" msg)
    (progn
     (resize-compile-window)
     (tooltip-show "\n Compilation Successful :-) \n "))
    (tooltip-show "\n Compilation Failed :-( \n "))
  (setq current-frame (car (car (cdr (current-frame-configuration)))))
  (select-frame-set-input-focus current-frame)
  )

(add-to-list 'compilation-finish-functions
	     'notify-compilation-result)
