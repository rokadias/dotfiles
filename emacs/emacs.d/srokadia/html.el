(setq auto-mode-alist (append '(("\\.aspx$" . html-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.ascx$" . html-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.html$" . html-mode)) auto-mode-alist))

(defun on-nxml-loaded ()
  (setq show-trailing-whitespace t))

(add-hook 'nxml-mode-hook 'on-nxml-loaded)
(add-hook 'html-mode-hook 'on-nxml-loaded)

(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(add-hook 'web-mode-hook 'my-web-mode-hook)
