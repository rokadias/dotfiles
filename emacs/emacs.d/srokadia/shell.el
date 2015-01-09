(when is-w32
  (setq explicit-shell-file-name "C:/cygwin/bin/bash.exe")
  (setq shell-file-name "C:/cygwin/bin/bash.exe")

  (defun my-shell-setup ()
    "For Cygwin bash under Emacs 20"
    (setq comint-scroll-show-maximum-output 'this)
    (make-variable-buffer-local 'comint-completion-addsuffix))

  (setq comint-completion-addsuffix t)
  ;; (setq comint-process-echoes t) ;; reported that this is no longer needed
  (setq comint-eol-on-send t)
  (setq w32-quote-process-args ?\")
  (setq shell-mode-hook 'my-shell-setup))
