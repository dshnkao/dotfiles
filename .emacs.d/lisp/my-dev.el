(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map [tab] 'company-complete-common-or-cycle)
  (company-mode))

(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :config
  (global-flycheck-mode))

(provide 'my-dev)