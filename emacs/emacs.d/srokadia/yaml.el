(setq auto-mode-alist (append '(("\\.sls$" . yaml-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.jinja$" . yaml-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.yaml.template$" . yaml-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.markdown.template$" . markdown-mode)) auto-mode-alist))

(when (auth-source-search :host "codestats.net")
  (add-hook 'yaml-mode-hook #'code-stats-mode))
