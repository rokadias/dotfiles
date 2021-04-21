(require 'restclient)

(setq auto-mode-alist (append '(("\\.request$" . restclient-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.rest$" . restclient-mode)) auto-mode-alist))
