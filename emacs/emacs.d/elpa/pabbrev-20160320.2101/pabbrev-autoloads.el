;;; pabbrev-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "pabbrev" "pabbrev.el" (0 0 0 0))
;;; Generated autoloads from pabbrev.el

(autoload 'pabbrev-mode "pabbrev" "\
Toggle pabbrev mode.
With arg, turn on Predicative Abbreviation mode if and only if arg is
positive.

This mode is another abbreviation expansion mode somewhat like
`dabbrev-expand', in that it looks through the current buffer for
symbols that can complete the current symbol. Unlike `dabbrev-expand',
it does this by discovering the words during the Emacs idle time, and
places the results into data structures which enable very rapid
extraction of expansions. The upshot of this is that it can offer
suggestions as you type, without causing an unacceptable slow down.

There is an associated `global-pabbrev-mode' which turns on the mode
on in all buffers.

\(fn &optional ARG)" t nil)

(defvar global-pabbrev-mode nil "\
Non-nil if Global Pabbrev mode is enabled.
See the `global-pabbrev-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-pabbrev-mode'.")

(custom-autoload 'global-pabbrev-mode "pabbrev" nil)

(autoload 'global-pabbrev-mode "pabbrev" "\
Toggle Pabbrev mode in all buffers.
With prefix ARG, enable Global Pabbrev mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Pabbrev mode is enabled in all buffers where
`pabbrev-global-mode' would do it.
See `pabbrev-mode' for more information on Pabbrev mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pabbrev" '("pabbrev-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; pabbrev-autoloads.el ends here
