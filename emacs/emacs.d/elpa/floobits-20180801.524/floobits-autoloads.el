;;; floobits-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "floobits" "floobits.el" (0 0 0 0))
;;; Generated autoloads from floobits.el

(autoload 'floobits-debug "floobits" "\
Toggle Floobits debug logging." t nil)

(autoload 'floobits-summon "floobits" "\
Summon all Floobits collaborators to point." t nil)

(autoload 'floobits-follow-mode-toggle "floobits" "\
Toggle following recent changes in Floobits workspace." t nil)

(autoload 'floobits-follow-user "floobits" "\
Follow a Floobits collaborator's changes.
Also toggles follow mode (see `floobits-follow-mode-toggle')." t nil)

(autoload 'floobits-leave-workspace "floobits" "\
Leave the current Floobits workspace." t nil)

(autoload 'floobits-complete-signup "floobits" "\
Finalize creation of your Floobits account.
If you created a Floobits account via Emacs you must call this
command before you can log in to the website." t nil)

(autoload 'floobits-share-dir-public "floobits" "\
Create public Floobits workspace and add contents of DIR-TO-SHARE.
If DIR-TO-SHARE does not it exist, it will be created.  If the
directory corresponds to an existing Floobits workspace, the
workspace will be joined instead.

\(fn DIR-TO-SHARE)" t nil)

(autoload 'floobits-share-dir-private "floobits" "\
Create private Floobits workspace and add contents of DIR-TO-SHARE.
If DIR-TO-SHARE does not it exist, it will be created.  If the
directory corresponds to an existing Floobits workspace, the
workspace will be joined instead.

\(fn DIR-TO-SHARE)" t nil)

(autoload 'floobits-join-workspace "floobits" "\
Join an existing Floobits workspace.
Create a new workspace with `floobits-share-dir-public' or
`floobits-share-dir-private', or by visiting http://floobits.com.

\(fn FLOOURL)" t nil)

(autoload 'floobits-workspace-settings "floobits" nil t nil)

(autoload 'floobits-remove-from-workspace "floobits" "\
Remove PATH from Floobits workspace.
Does not delete file locally.

\(fn PATH)" t nil)

(autoload 'floobits-open-workspace-in-browser "floobits" nil t nil)

(autoload 'floobits-clear-highlights "floobits" "\
Clear all Floobits highlights." t nil)

(autoload 'floobits-add-to-workspace "floobits" "\
Add file or directory at PATH to Floobits workspace.

\(fn PATH)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "floobits" '("floobits-")))

;;;***

;;;### (autoloads nil nil ("floobits-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; floobits-autoloads.el ends here
