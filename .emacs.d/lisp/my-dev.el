(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map [tab] 'company-complete-common-or-cycle)
  (define-key global-map (kbd "C-.") 'company-files)
  (company-mode))

(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :config
  (global-flycheck-mode))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-copy-env "GOROOT"))

(use-package whitespace
  :ensure t
  :config
  (setq whitespace-display-mappings
        '((space-mark 32 [183] [46])
          (tab-mark 9 [187 9] [92 9]))))

(setq auto-save-default nil)
(setq-default tab-width 4)

(provide 'my-dev)
