;;; sx-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from sx.el

(autoload 'sx-bug-report "sx" "\
File a bug report about the `sx' package." t)
(register-definition-prefixes "sx" '("sx-"))


;;; Generated autoloads from sx-auth.el

(autoload 'sx-authenticate "sx-auth" "\
Authenticate this application.
Authentication is required to read your personal data (such as
notifications) and to write with the API (asking and answering
questions).

When this function is called, `browse-url' is used to send the
user to an authorization page managed by StackExchange.  The
following privileges are requested:

* read_inbox
    use SX to manage and visit items in your inbox

* write_acesss
    write comments, ask questions, and post answers on your
    behalf

* no_expiry
    do not pester you to reauthorize again

* private_info
    TODO explanation.

After authorization with StackExchange, the user is then
redirected to a website managed by SX.  The access token required
to use authenticated methods is included in the hash (which is
parsed and displayed prominently on the page)." t)
(register-definition-prefixes "sx-auth" '("sx-auth-"))


;;; Generated autoloads from sx-babel.el

(register-definition-prefixes "sx-babel" '("sx-babel-"))


;;; Generated autoloads from sx-button.el

(register-definition-prefixes "sx-button" '("sx-"))


;;; Generated autoloads from sx-cache.el

(register-definition-prefixes "sx-cache" '("sx-cache-"))


;;; Generated autoloads from sx-compose.el

(register-definition-prefixes "sx-compose" '("sx-compose-"))


;;; Generated autoloads from sx-encoding.el

(register-definition-prefixes "sx-encoding" '("sx-encoding-"))


;;; Generated autoloads from sx-favorites.el

(register-definition-prefixes "sx-favorites" '("sx-favorite"))


;;; Generated autoloads from sx-filter.el

(register-definition-prefixes "sx-filter" '("sx-"))


;;; Generated autoloads from sx-inbox.el

(autoload 'sx-inbox "sx-inbox" "\
Display a buffer listing inbox items.
With prefix NOTIFICATIONS, list notifications instead of inbox.

(fn &optional NOTIFICATIONS)" t)
(autoload 'sx-inbox-notifications "sx-inbox" "\
Display a buffer listing notification items." t)
(register-definition-prefixes "sx-inbox" '("sx-inbox-"))


;;; Generated autoloads from sx-interaction.el

(autoload 'sx-open-link "sx-interaction" "\
Visit element given by LINK inside Emacs.
Element can be a question, answer, or comment.

(fn LINK &optional _)" t)
(autoload 'sx-org-get-link "sx-interaction" "\
Add a link to this post to Org's memory.")
(autoload 'sx-ask "sx-interaction" "\
Start composing a question for SITE.
SITE is a string, indicating where the question will be posted.

(fn SITE)" t)
(register-definition-prefixes "sx-interaction" '("sx-"))


;;; Generated autoloads from sx-method.el

(register-definition-prefixes "sx-method" '("sx-method-post-from-data"))


;;; Generated autoloads from sx-networks.el

(register-definition-prefixes "sx-networks" '("sx-network-"))


;;; Generated autoloads from sx-notify.el

(register-definition-prefixes "sx-notify" '("sx-notify-"))


;;; Generated autoloads from sx-question.el

(register-definition-prefixes "sx-question" '("sx-"))


;;; Generated autoloads from sx-question-list.el

(register-definition-prefixes "sx-question-list" '("sx-question-list-"))


;;; Generated autoloads from sx-question-mode.el

(register-definition-prefixes "sx-question-mode" '("sx-question-mode"))


;;; Generated autoloads from sx-question-print.el

(register-definition-prefixes "sx-question-print" '("sx-question-mode-"))


;;; Generated autoloads from sx-request.el

(register-definition-prefixes "sx-request" '("sx-"))


;;; Generated autoloads from sx-search.el

(autoload 'sx-search "sx-search" "\
Display search on SITE for question titles containing QUERY.
When TAGS is given, it is a lists of tags, one of which must
match.  When EXCLUDED-TAGS is given, it is a list of tags, none
of which is allowed to match.

Interactively, the user is asked for SITE and QUERY.  With a
prefix argument, the user is asked for everything.

(fn SITE QUERY &optional TAGS EXCLUDED-TAGS)" t)
(autoload 'sx-search-tag-at-point "sx-search" "\
Follow tag under position POS or point.

(fn &optional POS)" t)
(register-definition-prefixes "sx-search" '("sx-search-"))


;;; Generated autoloads from sx-site.el

(register-definition-prefixes "sx-site" '("sx-site-"))


;;; Generated autoloads from sx-switchto.el

(define-prefix-command 'sx-switchto-map)


;;; Generated autoloads from sx-tab.el

(autoload 'sx-tab-all-questions "sx-tab" nil t)
(autoload 'sx-tab-unanswered "sx-tab" nil t)
(autoload 'sx-tab-unanswered-my-tags "sx-tab" nil t)
(autoload 'sx-tab-featured "sx-tab" nil t)
(autoload 'sx-tab-starred "sx-tab" nil t)
(autoload 'sx-tab-frontpage "sx-tab" nil t)
(autoload 'sx-tab-newest "sx-tab" nil t)
(autoload 'sx-tab-topvoted "sx-tab" nil t)
(autoload 'sx-tab-hot "sx-tab" nil t)
(autoload 'sx-tab-week "sx-tab" nil t)
(autoload 'sx-tab-month "sx-tab" nil t)
(register-definition-prefixes "sx-tab" '("sx-tab-"))


;;; Generated autoloads from sx-tag.el

(register-definition-prefixes "sx-tag" '("sx-tag-"))


;;; Generated autoloads from sx-time.el

(register-definition-prefixes "sx-time" '("sx-time-"))


;;; Generated autoloads from sx-user.el

(register-definition-prefixes "sx-user" '("sx-"))

;;; End of scraped data

(provide 'sx-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; sx-autoloads.el ends here
