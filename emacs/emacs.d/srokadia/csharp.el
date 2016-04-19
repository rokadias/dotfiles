;; c# mode
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(require 'csharp-mode)

;; hack, c# mode causes problems if this isn't loaded
(when (package-installed-p 'flymake)
  (require 'flymake))

(let ((csharp-mode-snippets (concat yasnippets-root "csharp-mode")))
  (when (file-exists-p csharp-mode-snippets)
    (add-to-list 'load-path csharp-mode-snippets)
    (add-to-list 'yas-snippet-dirs csharp-mode-snippets)
    (yas/load-directory csharp-mode-snippets)))

(defun csharp-replace-double-quotes-with-string-empty (arg)
  (interactive "*P")
  (self-insert-command (prefix-numeric-value arg))
  (save-excursion
    (when (re-search-backward "\\([^\\]\\)\"\"" (- (point) 10) t)
      (replace-match "\\1String.Empty" t))))

(defun csharp-lineup-method-declaration-after-attribute (elem)
  (let ((anchor (cdr elem)))
    (if (string-equal "[" (buffer-substring anchor (+ anchor 1)))
        0
      '+)))

(defun match-length ()
  (- (match-end 0) (match-beginning 0)))

;; bind to topmost-intro-cont
(defun csharp-lineup-anonymous-class-initialization-continuation (elem)
  (let ((anchor (cdr elem))
        (c))
    ;; search backwards for 'new { ', stopping at anchor
    (save-excursion
      (back-to-indentation)
      (setq c (current-column))
      (if (re-search-backward "new ?{ ?" anchor t)
          ;; found it, indent current line
          (let ((difference (- (+ (current-column) (match-length)) c)))
            (make-vector 1 (+ c difference)))
        0))))

; Java-like C# style with solid auto newline support.
(defconst csharp-c-style
  '((c-basic-offset . 4)
    (c-comment-only-line-offset 0 . 0)
    (c-hanging-braces-alist .
     ((substatement-open . (after))
      (statement-cont)
      (inline-open . (after))
      (inline-close)
      (block-close . (after))
      (namespace-open . (after))
      (namespace-close . (after))
      (brace-list-open)
      (brace-list-close)
      (brace-list-intro)
      (class-open . (after))
      (defun-open . (after))
      (defun-close)))
    (c-cleanup-list .
     (brace-else-brace
      brace-elseif-brace
      brace-catch-brace
      defun-close-semi
      list-close-comma))
    (c-offsets-alist .
     ((inline-open . 0)
      (topmost-intro-cont . csharp-lineup-anonymous-class-initialization-continuation)
      (case-label . 0)
      (statement-case-intro . +)
      (statement-case-open . 0)
      (statement-cont . csharp-lineup-method-declaration-after-attribute)
      (arglist-intro . +)
      (arglist-cont-nonempty . c-lineup-arglist-intro-after-paren)
      (arglist-close . c-lineup-arglist)
      (inher-cont . c-lineup-java-inher)))))

(c-add-style "csharp" csharp-c-style)

(defun on-csharp-loaded ()

  (c-set-style "csharp")

  (use-local-map csharp-mode-map)
  (define-key csharp-mode-map "\"" 'csharp-replace-double-quotes-with-string-empty)

  ;; electric keys suck
  (define-key csharp-mode-map "{" 'self-insert-command)
  (define-key csharp-mode-map "(" 'self-insert-command)
  (define-key csharp-mode-map ")" 'self-insert-command)
  (define-key csharp-mode-map ";" 'self-insert-command)
  (define-key csharp-mode-map "," 'self-insert-command)

  (c-toggle-auto-newline -1)

  ; Give extra fill space to compensate for namespace nesting.
  (setq fill-column (+ c-basic-offset fill-column))
  (setq tab-width c-basic-offset) ; maintain sanity when encountering tab-ridden code
  (setq show-trailing-whitespace t)

  ; Use xml documentation tags as paragraph separators so filling
  ; works nicely in elements for which multi-line comments are preferred.
  ; How great is Emacs?
  (let ((xmldoc-para-rx "\\|[ ]*/// </?\\(summary\\|remarks\\|para\\)>$"))
    (setq paragraph-start (concat paragraph-start xmldoc-para-rx))
    (setq paragraph-separate (concat paragraph-separate xmldoc-para-rx)))

  ; Uncomment to spell check comments.
  ; (require 'flyspell)
  ; (flyspell-prog-mode)

  ;; (when (and buffer-file-name
  ;;            (string-match "scratch/.*\\.cs\\'" buffer-file-name))
  ;;   (set-scratch-file-compilation-command))
  (require 'flycheck)
  (flycheck-mode)
  (set-csharp-compile-command)
  (fix-compilation-regex)
  )

(defun set-csharp-compile-command ()
  (let ((project-file (find-project-file "\\.csproj$" "\\.vs\\.csproj\\|webappui\\.csproj")))
    (when project-file
      (message "Found project file at %s" project-file)
      (when is-cygwin
        (setq project-file (concat "$(cygpath -aw " project-file ")")))
      (set (make-local-variable 'compile-command)
           (if (or is-w32 is-cygwin)
               (concat "C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe "
                       "/m /nr:false /v:q /p:GenerateFullPaths=true \"" project-file
                       "\" /p:StyleCop=false /p:BuildProjectReferences=true")
             (concat "msbuild.sh " project-file))))))

(defun compile-full-msbuild ()
  (interactive)
  (let ((project-file (find-project-file "\\.proj$")))
    (when project-file
      (message "Found full msbuild project file at %s" project-file)
      (when is-cygwin
        (setq project-file (concat "$(cygpath -aw " project-file ")")))
      (compile
       (if (or is-w32 is-cygwin)
           (concat "C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe "
                   "/m /nr:false /v:q /p:GenerateFullPaths=true "
                   "\"/t:FullReleaseBuild;MakePublishDirectory\" \"" project-file
                   "\" /p:StyleCop=false /p:BuildProjectReferences=true")
         (concat "fullmsbuild.sh " project-file)))
      (set-csharp-compile-command))))
(define-key csharp-mode-map (kbd "C-M-m") 'compile-full-msbuild)

(when (package-installed-p 'csharp-mode))

(add-hook 'csharp-mode-hook 'on-csharp-loaded)
(add-hook 'csharp-mode-hook 'c-set-style-stroustrup)
(add-hook 'csharp-mode-hook 'comment-fill-mode-hook)

(when (package-installed-p 'omnisharp)
  (require 'omnisharp)
  (setq omnisharp-server-executable-path "/usr/bin/omnisharp")
  (defun omnisharp-unit-test-worker (mode)
    "Run tests after building the solution. Mode should be one of 'single', 'fixture' or 'all'" 
    (let ((test-command
           (omnisharp--fix-build-command-if-on-windows
            (cdr (assoc 'TestCommand
                        (omnisharp-post-message-curl-as-json
                         (concat (omnisharp-get-host) "gettestcontext") 
                         (cons `("Type" . ,mode)
                               (omnisharp--get-common-params))))))))

      (compile test-command)
      (set-csharp-compile-command))))

(defconst csharp-compilation-re-msbuild-error
  (concat
   "^[[:blank:]]*\\(?:[[:digit:]]+>\\)?"
   "\\([^()]+\\)(\\([0-9]+\\)\\(?:,\\([0-9]+\\)\\)?): "
   "error [[:alnum:]]+: [^[]+\\[\\([^]]+\\)\\]$")
  "Regexp to match compilation error from msbuild.")

(defconst csharp-compilation-re-msbuild-warning
  (concat
   "^[[:blank:]]*\\(?:[[:digit:]]+>\\)?"
   "\\([^()[:blank:]]+\\)(\\([0-9]+\\)\\(?:,\\([0-9]+\\)\\)?): "
   "warning [[:alnum:]]+: [^[]+\\[\\([^]]+\\)\\]$")
  "Regexp to match compilation warning from msbuild.")

(defconst csharp-compilation-re-xbuild-error
  (concat
   "^[[:blank:]]*\\(?:[[:digit:]]+>\\)?"
   "\\([^()]+\\)(\\([0-9]+\\)\\(?:,\\([0-9]+\\)\\)?): "
   "error [[:alnum:]]+: .+$")
  "Regexp to match compilation error from xbuild.")

(defconst csharp-compilation-re-xbuild-warning
  (concat
   "^[[:blank:]]*\\(?:[[:digit:]]+>\\)?"
   "\\([^()]+\\)(\\([0-9]+\\)\\(?:,\\([0-9]+\\)\\)?): "
   "warning [[:alnum:]]+: .+$")
  "Regexp to match compilation warning from xbuild.")

(defun fix-compilation-regex()
        (setq compilation-error-regexp-alist-alist
            (delq (assoc 'msbuild-error compilation-error-regexp-alist-alist) compilation-error-regexp-alist-alist))
      (dolist
          (regexp
           `((xbuild-error
              ,csharp-compilation-re-xbuild-error
              1 2 3 2)
             (xbuild-warning
              ,csharp-compilation-re-xbuild-warning
              1 2 3 1)
             (msbuild-error
              ,csharp-compilation-re-msbuild-error
              1 2 3 2)
             (msbuild-warning
              ,csharp-compilation-re-msbuild-warning
              1 2 3 1)))
        (message (stringp (car regexp)))
        (setq compilation-error-regexp-alist-alist
              (delq (assoc (car regexp) compilation-error-regexp-alist-alist)
                    compilation-error-regexp-alist-alist))
        (add-to-list 'compilation-error-regexp-alist-alist regexp)))

(autoload 'omnisharp-mode "omnisharp-mode" "Minor mode for C# intellisense." t)
(add-hook 'csharp-mode-hook 'omnisharp-mode)

(setq system-namespaces '("System"))
(setq development-namespaces '("ImsHealth" "Appature"))
(setq using-regex "using \\([A-Za-z0-9\\.]+\\);")
(defun get-namespace (using-statement)
  (replace-regexp-in-string using-regex "\\1" using-statement))

(defun compare-using-statements (statement1 statement2)
  (cond ((and (string-match-p using-regex statement1)
              (string-match-p using-regex statement2))
         (compare-using-namespaces (get-namespace statement1) (get-namespace statement2)))
    ((string-match-p using-regex statement1) t)
    ((string-match-p using-regex statement2) nil)
    (t (string-lessp statement1 statement2))
    )
  )

(defun compare-using-namespaces (namespace1 namespace2)
  (let ((order1 (convert-to-namespace-order namespace1))
        (order2 (convert-to-namespace-order namespace2)))
    (cond ((= order1 order2) (string-lessp namespace1 namespace2))
          (t (< order1 order2)))
    )
  )

(defun convert-to-namespace-order (namespace)
  (let* ((val 0)
         (system-val (cl-incf val))
         (development-val (cl-incf val))
         (other-val (cl-incf val)))
    (cond ((string-list-contains namespace system-namespaces) system-val)
          ((string-list-contains namespace development-namespaces) development-val)
          (t other-val)
          )
    )
  )

(defun string-list-contains (str list)
  (if (member-if (lambda (x) (string-prefix-p x str)) list)
      t
    nil))

(defun get-using-statements ()
  (save-excursion
    (beginning-of-buffer)
    (while (re-search-forward "using [A-Za-z0-9\\.]+;" (point-max) t))
    (buffer-substring-no-properties 1 (point))
    ))

(defun sort-using-statements ()
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (while (re-search-forward "using [A-Za-z0-9\\.]+;" (point-max) t))
    (insert-string (perform-sort-using-statements (delete-and-extract-region 1 (point))))
    )
  (save-buffer)
  )

(defun perform-sort-using-statements (statements)
  (string-join
   (sort (split-string statements "\n") 'compare-using-statements)
   "\n")
  )
