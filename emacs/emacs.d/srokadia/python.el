;; (require 'lsp-python-ms)
;; (setq lsp-python-ms-executable "~/OpenSource/python-language-server/output/bin/Release/linux-x64/publish/Microsoft.Python.LanguageServer")

(add-hook 'python-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'company-mode)
