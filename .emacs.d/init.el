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

(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.

(setq backup-directory-alist '(("" . "~/.emacs.d/backup/per-save")))

;; packages

;; appearance

(use-package diff-hl
  :ensure t
  :config
  (diff-hl-mode)
  )

(use-package linum-relative
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'linum-relative-mode)
  (setq linum-relative-current-symbol "")
  :config
  ;;(linum-relative-global-mode)
  ;;(setq linum-relative-current-symbol "")
  ;;(add-hook 'term-mode-hook (lambda () (linum-mode -1)))
  ;;(add-hook 'term-mode-hook (lambda () (linum-mode -1)))
  )

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
  :init
  :config
  (load-theme 'sanityinc-tomorrow-night t)
  (set-face-attribute 'fringe nil :background "#1d1f21")
  (add-to-list 'default-frame-alist '(left-fringe . 5))
  (add-to-list 'default-frame-alist '(right-fringe . 5))
  (set-face-attribute 'linum nil :background "#1d1f21")
  )

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

(use-package magit
  :ensure t
  :config
  (evil-make-overriding-map magit-mode-map 'normal))

(use-package evil-magit
  :ensure t
  :after '(magit evil))

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map [tab] 'company-complete-common-or-cycle)
  (company-mode))

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

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; dev

(use-package flycheck
  :ensure t
  :config (global-flycheck-mode))

(use-package haskell-mode
  :ensure t)
(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'dante-mode)
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'dante-mode-hook
            '(lambda () (flycheck-add-next-checker 'haskell-dante
                                                   '(warning . haskell-hlint)))))

(use-package cider
  :ensure t)

(use-package nix-mode
  :ensure t)

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
    ;; e
    "ev"  'set-variable
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
    "sp"  'counsel-projectile-rg
    "sb"  'counsel-projectile-switch-to-buffer
    ;; toggle
    "t"   '(:ignore t : which-key "toggle")
    "td"  'diff-hl-mode
    ;; windows
    "w"   '(:ignore t :which-key "windows")
    "wd"  'delete-window
    "w/"  'split-window-right
    "w-"  'split-window-below
    "wh"  'windmove-left
    "wj"  'windmove-down
    "wk"  'windmove-up
    "wl"  'windmove-right
    ;; git
    "g"   '(:ignore t :which-key "git")
    "gs"  'magit-status
    ;; quit
    "q" 'delete-other-windows
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
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#373b41" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#c5c8c6"))
 '(beacon-color "#cc6666")
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(dante-target "level07")
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(package-selected-packages
   (quote
    (git-gutter-fringe linum-off nix-mode cider evil-magit magit evil pdf-tools use-package)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "firebrick4" :foreground "#c5c8c6" :inverse-video nil :box (:line-width 1 :color "#373b41") :weight normal)))))
(provide 'init)
;;; init.el ends here
