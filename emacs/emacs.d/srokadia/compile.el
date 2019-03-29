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
    (shrink-window (- h 15))
    (select-window cur)
    )
  )

(setq compile-fun
      (lambda ()
        (when project-directory
          (pushnew project-directory compilation-search-path))
        (compile compile-command)))

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
                 (get-buffer-window "*Cargo Test*" t)
                 (get-buffer-window "*Cargo Build*" t)))
        (progn
          (split-window-vertically)
          )
      )
    )
  )

(add-hook 'compilation-mode-hook 'compile-override-hook)
