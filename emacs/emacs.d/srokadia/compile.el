(require 'cl)
(require 'compile)

(defun compile-override ()
  (interactive)
  (funcall compile-fun))

(setq compile-fun (lambda () (compile compile-command)))

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
