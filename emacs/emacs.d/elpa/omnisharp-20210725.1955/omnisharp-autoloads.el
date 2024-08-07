;;; omnisharp-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp"
;;;;;;  "omnisharp.el" "4e46e070cee659be068010588bd47420")
;;; Generated autoloads from omnisharp.el

(autoload 'omnisharp-mode "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp" "\
Omnicompletion (intellisense) and more for C# using an OmniSharp
server backend.

If called interactively, enable Omnisharp mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'omnisharp-start-omnisharp-server "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp" "\
Starts an OmniSharp server for a given path to a project or solution file

\(fn &optional NO-AUTODETECT)" t nil)

(autoload 'omnisharp-stop-server "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp" "\
Stops Omnisharp server if running." t nil)

(autoload 'omnisharp-reload-solution "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp" "\
Restarts omnisharp server on solution last loaded" t nil)

(autoload 'omnisharp-check-alive-status "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp" "\
Shows a message to the user describing whether the
OmniSharpServer process specified in the current configuration is
alive.
\"Alive\" means it is running and not stuck. It also means the connection
to the server is functional - I.e. The user has the correct host and
port specified." t nil)

(autoload 'omnisharp-check-ready-status "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp" "\
Shows a message to the user describing whether the
OmniSharpServer process specified in the current configuration has
finished loading the solution." t nil)

(autoload 'omnisharp-install-server "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp" "\
Installs OmniSharp server locally into ~/.emacs/cache/omnisharp/server/$(version)

\(fn REINSTALL)" t nil)

(autoload 'company-omnisharp "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp" "\


\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp"
;;;;;;  "omnisharp.el" (0 0 0 0))
;;; Generated autoloads from omnisharp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp" '("omnisharp-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-auto-complete-actions"
;;;;;;  "omnisharp-auto-complete-actions.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-auto-complete-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-auto-complete-actions" '("ac-" "omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-code-structure"
;;;;;;  "omnisharp-code-structure.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-code-structure.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-code-structure" '("omnisharp--cs-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-current-symbol-actions"
;;;;;;  "omnisharp-current-symbol-actions.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-current-symbol-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-current-symbol-actions" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-format-actions"
;;;;;;  "omnisharp-format-actions.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-format-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-format-actions" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-http-utils"
;;;;;;  "omnisharp-http-utils.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-http-utils.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-http-utils" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-navigation-actions"
;;;;;;  "omnisharp-navigation-actions.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-navigation-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-navigation-actions" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-actions"
;;;;;;  "omnisharp-server-actions.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-server-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-actions" '("omnisharp--")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-installation"
;;;;;;  "omnisharp-server-installation.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-server-installation.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-installation" '("omnisharp--")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-management"
;;;;;;  "omnisharp-server-management.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-server-management.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-management" '("comment" "make-omnisharp--server-info" "omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-settings"
;;;;;;  "omnisharp-settings.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-settings.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-settings" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-solution-actions"
;;;;;;  "omnisharp-solution-actions.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-solution-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-solution-actions" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-unit-test-actions"
;;;;;;  "omnisharp-unit-test-actions.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-unit-test-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-unit-test-actions" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-utils"
;;;;;;  "omnisharp-utils.el" (0 0 0 0))
;;; Generated autoloads from omnisharp-utils.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/omnisharp-20210725.1955/omnisharp-utils" '("omnisharp-")))

;;;***

;;;### (autoloads nil "omnisharp" "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp.el"
;;;;;;  "4e46e070cee659be068010588bd47420")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp.el

(autoload 'omnisharp-mode "omnisharp" "\
Omnicompletion (intellisense) and more for C# using an OmniSharp
server backend.

If called interactively, enable Omnisharp mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'omnisharp-start-omnisharp-server "omnisharp" "\
Starts an OmniSharp server for a given path to a project or solution file

\(fn &optional NO-AUTODETECT)" t nil)

(autoload 'omnisharp-stop-server "omnisharp" "\
Stops Omnisharp server if running." t nil)

(autoload 'omnisharp-reload-solution "omnisharp" "\
Restarts omnisharp server on solution last loaded" t nil)

(autoload 'omnisharp-check-alive-status "omnisharp" "\
Shows a message to the user describing whether the
OmniSharpServer process specified in the current configuration is
alive.
\"Alive\" means it is running and not stuck. It also means the connection
to the server is functional - I.e. The user has the correct host and
port specified." t nil)

(autoload 'omnisharp-check-ready-status "omnisharp" "\
Shows a message to the user describing whether the
OmniSharpServer process specified in the current configuration has
finished loading the solution." t nil)

(autoload 'omnisharp-install-server "omnisharp" "\
Installs OmniSharp server locally into ~/.emacs/cache/omnisharp/server/$(version)

\(fn REINSTALL)" t nil)

(autoload 'company-omnisharp "omnisharp" "\


\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp" "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp" '("omnisharp-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-auto-complete-actions"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-auto-complete-actions.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-auto-complete-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-auto-complete-actions" '("ac-" "omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-code-structure"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-code-structure.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-code-structure.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-code-structure" '("omnisharp--cs-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-current-symbol-actions"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-current-symbol-actions.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-current-symbol-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-current-symbol-actions" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-format-actions"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-format-actions.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-format-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-format-actions" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-http-utils"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-http-utils.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-http-utils.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-http-utils" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-navigation-actions"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-navigation-actions.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-navigation-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-navigation-actions" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-server-actions"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-actions.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-server-actions" '("omnisharp--")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-server-installation"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-installation.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-installation.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-server-installation" '("omnisharp--")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-server-management"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-management.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-management.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-server-management" '("comment" "make-omnisharp--server-info" "omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-settings"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-settings.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-settings.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-settings" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-solution-actions"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-solution-actions.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-solution-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-solution-actions" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-unit-test-actions"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-unit-test-actions.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-unit-test-actions.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-unit-test-actions" '("omnisharp-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "omnisharp-utils"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-utils.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-utils.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "omnisharp-utils" '("omnisharp-")))

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-auto-complete-actions.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-code-structure.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-current-symbol-actions.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-format-actions.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-helm-integration.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-http-utils.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-navigation-actions.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-actions.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-installation.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-server-management.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-settings.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-solution-actions.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-unit-test-actions.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp-utils.el"
;;;;;;  "../../../../../.emacs.d/elpa/omnisharp-20210725.1955/omnisharp.el"
;;;;;;  "omnisharp-auto-complete-actions.el" "omnisharp-code-structure.el"
;;;;;;  "omnisharp-current-symbol-actions.el" "omnisharp-format-actions.el"
;;;;;;  "omnisharp-http-utils.el" "omnisharp-navigation-actions.el"
;;;;;;  "omnisharp-server-actions.el" "omnisharp-server-installation.el"
;;;;;;  "omnisharp-server-management.el" "omnisharp-settings.el"
;;;;;;  "omnisharp-solution-actions.el" "omnisharp-unit-test-actions.el"
;;;;;;  "omnisharp-utils.el" "omnisharp.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; omnisharp-autoloads.el ends here
