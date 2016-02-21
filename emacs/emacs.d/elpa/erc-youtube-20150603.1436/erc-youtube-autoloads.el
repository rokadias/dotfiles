;;; erc-youtube-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "erc-youtube" "erc-youtube.el" (22020 35332
;;;;;;  39520 753000))
;;; Generated autoloads from erc-youtube.el

(eval-after-load 'erc '(define-erc-module youtube nil "Display inlined info about youtube links in ERC buffer" ((add-hook 'erc-insert-modify-hook 'erc-youtube-show-info t) (add-hook 'erc-send-modify-hook 'erc-youtube-show-info t)) ((remove-hook 'erc-insert-modify-hook 'erc-youtube-show-info) (remove-hook 'erc-send-modify-hook 'erc-youtube-show-info)) t))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; erc-youtube-autoloads.el ends here
