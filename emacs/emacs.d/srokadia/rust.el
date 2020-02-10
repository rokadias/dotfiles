(setq racer-cmd "/usr/bin/racer")
(setq racer-rust-src-path "~/OpenSource/rust/rust/src")


(setq lsp-rust-server 'rust-analyzer)
(require 'lsp)
(require 'lsp-rust)
(load-uid-library '("ra-emacs-lsp"))

(add-hook 'rust-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'company-mode)
(add-hook 'rust-mode-hook #'cargo-minor-mode)
