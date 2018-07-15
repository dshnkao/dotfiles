(use-package go-mode
  :ensure t
  :commands go-mode
  :init
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'go-mode-map
   "gg" 'godef-jump
   "ht" 'godef-describe
   "bf" 'gofmt))

(use-package company-go
  :ensure t
  :after go-mode
  :init
  (add-hook 'go-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends) '(company-go))
              (company-mode))))

(use-package go-eldoc
  :ensure t
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(provide 'my-go)
