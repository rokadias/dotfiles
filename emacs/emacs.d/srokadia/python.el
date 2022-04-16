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

(defun python-get-library-path ()
  (interactive)
  (let* ((filename (get-file-name))
         (lsp-root (lsp--calculate-root (lsp-session) buffer-file-name))
         (lsp-root-path (file-name-as-directory lsp-root)))
    (replace-regexp-in-string "/" "." (replace-regexp-in-string ".py" "" (replace-regexp-in-string lsp-root-path "" filename))))
  )

(defun python-copy-get-library-path ()
  "Copy the current buffer file name to the clipboard as a libary path."
  (interactive)
  (let ((library-path (python-get-library-path)))
    (when library-path
      (kill-new library-path)
      (message "Copied library path '%s' to the clipboard." library-path))))
