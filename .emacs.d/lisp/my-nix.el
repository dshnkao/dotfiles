(use-package nix-mode
  :ensure t
  :commands nix-mode
  :config
  (setq nix-indent-function 'nix-indent-line))

(use-package nix-buffer
  :ensure t)

(provide 'my-nix)
