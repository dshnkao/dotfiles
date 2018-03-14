(use-package ivy
  :ensure t
  :config
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line))

(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t)

(use-package counsel-dash
  :ensure t
  :config
  ;; (setq helm-dash-browser-func 'eww)
  (defun counsel-dash-at-point () (interactive) (counsel-dash (thing-at-point 'symbol)))
  (defun clojure-doc () (interactive) (setq-local helm-dash-docsets '("Clojure")))
  (defun scala-doc () (interactive) (setq-local helm-dash-docsets '("Scala")))
  (defun haskell-doc () (interactive) (setq-local helm-dash-docsets '("Haskell")))
  (defun rust-doc () (interactive) (setq-local helm-dash-docsets '("Rust"))))

(use-package counsel-projectile
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (projectile-mode))

(provide 'my-ivy)
