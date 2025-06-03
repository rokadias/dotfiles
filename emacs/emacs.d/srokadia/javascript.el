;; all things javascript
;; Use lexical-binding because it's awesome and will help
;; with closures to keep values when defined.
(set (make-local-variable 'lexical-binding) t)

(autoload 'js2-mode "js2-mode" "JavaScript editing mode" t)
(setq auto-mode-alist (append '(("\\.js$" . js2-mode)) auto-mode-alist))

(setq js-indent-level 2
      typescript-indent-level 2
      js2-basic-offset 2
      js2-bounce-indent-flag t
      js2-cleanup-whitespace nil
      js2-enter-indents-newline nil
      js2-highlight-level 3
      js2-mirror-mode nil
      js2-rebind-eol-bol-keys nil
      js2-use-font-lock-faces t)

(defun on-javascript-loaded ()
  (when (package-installed-p 'js-comint)
    (require 'js-comint)
    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
    (local-set-key "\C-cb" 'js-send-buffer)
    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
    (local-set-key "\C-c\C-r" 'js-send-region)
    (local-set-key "\C-cl" 'js-load-file-and-go))
  (setq show-trailing-whitespace t)
  (let ((project-file (find-project-file "package.json")))
    (when project-file
      (progn (message "Found project file at %s" project-file)
             (when is-cygwin
               (setq project-file (concat "$(cygpath -aw " project-file ")")))
             (set (make-local-variable 'compile-command) "npm run build" )))))

(eval-after-load "js2-mode"
  '(let ((js2-snippets (concat yasnippets-root "js2-mode")))
     (when (file-exists-p js2-snippets)
       (add-to-list 'load-path js2-snippets)
       (yas/load-directory js2-snippets))))

(eval-after-load "compile"
  '(setq compilation-error-regexp-alist
         (append '(("ERROR in \\([^\n]+\\)\n\\s-*\\[\\([0-9]+\\),\\s-*\\([0-9]+\\)\\].*" 1 2 3))
                 compilation-error-regexp-alist)))

(add-hook 'js2-mode-hook 'on-javascript-loaded)
(add-hook 'js2-mode-hook 'comment-fill-mode-hook)

(defun set-rush-compile-command ()
  "Set the rush compile command which is just check if there's a rush.json."
  (let ((project-build-file (find-project-file "rush.json")))
    (when project-build-file
      (let* ((project-file (find-project-file "rush.json"))
             (project-dir (directory-parent project-file)))
        (message "Found build file at %s and workspace at %s" project-file project-dir)
        (set (make-local-variable 'project-directory) project-dir)
        (set (make-local-variable 'compile-command) (concat "source ~/.nvm/nvm.sh && nvm use 18.16.1 && rush lint && rush build && rush format" ))))))

(defun rush-compile-run-test ()
  (interactive)
  (let* ((project-build-file (find-project-file "package.json"))
         (project-build-dir (directory-parent project-build-file)))
    (message "Found build file for test at %s with directory at %s" project-build-file project-build-dir)
    (set (make-local-variable 'project-directory) project-build-dir)
    (set (make-local-variable 'compile-command) (concat "source ~/.nvm/nvm.sh && nvm use 18.16.1 && rushx test"))
    (compile-override)
    (set-rush-compile-command)
    )
  )

;; Typescript setup
(defun setup-tide-mode ()
  (interactive)
  (unless (or (string-match-p "\*[^\*]+\*" (buffer-name (current-buffer))) (derived-mode-p 'json-mode))
    (tide-setup)
    (lsp)
    (prettier-js-mode +1)
    (flycheck-mode +1)
    (flycheck-add-next-checker 'typescript-tide '(t . typescript-tslint) 'append)
    (setq flycheck-javascript-eslint-executable "eslint_d")
    (eldoc-mode +1)
    (company-mode +1)
    (set (make-local-variable 'company-backends) '(company-tide company-yasnippet company-dabbrev-code company-gtags company-etags company-keywords company-dabbrev))
    (let ((project-file (find-project-file "package.json")))
      (when project-file
        (set (make-local-variable 'project-file) project-file)
        (set (make-local-variable 'project-directory) (file-name-directory project-file))
        (progn (message "Found project file at %s" project-file)
               (when is-cygwin
                 (setq project-file (concat "$(cygpath -aw " project-file ")")))
               (set (make-local-variable 'compile-command) "npm run build" ))))
    (set-rush-compile-command)
    (define-key typescript-mode-map (kbd "M-M") 'rush-compile-run-test)))

(setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log"))

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'jsx-mode-hook #'setup-tide-mode)
(add-hook 'js2-mode-hook #'setup-tide-mode)
(add-hook 'js-mode-hook #'setup-tide-mode)

(use-package lsp-mode
  :hook (web-mode . lsp)
  :custom)
(setq lsp-disabled-clients '(eslint))

(require 'tree-sitter)
(define-derived-mode typescriptreact-mode typescript-mode "Typescript TSX")
(add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescriptreact-mode))
;; by default, typescript-mode is mapped to the treesitter typescript parser
;; use our derived mode to map both .tsx AND .ts -> typescriptreact-mode -> treesitter tsx
(add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx))

(add-hook 'typescript-mode-hook #'setup-tide-mode)
