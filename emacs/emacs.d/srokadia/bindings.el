;;; delete everything up to a certain char
(global-set-key [(meta z)] 'back-zap-to-char)

;;; Comment and uncomment regions
(global-set-key [?\C-#]      'comment-region)
(global-set-key [?\C-\M-#] 'uncomment-region)

;;; Scrolling
(defun down-three () (interactive) (scroll-down 3))
(defun up-three () (interactive) (scroll-up 3))
(global-set-key [mouse-4] 'down-three)
(global-set-key [mouse-5] 'up-three)

(global-set-key (kbd "M-m") 'compile-override)

(global-set-key [(control c) (r)] 'revert-buffer)

;; Remapping beginning-of-line
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key [(control a)] 'smart-beginning-of-line)

;; window movement
(global-set-key [(control x) (O)] 'reverse-other-window)
(global-set-key [(meta g) (b)] 'switch-to-window-buffer)

;; Emacs Forward, Back, Up, Down
(global-set-key [(control x) (F)] 'windmove-right)
(global-set-key [(control x) (B)] 'windmove-left)
(global-set-key [(control x) (P)] 'windmove-up)
(global-set-key [(control x) (N)] 'windmove-down)

;; Window Fiting
(global-set-key (kbd "C-x 7") 'fit-window-to-buffer)

;; Comparing
(global-set-key [(control c) (b)] 'ediff-buffers)

;; Find-in-files
(global-set-key [(control x) (control meta f)] 'find-file-in-repository)
(global-set-key [(control x) (control meta F)] 'find-file-in-repository-other-window)
(global-set-key [(control c) (control r)] 'rgrep)

;; Files/Buffers
(global-set-key (kbd "C-x C-S-b") 'rename-buffer)
(global-set-key (kbd "C-x C-S-v") 'rename-file)

;; org
(global-set-key [(control c) (l)] 'org-store-link)
(global-set-key [(control c) (a)] 'org-agenda)

(autoload 'omnisharp-mode "omnisharp-mode" "Minor mode for C# intellisense." t)
(require 'omnisharp)
;; omnisharp config
(define-key omnisharp-mode-map (kbd "C-; C-b") 'omnisharp-go-to-definition)
(define-key omnisharp-mode-map (kbd "C-; C-f") '(lambda () (interactive) (omnisharp-fix-usings) (sort-using-statements) (fix-namespace-curly-braces)))
(define-key omnisharp-mode-map (kbd "C-; C-k") 'omnisharp-find-usages-with-ido)
(define-key omnisharp-mode-map (kbd "C-; C-r") 'omnisharp-rename)
(define-key omnisharp-mode-map (kbd "C-; C-t") 'omnisharp-run-tests)
(define-key omnisharp-mode-map (kbd "C-; C-,") 'omnisharp-navigate-to-solution-file)
(define-key omnisharp-mode-map (kbd "C-; C-s") 'omnisharp-navigate-to-current-file-member)
(define-key omnisharp-mode-map (kbd "C-; C-.") 'omnisharp-current-type-information)
(define-key omnisharp-mode-map (kbd "C-; C-/") 'omnisharp-current-type-documentation)
(define-key omnisharp-mode-map (kbd "C-; C-SPC") 'omnisharp-auto-complete)

(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C-M-k") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M-j") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-k") 'mc/mark-all-like-this)

;; Helm mode config
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-M-/") 'helm-dabbrev)

;; ace-jump-mode
(global-set-key (kbd "C-M-SPC") 'ace-jump-mode)

;; uuidgen
(global-set-key (kbd "C-x g") '(lambda () (interactive) (insert (trim-string (shell-command-to-string "sequuid")))))

;; tide
(require 'tide)
(define-key tide-mode-map (kbd "C-; C-k") 'tide-references)
(define-key tide-mode-map (kbd "C-; C-r") 'tide-rename-symbol)

;; string-inter
(global-set-key (kbd "C-c C-u") 'string-inflection-underscore)

;; lsp (used by rust)
(require 'lsp)
(define-key lsp-mode-map (kbd "C-; C-.") 'lsp-describe-thing-at-point)
(define-key lsp-mode-map (kbd "C-; C-b") 'lsp-goto-implementation)
(define-key lsp-mode-map (kbd "C-; C-k") 'lsp-find-references)
(define-key lsp-mode-map (kbd "C-; C-r") 'lsp-rename)
(define-key lsp-mode-map (kbd "C-; C-i") 'lsp-execute-code-action)

(require 'rust-mode)
(define-key rust-mode-map (kbd "C-c C-l") 'flymake-show-diagnostics-buffer)
(define-key rust-mode-map (kbd "C-c C-n") 'flymake-goto-next-error)
(define-key rust-mode-map (kbd "C-c C-p") 'flymake-goto-prev-error)

;; Presenting in screenshare
(global-set-key (kbd "C-x <C-M-return>") '(lambda () (interactive) (text-scale-adjust 2)))

;; VC commands
(require 'vc)
(defun custom-git-bindings ()
  (global-set-key (kbd "C-x v w") 'vc-git-checkout-branch)
  (global-set-key (kbd "C-x v .") 'vc-git-rebase)
  (global-set-key (kbd "C-x v o") 'vc-git-retrieve-main-branch)
  (global-set-key (kbd "C-x v a") 'vc-git-add-manually)
  (global-set-key (kbd "C-x v >") 'vc-git-merge-main-branch)
  (global-set-key (kbd "C-x v ,") 'vc-git-merge-continue)
  (global-set-key (kbd "C-x v k") 'vc-git-merge-abort))
  (global-set-key (kbd "C-x v n") 'vc-new-github-pr)
(custom-git-bindings)
(with-eval-after-load 'vc (custom-git-bindings))

;; browser
(global-set-key (kbd "C-x g") 'eww)
(global-set-key (kbd "C-x <C-return>") 'browse-url)
(global-set-key (kbd "C-x <C-S-return>") 'browse-url-of-file)

;; terminal
(require 'term)
(define-key term-mode-map (kbd "C-c C-y") 'term-paste)
(global-set-key (kbd "<M-S-return>") '(lambda (newname) (interactive "sBuffer Name:") (term "/bin/zsh") (rename-buffer newname)))

;; restclient
(require 'restclient)
(define-key restclient-mode-map (kbd "M-p") 'restclient-jump-prev)
(define-key restclient-mode-map (kbd "M-n") 'restclient-jump-next)
