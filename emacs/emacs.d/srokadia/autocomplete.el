(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(defun company-backend-with-yas (backends)
  (if (and (listp backends) (memq 'company-yasnippet backends))
      backends
    (append (if (consp backends)
                backends
              (list backends))
            '(:with company-yasnippet))))

(require 'company)
(setq company-backends (mapcar #'company-backend-with-yas company-backends))
