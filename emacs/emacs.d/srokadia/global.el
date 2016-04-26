(setq column-number-mode t)
(pending-delete-mode 1)
(set-language-environment "English")

; Remove toolbar, scroll bar, menu bar,  cursor blinking
(tool-bar-mode -1)
(scroll-bar-mode -1)
(if (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(blink-cursor-mode nil)

;;; Only scroll one line when moving past screen
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(case-replace nil)
 '(erc-irccontrols-mode t)
 '(jabber-alert-presence-hooks nil)
 '(session-use-package t nil (session)))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)
(setq c-basic-offset 4)
(setq nxml-child-indent 2)

(setq dabbrev-case-fold-search nil)
(setq dabbrev-case-replace nil)

;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

(put 'upcase-region 'disabled nil)

(setq is-w32 (string-equal system-type "windows-nt"))
(setq is-cygwin (string-equal system-type "cygwin"))
(setq is-mac (memq window-system '(mac ns)))
(setq server-use-tcp t)

(when is-w32
  (setq find-program
        (let* ((program-files (concat (getenv "ProgramFiles")))
               (gnuwin32 (concat program-files "\\GnuWin32\\bin\\find.exe")))
          (cond ((file-exists-p gnuwin32) gnuwin32)
                ((file-exists-p "C:/bin/find.exe") "C:/bin/find.exe")
                ((file-exists-p "C:/cygwin/bin/find.exe") "C:/cygwin/bin/find.exe")
                (find-in-exec-path "find.exe")))))
(when is-cygwin
  (setq find-program "/cygdrive/c/cygwin/bin/find.exe"))

(when is-mac
  (exec-path-from-shell-initialize)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super))

;; use grep whenever possible, but fallback to findstr on non-cygwin /
;; non-gnuwin32 windows.
(setq grep-command
      (if (and is-w32 (not (exists-in-exec-path "grep.exe")))
          "findstr /n "
        "grep -n -e "))

;; blerg
(defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
  "Use cygwin's /dev/null as the null-device."
  (let ((null-device "/dev/null"))
    ad-do-it))
(ad-activate 'grep-compute-defaults)

(defun rcy-browse-url-default-macosx-browser (url &optional new-window)
  (interactive (browse-url-interactive-arg "URL: "))
  (let ((url
	 (if (aref (url-generic-parse-url url) 0)
	     url
	   (concat "http://" url))))
    (start-process (concat "open " url) nil "open" url)))
 
(setq browse-url-browser-function )

(setq browse-url-browser-function
      (cond
       (is-w32 'browse-url-default-windows-browser)
       (is-mac 'rcy-browse-url-default-macosx-browser)
       (t 'browse-url-chromium)))

(setq visible-bell (not is-mac))
(when is-mac
  (setq visible-bell       nil
        ring-bell-function #'my-terminal-visible-bell))

(defun my-terminal-visible-bell ()
  "A friendlier visual bell effect."
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil 'invert-face 'mode-line))

(when is-w32
  (set-message-beep 'silent))
