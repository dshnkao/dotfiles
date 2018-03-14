(use-package linum-relative
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'linum-relative-mode)
  (add-hook 'org-mode-hook 'linum-relative-mode)
  (setq linum-relative-current-symbol ""))

;;(use-package smart-mode-line
;;  :ensure t
;;  :init
;;  (setq sml/theme 'respectful)
;;  (setq sml/shorten-directory t)
;;  (setq sml/shorten-modes t)
;;  (setq sml/no-confirm-load-theme t)
;;  (setq rm-whitelist '(""))
;;  :config
;;  (rich-minority-mode 1)
;;  (sml/setup))

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  :config
  (load-theme 'sanityinc-tomorrow-night t)
  (set-face-attribute 'fringe nil :background "#1d1f21")
  (add-to-list 'default-frame-alist '(left-fringe . 5))
  (add-to-list 'default-frame-alist '(right-fringe . 5))
  (set-face-attribute 'linum nil :background "#1d1f21"))

(use-package all-the-icons
  :ensure t
  :after neotree)

(provide 'my-ui)
