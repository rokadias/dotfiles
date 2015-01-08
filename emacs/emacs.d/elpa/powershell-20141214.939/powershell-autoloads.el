;;; powershell-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (powershell powershell-mode) "powershell" "powershell.el"
;;;;;;  (21648 33182 917577 900000))
;;; Generated autoloads from powershell.el

(add-to-list 'auto-mode-alist (cons (purecopy "\\.ps1\\'") 'powershell-mode))

(autoload 'powershell-mode "powershell" "\
Major mode for editing PowerShell scripts.

\\{powershell-mode-map}
Entry to this mode calls the value of `powershell-mode-hook' if
that value is non-nil.

\(fn)" t nil)

(autoload 'powershell "powershell" "\
Run an inferior PowerShell.
If BUFFER is non-nil, use it to hold the powershell
process.  Defaults to *PowerShell*.

Interactively, a prefix arg means to prompt for BUFFER.

If BUFFER exists but the shell process is not running, it makes a
new shell.

If BUFFER exists and the shell process is running, just switch to
BUFFER.

If PROMPT-STRING is non-nil, sets the prompt to the given value.

See the help for `shell' for more details.  (Type
\\[describe-mode] in the shell buffer for a list of commands.)

\(fn &optional BUFFER PROMPT-STRING)" t nil)

;;;***

;;;### (autoloads nil nil ("powershell-pkg.el") (21648 33182 942082
;;;;;;  800000))

;;;***

(provide 'powershell-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; powershell-autoloads.el ends here
