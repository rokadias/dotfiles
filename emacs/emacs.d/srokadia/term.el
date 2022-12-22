;;; python --- Saqib's terminal configuration.
;;; Commentary:
;;; Sets general things that I like for working with terminals.
;;; Code:
(require 'tramp)
(defun saqib-ansi-terminal (name &optional path)
  "Opens an ansi terminal at the given PATH.
If no PATH is given, it will use the default value of
`default-directory'.  PATH may be a tramp remote path.  The
'ansi-term' buffer is named based on `NAME'"
  (interactive "sBuffer Name:")
  (unless path (setq path default-directory))
  (unless name (setq name "ansi-term"))
  (ansi-term "/bin/zsh" name)
  (rename-buffer name)
  (let ((path (replace-regexp-in-string "^file:" "" path))
    (cd-str
     "fn=%s; if test ! -d $fn; then fn=$(dirname $fn); fi; cd $fn;")
    )
    (if (tramp-tramp-file-p path)
    (let ((tstruct (tramp-dissect-file-name path)))
      (cond
       ((member (tramp-file-name-method tstruct) '("ssh" "rsync"))
        (process-send-string name (format
                      (concat  "ssh -t %s '"
                           cd-str
                           "exec zsh'; exec zsh; clear\n")
                      (tramp-file-name-host tstruct)
                      (tramp-file-name-localname tstruct))))
       (t (error "not implemented for method %s"
             (tramp-file-name-method tstruct)))))
      (process-send-string name (format (concat cd-str " exec zsh;clear\n")
                       path)))))

(provide 'saqib-term)
;;; term.el ends here
