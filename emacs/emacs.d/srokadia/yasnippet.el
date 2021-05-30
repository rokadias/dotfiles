(require 'yasnippet)
(when (package-installed-p 'yasnippet)

  (yas-global-mode 1)
  ;; (when (symbolp 'warning-suppress-types)
  ;;   (add-to-list 'warning-suppress-types '(yasnippet backquote-change)))

  (setq yas/prompt-functions '(yas/ido-prompt yas/dropdown-prompt yas/completing-prompt yas/x-prompt yas/no-prompt)
        yas-indent-line 'auto))
