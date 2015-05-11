(require 'restclient)

(setq auto-mode-alist (append '(("\\.request$" . restclient-mode)) auto-mode-alist))
