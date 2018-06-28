(use-package evil
  :ensure t
  :after dired
  :init
  (define-key dired-mode-map (kbd "SPC") nil)
  (setq evil-search-module 'evil-search)
  (setq evil-want-C-u-scroll t)
  (setq evil-mode-line-format nil)
  :config
  (evil-mode 1))

(use-package general
  :ensure t
  :config
  (general-evil-setup)
  (general-define-key
   :states '(normal insert visual emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"
   ;; Applications
   "a"   '(:ignore t :which-key "applications")
   "ad"  'counsel-dash-at-point
   "af"  'counsel-fzf
   "ay"  'yas-insert-snippet
   ;; buffers
   "b"   '(:ignore t :which-key "buffers")
   "bb"  'ivy-switch-buffer
   "bd"  'kill-this-buffer
   "bu"  'revert-buffer
   "be"  'eval-buffer
   "bn"  '((lambda () (interactive) (let (($buf (generate-new-buffer "untitled"))) (switch-to-buffer $buf))) :wk "new-buffer")
   ;; e
   "ev"  'set-variable
   ;; files
   "f"   '(:ignore t :which-key "files")
   "fs"  'save-buffer
   "ff"  'counsel-find-file
   "fj"  'dired-jump
   "fr"  'counsel-recentf
   "ft"  'neotree-toggle
   "fed" '((lambda () (interactive) (find-file "~/.emacs.d/init.el")) :wk "init.el")
   ;; project
   "p"   '(:ignore t :which-key "project")
   "pp"  'counsel-projectile-switch-project
   "pf"  'counsel-projectile-find-file
   "pb"  'counsel-projectile-switch-to-buffer
   "pg"  'counsel-projectile-rg
   "px"  'projectile-invalidate-cache
   ;; search
   "s"   '(:ignore t :which-key "search")
   "sc"  'evil-ex-nohighlight
   "sp"  'counsel-projectile-rg
   "sb"  'counsel-projectile-switch-to-buffer
   "sg"  'google-this
   ;; toggle
   "t"   '(:ignore t : which-key "toggle")
   "td"  'diff-hl-mode
   "tg"  'zoom-mode
   "tm"  'minimap-mode
   "tw"  'whitespace-mode
   "tr"  'rainbow-mode
   "ts"  'flyspell-mode
   "tp"  'smartparens-mode
   ;; windows
   "w"   '(:ignore t :which-key "windows")
   "wm"  'maximize-window
   "wd"  'delete-window
   "wo"  'delete-other-windows
   "w/"  'split-window-right
   "w-"  'split-window-below
   "wh"  'windmove-left
   "wj"  'windmove-down
   "wk"  'windmove-up
   "wl"  'windmove-right
   "wu"  'winner-undo
   "wr"  'winner-redo
   "wH"  'buf-move-left
   "wJ"  'buf-move-down
   "wK"  'buf-move-up
   "wL"  'buf-move-right
   ;; git
   "g"   '(:ignore t :which-key "git")
   "gc"  'magit-checkout
   "gb"  'magit-blame
   "gfa" 'magit-fetch-all
   "gl"  'magit-log
   "gs"  'magit-status
   "gt"  'git-timemachine
   ;; extra
   "x"   '(:ignore t :which-key "extra")
   "xd"  '(:ignore t :which-key "delete")
   "xdw" 'delete-trailing-whitespace
   ;; others
   "SPC" (general-simulate-key "M-x"))
  ;; Emacs Lisp
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'emacs-lisp-mode-map
   "hk"   'describe-key
   "ht"   'describe-function
   "hv"   'describe-variable
   "gg"   'xref-find-definitions)
  )

(provide 'my-evil)
