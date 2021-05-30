(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#26292c" "#ff4a52" "#40b83e" "#f6f080" "#afc4db" "#dc8cc3" "#93e0e3" "#f8f8f8"])
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
 '(case-replace t)
 '(company-async-redisplay-delay 10)
 '(company-begin-commands
   '(c-scope-operator c-electric-colon c-electric-lt-gt c-electric-slash))
 '(company-idle-delay 1000)
 '(company-minimum-prefix-length 5)
 '(company-tooltip-idle-delay 1000)
 '(compilation-window-height 50)
 '(custom-safe-themes
   '("ea287582eaea4e0c0a991ad0aa42f679f21b8d92766762bcc4d730d4aa6c8fd7" "117efd35bd4451a2d4ee0180cb2dbfc8601af5c4d9ade3ea575d2afdda0feb82" "bb7303ab60750380957d8205794d031ab222390673ff6dd6369d0277b966c1d4" "79485bab8bb220562d4acd003e4b6f1c9005af41e91f81b7a0e89b7e3a301203" "725a0ac226fc6a7372074c8924c18394448bb011916c05a87518ad4563738668" "b550fc3d6f0407185ace746913449f6ed5ddc4a9f0cf3be218af4fb3127c7877" "573e46dadf8c2623256a164831cfe9e42d5c700baed1f8ecd1de0675072e23c2" "6bb466c89b7e3eedc1f19f5a0cfa53be9baf6077f4d4a6f9b5d087f0231de9c8" "590759adc4a5bf7a183df81654cce13b96089e026af67d92b5eec658fb3fe22f" "50d9d021d33feb35a2328ee7dd4cba97b43815f6972c878f0411d2945e6d0d78" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "a718cd3fde3231c20a8b8a0c342674a39b8916916195448efc2434ffd354e0ed" "a2c537c981b4419aa3decac8e565868217fc2995b74e1685c5ff8c6d77b198d6" "6e05b0a83b83b5efd63c74698e1ad6feaddf69a50b15a8b4a83b157aac45127c" default))
 '(erc-irccontrols-mode t)
 '(erc-notifications-mode t)
 '(fci-rule-color "#202325")
 '(flycheck-check-syntax-automatically '(save mode-enabled))
 '(haskell-compile-command
   "ghc -Wall -ferror-spans -fforce-recomp -make -dynamic -c %s")
 '(ido-create-new-buffer 'always)
 '(jabber-alert-presence-hooks nil)
 '(lsp-rust-server 'rls)
 '(lsp-ui-doc-delay 1)
 '(lsp-ui-doc-use-webkit nil)
 '(ob-mermaid-cli-path "/usr/bin/mmdc")
 '(org-agenda-files '("~/Documents/agenda/work.org"))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   '(ox-slack github-notifier js-import github-review eslintd-fix js-doc prettier-js jupyter markdown-preview-eww poly-ansible poly-markdown polymode rjsx-mode docker-tramp floobits php-mode jq-mode yasnippet-snippets todoist lsp-python-ms pyenv-mode graphviz-dot-mode ob-mermaid pivotal-tracker kubernetes-tramp lsp-ui mermaid-mode lsp-vue vue-mode protobuf-mode company-lsp lsp-mode elpy terraform-mode cargo company-racer flycheck-rust racer rust-mode rust-playground cider clojure-mode go-scratch company-go flycheck-golangci-lint go-imports go-playground golint jss uuidgen ztree zoom-frm zenburn-theme yaml-mode xml-rpc ws-trim wiki web-mode web use-package typing-practice typing tide sx sublime-themes smex slime session scss-mode restclient react-snippets powershell-mode powershell pabbrev omnisharp nvm nodejs-repl node-resolver multiple-cursors mediawiki markdown-preview-mode magit key-chord jsx-mode json-mode js-comint ido-vertical-mode hound helm hcl-mode haskell-mode gotham-theme go-mode go-errcheck fsm fsharp-mode frame-restore flymake-go flymake flatland-theme find-file-in-repository expand-region exec-path-from-shell editorconfig-core editorconfig edit-server doremi-frm dockerfile-mode dash-at-point color-theme ack achievements ace-jump-mode ac-js2))
 '(session-use-package t nil (session))
 '(tab-stop-list
   '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
 '(vc-annotate-background "#1f2124")
 '(vc-annotate-color-map
   '((20 . "#ff0000")
     (40 . "#ff4a52")
     (60 . "#f6aa11")
     (80 . "#f1e94b")
     (100 . "#f5f080")
     (120 . "#f6f080")
     (140 . "#41a83e")
     (160 . "#40b83e")
     (180 . "#b6d877")
     (200 . "#b7d877")
     (220 . "#b8d977")
     (240 . "#b9d977")
     (260 . "#93e0e3")
     (280 . "#72aaca")
     (300 . "#8996a8")
     (320 . "#afc4db")
     (340 . "#cfe2f2")
     (360 . "#dc8cc3")))
 '(vc-annotate-very-old-color "#dc8cc3")
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
