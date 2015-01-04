(setq uid "srokadia")
(setq elisp-root (concat "~/.emacs.d/" uid))

(setq custom-file (concat elisp-root "/custom.el"))
(load custom-file 'noerror)

(let ((default-directory (expand-file-name "~/.emacs.d/lisp/") ))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(dolist (library
         '("package" "generalfunctions" "theme" "global" "bindings"
           "progmodefunctions" "erc" "powershell"
           "yasnippet" "csharp" "html" "javascript" "hg"))
  (load (concat uid "/" library)))

;; assume files in the private directory are order-independent, and
;; load them all
(let ((private-root (concat elisp-root "/private" )))
  (when (file-exists-p private-root)
    (dolist (library (directory-files private-root nil "\\.el$"))
      (load (concat uid "/private/" (file-name-sans-extension library))))))
