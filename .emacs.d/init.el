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

(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'my-ui)
(require 'my-apps)
(require 'my-clojure)
(require 'my-dev)
(require 'my-evil)
(require 'my-git)
(require 'my-haskell)
(require 'my-ivy)
(require 'my-latex)
(require 'my-macos)
(require 'my-markdown)
(require 'my-nix)
(require 'my-org)
(require 'my-python)
(require 'my-rust)
(require 'my-scala)
(require 'my-settings)
(require 'my-shell)
(require 'my-snippet)
(require 'my-typescript)
(require 'my-yaml)

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
    (ensime flycheck-rust racer rust-mode git-timemachine evil-magit magit cider pdf-tools zoom yaml-mode which-key use-package smartparens smart-mode-line rainbow-mode ox-pandoc nix-mode neotree minimap markdown-mode linum-relative google-this general fzf flycheck-haskell evil diff-hl dante counsel-projectile counsel-dash company color-theme-sanityinc-tomorrow buffer-move auctex-latexmk all-the-icons ace-window)))
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
 '(cursor ((t (:background "IndianRed3"))))
 '(minimap-active-region-background ((t (:background "gray0"))))
 '(mode-line ((t (:background "firebrick4" :foreground "#c5c8c6" :inverse-video nil :box (:line-width 1 :color "#373b41") :weight normal))))
 '(mode-line-buffer-id ((t (:foreground "gainsboro"))))
 '(mode-line-highlight ((t (:foreground "white" :box nil :weight bold)))))
;;; init.el ends here
