;;; package --- Summary
;;; Commentary:
;;; Code:
(setq gc-cons-threshold 100000000) ;;100MB
(setq package-enable-at-startup nil)
(setq package-archives '(("org"          . "http://orgmode.org/elpa/")
                         ("gnu"          . "http://elpa.gnu.org/packages/")
                         ("melpa"        . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("marmalade"    . "http://marmalade-repo.org/packages/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; general settings
;; (menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)     ;; appearance settings, see Xresources also
(column-number-mode t) ;; display column num in mode line
(winner-mode t)        ;; more window functions
(show-paren-mode t)
(setq help-window-select t)
(setq require-final-newline t)
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)

(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta
        mac-command-modifier 'super))

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
  :init
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  :config
  (global-diff-hl-mode)
  (diff-hl-dired-mode)
  (diff-hl-flydiff-mode))

(use-package linum-relative
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'linum-relative-mode)
  (add-hook 'org-mode-hook 'linum-relative-mode)
  (setq linum-relative-current-symbol ""))

(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/theme 'respectful)
  (setq sml/shorten-directory t)
  (setq sml/shorten-modes t)
  (setq sml/no-confirm-load-theme t)
  :config
  (sml/setup))

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

(use-package fira
  :load-path "lisp"
  :pin manual
  :defer t
  :init
  ;; without emacs daemon
  (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")
  ;; emacs daemon
  (add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")))
  :config
  (add-hook 'prog-mode-hook 'my-set-fira-ligatures))

;; tools

(use-package evil
  :ensure t
  :init
  (setq evil-search-module 'evil-search)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

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
  :commands neotree-toggle
  :after evil
  :init
  (setq neo-theme 'icons)
  (setq neo-smart-open t))

(use-package ace-window
  :ensure t
  :commands (winner-undo winner-redo))

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

(use-package fzf
  :ensure t)

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

(use-package zoom
  :ensure t
  :commands zoom-mode)

(use-package buffer-move
  :ensure t
  :commands (buf-move-up buf-move-down buf-move-left buf-move-right))

(use-package minimap
  :ensure t
  :commands minimap-mode)

(use-package rainbow-mode
  :ensure t
  :commands rainbow-mode)

(use-package google-this
  :ensure t
  :commands google-this)

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode))

(use-package auctex-latexmk
  :ensure t
  :init
  (setq TeX-PDF-mode t)
  (setq auctex-latexmk-inherit-TeX-PDF-mode t)
  :commands auctex-latex-mk-setup)

(use-package org
  :ensure t
  :commands org-mode
  :init
  (setq org-directory "~/repos/my/org"))

;; dev

(use-package yaml-mode
  :ensure t
  :commands yaml-mode)

(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :config
  (global-flycheck-mode))

(use-package ensime
  :ensure t
  :commands ensime-mode)

(use-package flycheck-haskell
  :ensure t
  :commands flycheck-haskell-configure
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

(use-package haskell-mode
  :ensure t
  :commands haskell-mode)

(use-package dante
  ;; :load-path "foss/dante/"
  ;; :pin manual
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (setq company-backend 'dante-company)
  (add-hook 'haskell-mode-hook 'dante-mode)
  ;; load dir-local dante-target before dante-mode
  (add-hook 'haskell-mode-hook 'hack-dir-local-variables-non-file-buffer)
  (add-hook 'dante-mode-hook
            '(lambda () (flycheck-add-next-checker 'haskell-dante
                                                   '(warning . haskell-hlint)))))

(use-package cider
  :ensure t
  :pin melpa-stable
  :commands cider-mode)

(use-package rust-mode
  :ensure t
  :commands rust-mode)

(use-package racer
  :ensure t
  :after rust-mode
  :config
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode))

(use-package flycheck-rust
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package nix-mode
  :ensure t
  :commands nix-mode)

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
   "af"  'fzf
   "ar"  'ranger
   "ad"  'dired
   ;; buffers
   "b"   '(:ignore t :which-key "buffers")
   "bb"  'ivy-switch-buffer
   "bd"  'kill-this-buffer
   "bu"  'revert-buffer
   "be"  'eval-buffer
   "bn"  (lambda () (interactive) (let (($buf (generate-new-buffer "untitled"))) (switch-to-buffer $buf)))
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
   ;;"wm"  'default-win
   "wd"  'delete-window
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
   "gb"  'magit-blame
   "gs"  'magit-status
   "gl"  'magit-log
   "gt"  'git-timemachine
   ;; quit
   "q" 'delete-other-windows
   ;; others
   "SPC" (general-simulate-keys "M-x")
   "TAB" '(switch-to-other-buffer :which-key "prev buffer")
   "/"   'counsel-rg)
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
   "br"  'neotree-refresh)
  ;; markdown
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'markdown-mode-map
   "p"    '(:ignore t :which-key "preview")
   "pl"   'markdown-live-preview-mode
   "pb"   'markdown-preview)
  ;; Emacs Lisp
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'emacs-lisp-mode-map
   "hk"   'describe-key
   "ht"   'describe-function
   "hv"   'describe-variable
   "gg"   'xref-find-definitions)
  ;; LaTeX
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'LaTeX-mode-map
   "v"      'TeX-view
   "r"      'TeX-command-run-all)
  ;; Clojure
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'clojure-mode
   "ha"   'cider-apropos
   "hg"   'cider-grimoire
   "hj"   'cider-javadoc
   "hn"   'cider-browse-ns
   "ht"   'cider-doc
   "eb"   'cider-eval-buffer
   "ee"   'cider-eval-last-sexp
   "gb"   'cider-pop-back
   "ge"   'cider-jump-to-compilation-error
   "gr"   'cider-jump-to-locref-at-point
   "sb"   'cider-load-buffer
   "sx"   'cider-refresh
   "="    'cider-format-buffer
   "'"    'cider-jack-in)
  ;; Rust
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'rust-mode-map
   "ht"   'racer-describe
   "hd"   'racer-find-definition
   "cc"   'rust-compile
   "dd"   'racer-debug)
  ;; Scala
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'ensime-mode-map
   "ht"   'ensime-type-at-point
   "gg"   'ensime-goto-source-location
   "ee"   'ensime-print-errors-at-point)
  ;; Haskell
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'dante-mode-map
   "d"    '(:ignore t :which-key "debug")
   "dd"   'dante-diagnose
   "h"    '(:ignore t :which-key "documentation")
   "ht"   'dante-type-at
   "hi"   'dante-info
   "g"    '(:ignore t :which-key "goto")
   "gg"   'xref-find-definitions
   "gr"   'xref-find-references
   "eb"   'dante-eval-block
   "r"    'dante-restart))

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
 '(dante-load-flags
   (quote
    ("+c" "-fdefer-typed-holes" "-fno-diagnostics-show-caret")))
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(inhibit-startup-screen t)
 '(minimap-highlight-line nil)
 '(package-selected-packages
   (quote
    (racer racer-mode flycheck-rust rust-mode ensime yaml-mode smartparens git-timemachine google-this rainbow-mode minimap buffer-move haskell-process haskell-interactive-mode flycheck-haskell nix-mode cider evil-magit magit evil pdf-tools use-package)))
 '(safe-local-variable-values
   (quote
    ((dante-target . "lib:bowling")
     (dante-target . "level07")
     (dante-target . "lib:bmm"))))
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
 '(vc-annotate-very-old-color nil)
 '(zoom-size (quote (0.618 . 0.618))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-active-region-background ((t (:background "gray0"))))
 '(mode-line ((t (:background "firebrick4" :foreground "#c5c8c6" :inverse-video nil :box (:line-width 1 :color "#373b41") :weight normal)))))
;;; init.el ends here
