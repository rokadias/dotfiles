(fset 'rename-named-args
   (kmacro-lambda-form [?\C-a ?\C-  ?\C-s ?: return ?\C-b ?\M-w ?\C-  ?\C-e ?\C-b ?\C-e backspace ?= ?\C-y ?, ?\C-n ?\C-a] 0 "%d"))

(defun apply-named-macro-to-region-lines (top bottom)
  "Apply named keyboard macro to all lines in the region."
  (interactive "r")
  (let ((macro (intern
                (completing-read "kbd macro (name): "
                                 obarray
                                 (lambda (elt)
                                   (and (fboundp elt)
                                        (or (stringp (symbol-function elt))
                                            (vectorp (symbol-function elt))
                                            (get elt 'kmacro))))))))
    (apply-macro-to-region-lines top bottom macro)))
