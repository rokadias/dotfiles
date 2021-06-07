;; (require 'lsp-python-ms)
;; (setq lsp-python-ms-executable "~/OpenSource/python-language-server/output/bin/Release/linux-x64/publish/Microsoft.Python.LanguageServer")

(defun on-python-load ()
  (require 'lsp-pyright)
  (lsp))
(add-hook 'python-mode-hook #'on-python-load)


(with-eval-after-load "semantic/idle"
  (advice-add 'semantic-idle-scheduler-function :around #'ignore))
