(use-package diff-hl
  :ensure t
  :init
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  :config
  (global-diff-hl-mode)
  (diff-hl-dired-mode)
  (diff-hl-flydiff-mode))

(use-package magit
  :ensure t
  :commands magit-status)

(use-package evil-magit
  :ensure t
  :after magit
  :init
  (setq evil-magit-want-horizontal-movement nil))

(use-package git-timemachine
  :ensure t
  :commands git-timemachine
  :config
  (evil-make-overriding-map git-timemachine-mode-map 'normal)
  ;; force update evil keymaps after git-timemachine-mode loaded
  (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps))

(provide 'my-git)
