(use-package linum-relative
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'linum-relative-mode)
  (add-hook 'org-mode-hook 'linum-relative-mode)
  (add-hook 'yaml-mode-hook 'linum-relative-mode)
  (setq linum-relative-current-symbol ""))

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

(use-package evil-terminal-cursor-changer
  :ensure t
  :init
  (setq evil-motion-state-cursor 'box)
  (setq evil-visual-state-cursor 'box)
  (setq evil-normal-state-cursor 'box)
  (setq evil-insert-state-cursor 'bar)
  (setq evil-emacs-state-cursor  'hbar)
  :config
  (evil-terminal-cursor-changer-activate))

(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT aligned respectively."
  (let* ((available-width (- (window-width) (length left) 2)))
    (format (format " %%s %%%ds " available-width) left right)))

(setcar mode-line-position
        '(:eval (format "%3d%%" (/ (window-start) 0.01 (point-max)))))

(setq-default mode-line-format
              '((:eval (simple-mode-line-render
                        ;; left
                        (format-mode-line "%b [%m] [%*]")
                        ;; right
                        (format-mode-line "%l/%c %p")))))


;; kde sets default xresources, annoying
(setq inhibit-x-resources 't)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(add-to-list 'default-frame-alist
             '(font . "Dejavu Sans Mono-11"))


(provide 'my-ui)
