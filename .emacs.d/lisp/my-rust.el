(use-package rust-mode
  :ensure t
  :commands rust-mode
  :init
  (add-hook 'rust-mode-hook 'rust-doc)
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'rust-mode-map
   "h"    '(:ignore t :which-key "help")
   "ht"   'racer-describe
   "g"    '(:ignore t :which-key "goto")
   "gg"   'racer-find-definition
   "c"    '(:ignore t :which-key "cargo")
   "cc"   'rust-compile
   "cb"   'cargo-process-build
   "cf"   'cargo-process-fmt
   "d"    '(:ignore t :which-key "debug")
   "dd"   'racer-debug))

(use-package racer
  :ensure t
  :after rust-mode
  :init
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(use-package cargo
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
