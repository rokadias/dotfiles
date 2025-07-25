;;; ob-mermaid.el --- org-babel support for mermaid evaluation  -*- lexical-binding: t; -*-

;; Copyright (C) 2018 Alexei Nunez

;; Author: Alexei Nunez <alexeirnunez@gmail.com>
;; URL: https://github.com/arnm/ob-mermaid
;; Keywords: lisp
;; Package-Version: 20250621.1655
;; Package-Revision: 9b64cbc4b58a

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Org-Babel support for evaluating mermaid diagrams.
;;
;; Supported header arguments:
;; :file - Output file (required)
;; :theme - Mermaid theme
;; :width, :height - Diagram dimensions
;; :scale - Scale factor
;; :background-color - Background color
;; :mermaid-config-file - Mermaid config file
;; :css-file - CSS file for styling
;; :puppeteer-config-file - Puppeteer config file
;; :pdf-fit - Enable PDF fit mode
;; :cmdline - Additional command line arguments

;;; Requirements:

;; mermaid.cli | https://github.com/mermaidjs/mermaid.cli

;;; Code:
(require 'ob)
(require 'ob-eval)

(defvar org-babel-default-header-args:mermaid
  '((:results . "file") (:exports . "results"))
  "Default arguments for evaluatiing a mermaid source block.")

(defcustom ob-mermaid-cli-path nil
  "Path to mermaid.cli executable."
  :group 'org-babel
  :type 'string)

(defun org-babel-execute:mermaid (body params)
  (let* ((out-file (or (cdr (assoc :file params))
                       (error "mermaid requires a \":file\" header argument")))
	 (theme (cdr (assoc :theme params)))
	 (width (cdr (assoc :width params)))
	 (height (cdr (assoc :height params)))
	 (scale (cdr (assoc :scale params)))
	 (background-color (cdr (assoc :background-color params)))
	 (mermaid-config-file (cdr (assoc :mermaid-config-file params)))
	 (css-file (cdr (assoc :css-file params)))
	 (puppeteer-config-file (cdr (assoc :puppeteer-config-file params)))
	 (pdf-fit (assoc :pdf-fit params))
	 (cmdline (cdr (assoc :cmdline params)))
         (temp-file (org-babel-temp-file "mermaid-"))
         (mmdc-path (executable-find "mmdc"))
         (mmdc (or ob-mermaid-cli-path
                   (if mmdc-path
                       (if (file-executable-p mmdc-path)
                           mmdc-path
                         (error "Found mmdc at %s but it's not executable" mmdc-path))
                     (error "`ob-mermaid-cli-path' is not set and mmdc is not in `exec-path'"))))
         (cmd (concat mmdc
                      " -i " (org-babel-process-file-name temp-file)
                      " -o " (org-babel-process-file-name out-file)
		      (when theme
			(concat " -t " theme))
		      (when background-color
			(concat " -b " background-color))
		      (when width
			(concat " -w " (if (numberp width) (number-to-string width) width)))
		      (when height
			(concat " -H " (if (numberp height) (number-to-string height) height)))
		      (when scale
			(concat " -s " (if (numberp scale) (number-to-string scale) (number-to-string scale))))
		      (when pdf-fit
			(concat " -f "))
		      (when mermaid-config-file
			(concat " -c " (org-babel-process-file-name mermaid-config-file)))
		      (when css-file
			(concat " -C " (org-babel-process-file-name css-file)))
                      (when puppeteer-config-file
                        (concat " -p " (org-babel-process-file-name puppeteer-config-file)))
		      (when cmdline
			(concat " " cmdline)))))
    (with-temp-file temp-file (insert body))
    (message "%s" cmd)
    (org-babel-eval cmd "")
    nil))

(provide 'ob-mermaid)

;;; ob-mermaid.el ends here
