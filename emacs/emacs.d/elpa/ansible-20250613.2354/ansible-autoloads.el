;;; ansible-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from ansible.el

(defvar ansible-key-map (make-sparse-keymap) "\
Keymap for Ansible.")
(autoload 'ansible-mode "ansible" "\
Ansible minor mode.

This is a minor mode.  If called interactively, toggle the `Ansible
mode' mode.  If the prefix argument is positive, enable the mode, and if
it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable the
mode if ARG is nil, omitted, or is a positive number.  Disable the mode
if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate the variable `ansible-mode'.

The mode's hook is called both when the mode is enabled and when it is
disabled.

(fn &optional ARG)" t)
(autoload 'ansible-dict-initialize "ansible" "\
Initialize Ansible auto-complete.")
(register-definition-prefixes "ansible" '("ansible-"))

;;; End of scraped data

(provide 'ansible-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; ansible-autoloads.el ends here
