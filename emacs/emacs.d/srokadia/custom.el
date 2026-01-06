(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#26292c" "#ff4a52" "#40b83e" "#f6f080" "#afc4db" "#dc8cc3" "#93e0e3" "#f8f8f8"])
 '(auto-revert-verbose nil)
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
 '(case-replace t)
 '(comment-auto-fill-only-comments t)
 '(company-async-redisplay-delay 10)
 '(company-begin-commands
   '(c-scope-operator c-electric-colon c-electric-lt-gt c-electric-slash))
 '(company-idle-delay 1000)
 '(company-minimum-prefix-length 5)
 '(company-tooltip-idle-delay 1000)
 '(compilation-window-height 50)
 '(custom-safe-themes
   '("3a2e0c5597f6d74d99daa2b5bbbc2a653d02d6b88fcd73d3c84ebf25cde37b3f"
     "ea287582eaea4e0c0a991ad0aa42f679f21b8d92766762bcc4d730d4aa6c8fd7"
     "117efd35bd4451a2d4ee0180cb2dbfc8601af5c4d9ade3ea575d2afdda0feb82"
     "bb7303ab60750380957d8205794d031ab222390673ff6dd6369d0277b966c1d4"
     "79485bab8bb220562d4acd003e4b6f1c9005af41e91f81b7a0e89b7e3a301203"
     "725a0ac226fc6a7372074c8924c18394448bb011916c05a87518ad4563738668"
     "b550fc3d6f0407185ace746913449f6ed5ddc4a9f0cf3be218af4fb3127c7877"
     "573e46dadf8c2623256a164831cfe9e42d5c700baed1f8ecd1de0675072e23c2"
     "6bb466c89b7e3eedc1f19f5a0cfa53be9baf6077f4d4a6f9b5d087f0231de9c8"
     "590759adc4a5bf7a183df81654cce13b96089e026af67d92b5eec658fb3fe22f"
     "50d9d021d33feb35a2328ee7dd4cba97b43815f6972c878f0411d2945e6d0d78"
     "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02"
     "a718cd3fde3231c20a8b8a0c342674a39b8916916195448efc2434ffd354e0ed"
     "a2c537c981b4419aa3decac8e565868217fc2995b74e1685c5ff8c6d77b198d6"
     "6e05b0a83b83b5efd63c74698e1ad6feaddf69a50b15a8b4a83b157aac45127c" default))
 '(desktop-restore-eager 100)
 '(desktop-save-mode t)
 '(erc-irccontrols-mode t)
 '(erc-notifications-mode t)
 '(fci-rule-color "#202325")
 '(fill-column 100)
 '(flycheck-check-syntax-automatically '(save idle-change mode-enabled))
 '(frame-zoom-font-difference 3)
 '(gc-cons-percentage 0.5)
 '(gc-cons-threshold 500000000)
 '(global-auto-revert-mode t)
 '(haskell-compile-command
   "ghc -Wall -ferror-spans -fforce-recomp -make -dynamic -c %s")
 '(ido-create-new-buffer 'always)
 '(importmagic-style-configuration-alist '((multiline . parentheses) (max_columns . 700)))
 '(jabber-alert-presence-hooks nil)
 '(jit-lock-chunk-size 4096)
 '(jit-lock-stealth-nice 0.5)
 '(jit-lock-stealth-time 1.25)
 '(lsp-pyright-venv-path "~/.pyenv/versions/")
 '(lsp-rust-server 'rls)
 '(lsp-ui-doc-delay 1)
 '(lsp-ui-doc-use-webkit nil)
 '(ob-mermaid-cli-path "/usr/bin/mmdc")
 '(org-agenda-files '("~/Documents/Notes/WeightLoss.org" "~/Documents/agenda/"))
 '(org-confirm-babel-evaluate nil)
 '(org-jira-reverse-comment-order t)
 '(org-trello-current-prefix-keybinding "C-c o")
 '(org-trello-files
   '("~/Documents/Notes/MetricPlatform.org" "~/Documents/Notes/PlatformLedGrowth.org"))
 '(org-trello-mode-limit-fetch-since "2022-04-20")
 '(orgtrello-log-level 3)
 '(package-selected-packages
   '(ace-jump-mode achievements ack aider async async-await auto-virtualenvwrapper bazel chatgpt-shell
                   clang-format code-stats company-go company-racer dash-at-point dockerfile-mode
                   doremi-frm edit-server editorconfig editorconfig-core eglot ein eslintd-fix
                   exec-path-from-shell expand-region find-file-in-repository flatland-theme
                   floobits flycheck-eglot flycheck-golangci-lint flycheck-rust flymake flymake-go
                   flymake-ruff frame-restore fsharp-mode fsm github-notifier github-review glab
                   gnu-elpa-keyring-update go-errcheck go-imports go-mode go-playground go-scratch
                   golint gotham-theme haskell-mode hcl-mode helm "helm" hound
                   ido-complete-space-or-hyphen ido-vertical-mode importmagic jq-mode js-comint
                   js-doc json-mode jsonnet-mode jss jsx-mode jupyter key-chord lsp-java lsp-mode
                   lsp-pyright lsp-ui markdown-preview-eww markdown-preview-mode mediawiki
                   mermaid-mode multiple-cursors node-resolver nodejs-repl nvm ob-mermaid omnisharp
                   org-jira org-trello ox-clip ox-gfm pabbrev php-mode poly-ansible poly-markdown
                   powershell-mode prettier prettier-js protobuf-mode pyenv-mode pyimport
                   python-black python-isort python-pytest racer react-snippets restclient rjsx-mode
                   rust-playground scss-mode session smex string-inflection sublime-themes sx
                   terraform-mode tide todoist tree-sitter tree-sitter-langs typescript-mode typing
                   typing-practice urlenc vue-mode web wiki ws-trim xml-rpc yafolding
                   yasnippet-snippets zoom-frm ztree))
 '(request-backend 'url-retrieve)
 '(session-use-package t nil (session))
 '(tab-stop-list
   '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
 '(todoist-backing-buffer "~/Documents/agenda/todoist.org")
 '(vc-annotate-background "#1f2124")
 '(vc-annotate-color-map
   '((20 . "#ff0000") (40 . "#ff4a52") (60 . "#f6aa11") (80 . "#f1e94b") (100 . "#f5f080")
     (120 . "#f6f080") (140 . "#41a83e") (160 . "#40b83e") (180 . "#b6d877") (200 . "#b7d877")
     (220 . "#b8d977") (240 . "#b9d977") (260 . "#93e0e3") (280 . "#72aaca") (300 . "#8996a8")
     (320 . "#afc4db") (340 . "#cfe2f2") (360 . "#dc8cc3")))
 '(vc-annotate-very-old-color "#dc8cc3")
 '(vc-git-print-log-follow t)
 '(vc-git-show-stash 10)
 '(visible-bell nil)
 '(yas-prompt-functions '(yas/no-prompt))
 '(yas-triggers-in-field t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))

(put 'downcase-region 'disabled nil)
(when (auth-source-search :host "todoist")
  (setq todoist-token (funcall (plist-get (car (auth-source-search :host "todoist")) :secret))))

(when (auth-source-search :host "codestats.net")
  (setq code-stats-token
        (auth-source-pick-first-password :host "codestats.net"))
  (add-hook 'prog-mode-hook #'code-stats-mode)
  (run-with-idle-timer 30 t #'code-stats-sync)
  (add-hook 'kill-emacs-hook (lambda () (code-stats-sync :wait))))

(when (auth-source-search :host "openai")
  (setq chatgpt-shell-openai-key (funcall (plist-get (car (auth-source-search :host "openai")) :secret))))

(when (auth-source-search :host "claude")
  (setenv "ANTHROPIC_API_KEY"
        (auth-source-pick-first-password :host "claude")))

(setq-default tide-user-preferences '(:importModuleSpecifierPreference "relative" :includeCompletionsForModuleExports t :includeCompletionsWithInsertText t :allowTextChangesInNewFiles t))

(setq compilation-scroll-output 'first-error)
