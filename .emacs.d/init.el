;;; Package --- ...
;;; Commentary:
;;; Code:
(setq package-enable-at-startup nil)
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; general settings
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(column-number-mode t)
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)

;; packages

;; appearance

(use-package linum-relative
  :ensure t
  :config
  (linum-relative-global-mode)
  (setq linum-relative-current-symbol ""))

(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/theme 'respectful)
  (setq sml/shorten-directory t)
  (setq sml/shorten-modes t)
  (setq sml/no-confirm-load-theme t)
  :config
  (sml/setup)
  )

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-night t))

(use-package all-the-icons
  :ensure t)

;; tools

(use-package evil
  :ensure t
  :init
  (setq evil-search-module 'evil-search)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode))

(use-package neotree
  :ensure t
  :commands 'neotree-toggle
  :after evil
  :init
  (setq neo-theme 'icons)
  :config
  (evil-make-overriding-map neotree-mode-map 'normal))

(use-package ace-window
  :ensure t)

(use-package avy
  :ensure t
  :commands (avy-goto-word-1))

(use-package ivy
  :ensure t
  :config
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line))

(use-package counsel
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package counsel-projectile
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (projectile-mode))

;; dev

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; haskell
(use-package haskell-mode :ensure t)
(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'dante-mode)
  (add-hook 'haskell-mode-hook 'flycheck-mode))

(use-package general
  :ensure t
  :config
  (general-define-key
    :states '(normal insert visual emacs)
    :prefix "SPC"
    :non-normal-prefix "C-SPC"
    ;; Applications
    "a"   '(:ignore t :which-key "applications")
    "ar"  'ranger
    "ad"  'dired
    ;; buffers
    "b"   '(:ignore t :which-key "buffers")
    "bb"  'ivy-switch-buffer
    "bd"  'kill-this-buffer
    ;; files
    "f"   '(:ignore t :which-key "files")
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
    ;; search
    "s"   '(:ignore t :which-key "search")
    "sc"  'evil-ex-nohighlight
    ;; windows
    "w"   '(:ignore t :which-key "windows")
    "wd"  'delete-window
    "w/"  'split-window-right
    "w-"  'split-window-below
    "wh"  'windmove-left
    "wj"  'windmove-down
    "wk"  'windmove-up
    "wl"  'windmove-right
    ;; others
    "SPC" (general-simulate-keys "M-x")
    "TAB" '(switch-to-other-buffer :which-key "prev buffer")
    "/"   'counsel-rg
    )
  ;; Haskell
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'dante-mode-map
   "ht"   'dante-type-at
   "hi"   'dante-info
   "gg"   'xref-find-definitions
   "gr"   'xref-find-references
   ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    (default)))
 '(package-selected-packages (quote (evil pdf-tools use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "firebrick4" :foreground "#c5c8c6" :inverse-video nil :box (:line-width 1 :color "#373b41") :weight normal)))))
(provide 'init)
;;; init.el ends here
