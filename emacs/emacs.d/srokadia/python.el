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
      (setq py-isort-options (concat "--settings-path " project-file))))
  (set-check-python-compile-command))
(add-hook 'python-mode-hook #'on-python-load)

(setq python-indent-def-block-scale 1)

(with-eval-after-load "semantic/idle"
  (advice-add 'semantic-idle-scheduler-function :around #'ignore))

(defun python-get-file-path ()
  (let* ((filename (get-file-name))
         (lsp-root (lsp--calculate-root (lsp-session) buffer-file-name))
         (lsp-root-path (file-name-as-directory lsp-root)))
    (replace-regexp-in-string lsp-root-path "" filename))
  )

(defun python-get-library-path ()
  (replace-regexp-in-string "/" "." (replace-regexp-in-string ".py" "" (python-get-file-path)))
  )

(defun python-copy-get-library-path ()
  "Copy the current buffer file name to the clipboard as a libary path."
  (interactive)
  (let ((library-path (python-get-library-path)))
    (when library-path
      (kill-new library-path)
      (message "Copied library path '%s' to the clipboard." library-path))))

(defun python-copy-get-file-path ()
  "Copy the current buffer file name to the clipboard as a libary path."
  (interactive)
  (let ((file-path (python-get-file-path)))
    (when file-path
      (kill-new file-path)
      (message "Copied file path '%s' to the clipboard." file-path))))

(defun set-check-python-compile-command ()
  "Set the python compile command which is just check mypy."
  (let* ((project-file (find-project-file "^mypy\\.ini$"))
         (project-parent-dir (directory-parent (directory-parent project-file)))
         (check-python-dir (file-name-as-directory (concat (file-name-as-directory project-parent-dir) "scripts")))
         (check-python-file (car (directory-files-match check-python-dir "^check_python\\.sh$"))))
    (when (and check-python-file (file-exists-p check-python-file))
      (message "Found project file at %s and check-python at %s" project-file check-python-file)
      (set (make-local-variable 'project-directory) project-parent-dir)
      (set (make-local-variable 'compile-command) (concat check-python-file " --nobuild" " --skip-sdk" " | sed -e 's/\\x1b\\[[0-9;]*m//g'")))))
