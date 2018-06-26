(use-package go-mode
  :ensure t
  :commands go-mode)

(use-package company-go
  :ensure t
  :after go-mode)

(use-package go-eldoc
  :ensure t
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(provide 'my-go)
