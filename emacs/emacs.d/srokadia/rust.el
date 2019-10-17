(setq racer-cmd "/usr/bin/racer")
(setq racer-rust-src-path "~/OpenSource/rust/rust/src")

(add-hook 'rust-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'lsp-mode)
(add-hook 'rust-mode-hook #'company-mode)
(add-hook 'rust-mode-hook #'cargo-minor-mode)
