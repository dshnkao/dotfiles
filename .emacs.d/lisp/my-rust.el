(use-package rust-mode
  :ensure t
  :commands rust-mode
  :init
  (add-hook 'rust-mode-hook 'rust-doc)
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'rust-mode-map
   "ht"   'racer-describe
   "gg"   'racer-find-definition
   "cc"   'rust-compile
   "dd"   'racer-debug))

(use-package racer
  :ensure t
  :after rust-mode
  :init
  (add-hook 'rust-mode-hook 'racer-mode)
  (add-hook 'racer-mode-hook 'eldoc-mode)
  (add-hook 'racer-mode-hook 'company-mode))

(use-package flycheck-rust
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(provide 'my-rust)
