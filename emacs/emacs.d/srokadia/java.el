(defun on-java-load ()
  (eglot-ensure)
  )

(add-hook 'java-mode-hook (lambda () (on-java-load)))
