(defun on-java-load ()
  (lsp)
  )

(add-hook 'java-mode-hook (lambda () (on-java-load)))
