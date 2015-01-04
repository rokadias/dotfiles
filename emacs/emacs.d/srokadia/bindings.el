;;; Comment and uncomment regions
(global-set-key [?\C-#]      'comment-region)
(global-set-key [?\C-\M-#] 'uncomment-region)

;;; Scrolling
(defun down-three () (interactive) (scroll-down 3))
(defun up-three () (interactive) (scroll-up 3))
(global-set-key [mouse-4] 'down-three)
(global-set-key [mouse-5] 'up-three)

(global-set-key "\M-m" 'compile)

(when (package-installed-p 'goto-last-change)
  (require 'goto-last-change)
  (global-set-key (kbd "C-x C-\\") 'goto-last-change))

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

;; Window registers
(global-set-key [(control x) (r) (w)] 'switch-to-window-configuration-to-register)
(global-set-key [(control x) (g)] 'switch-to-window-configuration)

;; Comparing
(global-set-key [(control c) (b)] 'ediff-buffers)
