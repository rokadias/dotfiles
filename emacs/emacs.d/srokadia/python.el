;; (require 'lsp-python-ms)
;; (setq lsp-python-ms-executable "~/OpenSource/python-language-server/output/bin/Release/linux-x64/publish/Microsoft.Python.LanguageServer")

(defun on-python-load ()
  (require 'importmagic)
  (require 'lsp-pyright)
  (require 'python-black)
  (require 'python-isort)
  (lsp)
  (company-mode nil)
  (python-black-on-save-mode)
  (python-isort-on-save-mode)
  (importmagic-mode)
  (let ((project-file (find-project-file "\\.isort.cfg$")))
    (when project-file
      (make-local-variable 'py-isort-options)
      (setq py-isort-options (concat "--settings-path " project-file)))))
(add-hook 'python-mode-hook #'on-python-load)

(setq python-indent-def-block-scale 1)

(with-eval-after-load "semantic/idle"
  (advice-add 'semantic-idle-scheduler-function :around #'ignore))
