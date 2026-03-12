(defun on-java-load ()
  ;;(lsp)
  )

(add-hook 'java-mode-hook (lambda () (on-java-load)))

(setq lsp-java-configuration-runtimes '[(:name "JavaSE-21"
					       :path "/usr/lib/jvm/java-21-openjdk"
                                               :default t)
					(:name "JavaSE-17"
					       :path "/usr/lib/jvm/java-17-openjdk")])

(setq lsp-java-java-path "/usr/lib/jvm/java-21-openjdk/bin/java")
