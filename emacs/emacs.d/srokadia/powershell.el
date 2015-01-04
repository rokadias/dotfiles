(when (package-installed-p 'powershell-mode)
  ;; powershell-mode
  (autoload 'powershell-mode "powershell-mode" "A editing mode for Microsoft Powershell." t)
  (add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode)) ; Powershell script
  (add-to-list 'auto-mode-alist '(".*PowerShell.*\\'" . powershell-mode))
  (setq powershell-indent 2))
