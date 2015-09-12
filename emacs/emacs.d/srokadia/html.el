(setq auto-mode-alist (append '(("\\.aspx$" . nxml-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.ascx$" . nxml-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.html$" . nxml-mode)) auto-mode-alist))

(defun on-nxml-loaded ()
  (setq show-trailing-whitespace t))

(add-hook 'nxml-mode-hook 'on-nxml-loaded)

