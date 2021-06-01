;; all things javascript
;; Use lexical-binding because it's awesome and will help
;; with closures to keep values when defined.
(set (make-local-variable 'lexical-binding) t)

(autoload 'js2-mode "js2-mode" "JavaScript editing mode" t)
(setq auto-mode-alist (append '(("\\.js$" . js2-mode)) auto-mode-alist))
(setq ac-js2-evaluate-calls t)

(setq js-indent-level 2
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
       (yas/load-directory js2-snippets)
       (add-to-list 'ac-sources 'ac-source-yasnippet))))

(eval-after-load "compile"
  '(setq compilation-error-regexp-alist
         (append '(("ERROR in \\([^\n]+\\)\n\\s-*\\[\\([0-9]+\\),\\s-*\\([0-9]+\\)\\].*" 1 2 3))
                 compilation-error-regexp-alist)))

(add-hook 'js2-mode-hook 'on-javascript-loaded)
(add-hook 'js2-mode-hook 'comment-fill-mode-hook)

;; Typescript setup
(defun setup-tide-mode ()
  (interactive)
  (unless (string-match-p "\*[^\*]+\*" (buffer-name (current-buffer)))
    (tide-setup)
    (lsp)
    (prettier-js-mode +1)
    (flycheck-mode +1)
    (flycheck-add-next-checker 'typescript-tide '(t . typescript-tslint) 'append)
    (setq flycheck-javascript-eslint-executable "eslint_d")
    (eldoc-mode +1)
    (company-mode +1)
    (set (make-local-variable 'company-backends) '(company-tide company-yasnippet company-semantic company-dabbrev-code company-gtags company-etags company-keywords company-dabbrev))
    (eslintd-fix-mode)
    (let ((project-file (find-project-file "package.json")))
      (when project-file
        (set (make-local-variable 'project-file) project-file)
        (set (make-local-variable 'project-directory) (file-name-directory project-file))
        (progn (message "Found project file at %s" project-file)
               (when is-cygwin
                 (setq project-file (concat "$(cygpath -aw " project-file ")")))
               (set (make-local-variable 'compile-command) "npm run build" ))))))

(setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log"))

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'jsx-mode-hook #'setup-tide-mode)
(add-hook 'js2-mode-hook #'setup-tide-mode)
(add-hook 'js-mode-hook #'setup-tide-mode)
(add-hook 'js-mode-hook #'semantic-mode)

(use-package lsp-mode
  :hook (web-mode . lsp)
  :custom
  (lsp-clients-typescript-server-args '("--stdio" "--tsserver-log-file" "/dev/stderr")))
