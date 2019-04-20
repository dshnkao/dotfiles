(use-package lsp-mode
  :ensure t
  :commands lsp
  :config
  (add-hook 'typescript-mode-hook #'lsp))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company-lsp
  :ensure t
  :commands company-lsp)

(provide 'my-lsp)
