(defun company-backend-with-yas (backends)
  (if (and (listp backends) (memq 'company-yasnippet backends))
      backends
    (append (if (consp backends)
                backends
              (list backends))
            '(:with company-yasnippet))))

(require 'company)
(setq company-backends (mapcar #'company-backend-with-yas company-backends))
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)
