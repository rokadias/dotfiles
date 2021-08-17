;;; pyvenv-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "../../../dotfiles/emacs/emacs.d/elpa/pyvenv-20210527.829/pyvenv"
;;;;;;  "pyvenv.el" "d61bc94ac960f42261050b3531503be2")
;;; Generated autoloads from pyvenv.el

(autoload 'pyvenv-activate "../../../dotfiles/emacs/emacs.d/elpa/pyvenv-20210527.829/pyvenv" "\
Activate the virtual environment in DIRECTORY.

\(fn DIRECTORY)" t nil)

(autoload 'pyvenv-deactivate "../../../dotfiles/emacs/emacs.d/elpa/pyvenv-20210527.829/pyvenv" "\
Deactivate any current virtual environment." t nil)

(autoload 'pyvenv-workon "../../../dotfiles/emacs/emacs.d/elpa/pyvenv-20210527.829/pyvenv" "\
Activate a virtual environment from $WORKON_HOME.

If the virtual environment NAME is already active, this function
does not try to reactivate the environment.

\(fn NAME)" t nil)

(defvar pyvenv-mode nil "\
Non-nil if Pyvenv mode is enabled.
See the `pyvenv-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `pyvenv-mode'.")

(custom-autoload 'pyvenv-mode "../../../dotfiles/emacs/emacs.d/elpa/pyvenv-20210527.829/pyvenv" nil)

(autoload 'pyvenv-mode "../../../dotfiles/emacs/emacs.d/elpa/pyvenv-20210527.829/pyvenv" "\
Global minor mode for pyvenv.

If called interactively, enable Pyvenv mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

Will show the current virtualenv in the mode line, and respect a
`pyvenv-workon' setting in files.

\(fn &optional ARG)" t nil)

(defvar pyvenv-tracking-mode nil "\
Non-nil if Pyvenv-Tracking mode is enabled.
See the `pyvenv-tracking-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `pyvenv-tracking-mode'.")

(custom-autoload 'pyvenv-tracking-mode "../../../dotfiles/emacs/emacs.d/elpa/pyvenv-20210527.829/pyvenv" nil)

(autoload 'pyvenv-tracking-mode "../../../dotfiles/emacs/emacs.d/elpa/pyvenv-20210527.829/pyvenv" "\
Global minor mode to track the current virtualenv.

If called interactively, enable Pyvenv-Tracking mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

When this mode is active, pyvenv will activate a buffer-specific
virtualenv whenever the user switches to a buffer with a
buffer-local `pyvenv-workon' or `pyvenv-activate' variable.

\(fn &optional ARG)" t nil)

(autoload 'pyvenv-restart-python "../../../dotfiles/emacs/emacs.d/elpa/pyvenv-20210527.829/pyvenv" "\
Restart Python inferior processes." t nil)

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/pyvenv-20210527.829/pyvenv"
;;;;;;  "pyvenv.el" (0 0 0 0))
;;; Generated autoloads from pyvenv.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/pyvenv-20210527.829/pyvenv" '("pyvenv-")))

;;;***

;;;***

;;;### (autoloads nil "pyvenv" "../../../../../.emacs.d/elpa/pyvenv-20210527.829/pyvenv.el"
;;;;;;  "d61bc94ac960f42261050b3531503be2")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/pyvenv-20210527.829/pyvenv.el

(autoload 'pyvenv-activate "pyvenv" "\
Activate the virtual environment in DIRECTORY.

\(fn DIRECTORY)" t nil)

(autoload 'pyvenv-deactivate "pyvenv" "\
Deactivate any current virtual environment." t nil)

(autoload 'pyvenv-workon "pyvenv" "\
Activate a virtual environment from $WORKON_HOME.

If the virtual environment NAME is already active, this function
does not try to reactivate the environment.

\(fn NAME)" t nil)

(defvar pyvenv-mode nil "\
Non-nil if Pyvenv mode is enabled.
See the `pyvenv-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `pyvenv-mode'.")

(custom-autoload 'pyvenv-mode "pyvenv" nil)

(autoload 'pyvenv-mode "pyvenv" "\
Global minor mode for pyvenv.

If called interactively, enable Pyvenv mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

Will show the current virtualenv in the mode line, and respect a
`pyvenv-workon' setting in files.

\(fn &optional ARG)" t nil)

(defvar pyvenv-tracking-mode nil "\
Non-nil if Pyvenv-Tracking mode is enabled.
See the `pyvenv-tracking-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `pyvenv-tracking-mode'.")

(custom-autoload 'pyvenv-tracking-mode "pyvenv" nil)

(autoload 'pyvenv-tracking-mode "pyvenv" "\
Global minor mode to track the current virtualenv.

If called interactively, enable Pyvenv-Tracking mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

When this mode is active, pyvenv will activate a buffer-specific
virtualenv whenever the user switches to a buffer with a
buffer-local `pyvenv-workon' or `pyvenv-activate' variable.

\(fn &optional ARG)" t nil)

(autoload 'pyvenv-restart-python "pyvenv" "\
Restart Python inferior processes." t nil)

;;;### (autoloads "actual autoloads are elsewhere" "pyvenv" "../../../../../.emacs.d/elpa/pyvenv-20210527.829/pyvenv.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/pyvenv-20210527.829/pyvenv.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pyvenv" '("pyvenv-")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/pyvenv-20210527.829/pyvenv-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/pyvenv-20210527.829/pyvenv-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/pyvenv-20210527.829/pyvenv.el"
;;;;;;  "pyvenv.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; pyvenv-autoloads.el ends here
