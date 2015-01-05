;;; zoom-frm-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (toggle-zoom-frame zoom-frm-unzoom zoom-frm-out
;;;;;;  zoom-frm-in frame-zoom-font-difference zoom) "zoom-frm" "zoom-frm.el"
;;;;;;  (21307 47729 874814 462000))
;;; Generated autoloads from zoom-frm.el

(let ((loads (get 'zoom 'custom-loads))) (if (member '"zoom-frm" loads) nil (put 'zoom 'custom-loads (cons '"zoom-frm" loads))))

(defvar frame-zoom-font-difference 1 "\
*Number of points to change the frame font size when zooming.
This applies to commands `zoom-in/out', `zoom-in', `zoom-out',
`zoom-frm-in', and `zoom-frm-out' when zooming a frame.

The absolute value of the value must be less than the current font
size for the frame, because the new font size cannot be less than one
point.")

(custom-autoload 'frame-zoom-font-difference "zoom-frm" t)

(autoload 'zoom-frm-in "zoom-frm" "\
Zoom FRAME in by `frame-zoom-font-difference', making text larger.
If `frame-zoom-font-difference' is negative, make text smaller.
With prefix argument FLIP, reverse the direction:
if `frame-zoom-font-difference' is positive, then make text smaller.
This is equal but opposite to `zoom-frm-out'.

\(fn &optional FRAME FLIP)" t nil)

(autoload 'zoom-frm-out "zoom-frm" "\
Zoom FRAME out by `frame-zoom-font-difference', making text smaller.
If `frame-zoom-font-difference' is negative, make text larger.
With prefix argument FLIP, reverse the direction:
if `frame-zoom-font-difference' is positive, then make text larger.
This is equal but opposite to `zoom-frm-in'.

\(fn &optional FRAME FLIP)" t nil)

(autoload 'zoom-frm-unzoom "zoom-frm" "\
Cancel zoom of FRAME.

\(fn &optional FRAME)" t nil)

(autoload 'toggle-zoom-frame "zoom-frm" "\
Alternately zoom/unzoom FRAME by `frame-zoom-font-difference'.

\(fn &optional FRAME)" t nil)

;;;***

;;;### (autoloads nil nil ("zoom-frm-pkg.el") (21307 47729 894458
;;;;;;  894000))

;;;***

(provide 'zoom-frm-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; zoom-frm-autoloads.el ends here
