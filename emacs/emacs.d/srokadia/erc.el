;; ERC Stuff
(setq erc-timestamp-only-if-changed-flag nil
      erc-timestamp-format "%H:%M "
      erc-insert-timestamp-function 'erc-insert-timestamp-left
      erc-interpret-mirc-color t
      erc-modules '(autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands notify readonly ring services sound stamp track)
      erc-auto-query 'bury
      erc-keywords '("BrownBear" "BrownBear")
      erc-timestamp-mode t
      erc-track-exclude-types (quote ("JOIN" "NICK" "PART" "QUIT" "MODE" "333" "353"))
      erc-track-list-changed-hook '(lambda () (ding t))
      erc-fill-column 105
      erc-fools '("DevParrot")
      erc-mode-line-format "%n@%t %a"
      erc-fill-function 'erc-fill-static
      erc-fill-static-center 15
      erc-prompt-for-nickserv-password nil)

(setq erc-log-channels-directory "~/.erc/logs/"
      erc-save-buffer-on-part nil
      erc-save-queries-on-quit nil
      erc-log-write-after-send t
      erc-log-write-after-insert t
      erc-enable-logging t
      erc-generate-log-file-name-function 'erc-generate-log-file-name-short)

(when (package-installed-p 'erc-highlight-nicknames)
 (add-to-list 'erc-modules 'highlight-nicknames)
 (erc-update-modules))
