;;; doremi-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "doremi" "doremi.el" (23026 13047 0 0))
;;; Generated autoloads from doremi.el

(let ((loads (get 'doremi 'custom-loads))) (if (member '"doremi" loads) nil (put 'doremi 'custom-loads (cons '"doremi" loads))))

(defvar doremi-up-keys '(up) "\
*Keys (events) associated with one direction of adjusting by `doremi'.
The other direction is associated with `doremi-down-keys'.

The value must be a list of keyboard events: characters or symbols.
For example, a list element might be `?' or `prior'.")

(custom-autoload 'doremi-up-keys "doremi" t)

(defvar doremi-down-keys '(down) "\
*Keys (events) associated with one direction of adjusting by `doremi'.
The other direction is associated with `doremi-up-keys'.

The value must be a list of keyboard events: characters or symbols.
For example, a list element might be `?' or `next'.")

(custom-autoload 'doremi-down-keys "doremi" t)

(defvar doremi-boost-up-keys '(M-up) "\
*Like `doremi-up-keys', but increments by `doremi-boost-scale-factor'.

The value must be a list of keyboard events: characters or symbols.
For example, a list element might be `?\360' or `S-prior'.")

(custom-autoload 'doremi-boost-up-keys "doremi" t)

(defvar doremi-boost-down-keys '(M-down) "\
*Like `doremi-down-keys', but increments by `doremi-boost-scale-factor'.

The value must be a list of keyboard events: characters or symbols.
For example, a list element might be `?\356' or `S-next'.")

(custom-autoload 'doremi-boost-down-keys "doremi" t)

(defvar doremi-boost-scale-factor 10 "\
*Factor to boost incremental change of numerical properties.
Using `doremi-boost-up-keys' or `doremi-boost-down-keys', instead of
`doremi-up-keys' or `doremi-down-keys' means that the increment is
this many times larger.  Using a modifier key with the mouse wheel has
the same effect as using `doremi-boost-up-keys' or
`doremi-boost-down-keys'.")

(custom-autoload 'doremi-boost-scale-factor "doremi" t)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; doremi-autoloads.el ends here
