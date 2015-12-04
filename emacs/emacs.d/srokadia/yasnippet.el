(when (package-installed-p 'yasnippet)

  (yas-global-mode 1)

  (setq yas/prompt-functions '(yas/ido-prompt yas/dropdown-prompt yas/completing-prompt yas/x-prompt yas/no-prompt)))

(setq yasnippets-root (concat emacs-dir-root "snippets/"))
