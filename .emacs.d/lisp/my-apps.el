(use-package minimap
  :ensure t
  :commands minimap-mode)

(use-package rainbow-mode
  :ensure t
  :commands rainbow-mode)

(use-package google-this
  :ensure t
  :commands google-this)

(use-package neotree
  :ensure t
  :commands neotree-toggle
  :after evil
  :init
  (setq neo-theme 'icons)
  (setq neo-smart-open t)
  ;; neotree
  (general-define-key
   :states 'normal
   :keymaps 'neotree-mode-map
   "c"   'neotree-create-node
   "d"   'neotree-delete-node
   "r"   'neotree-rename-node
   "q"   'neotree-hide
   "TAB" 'neotree-stretch-toggle
   "RET" 'neotree-enter
   "th"  'neotree-hidden-file-toggle
   "o"   'neotree-open-file-in-system-application
   "br"  'neotree-refresh))

(use-package zoom
  :ensure t
  :commands zoom-mode)

(use-package buffer-move
  :ensure t
  :commands (buf-move-up buf-move-down buf-move-left buf-move-right))

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode))

(use-package ace-window
  :ensure t
  :commands (winner-undo winner-redo))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(provide 'my-apps)
