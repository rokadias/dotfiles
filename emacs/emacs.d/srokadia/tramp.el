(let ((process-environment tramp-remote-process-environment))
  (setenv "ENV" "$HOME/.profile")
  (setq tramp-remote-process-environment process-environment))
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
