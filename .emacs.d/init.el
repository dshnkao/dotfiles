;;; package --- Summary
;;; Commentary:
;;; Code:
(setq gc-cons-threshold 100000000) ;;100MB
(setq package-enable-at-startup nil)
(setq package-archives '(("org"          . "http://orgmode.org/elpa/")
                         ("gnu"          . "http://elpa.gnu.org/packages/")
                         ("melpa"        . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")))
;;                         ("marmalade"    . "http://marmalade-repo.org/packages/"))) ;; abandoned
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
(require 'my-go)
(require 'my-haskell)
(require 'my-ivy)
(require 'my-latex)
(require 'my-lsp)
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
(require 'my-terraform)
(require 'my-typescript)
(require 'my-yaml)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(beacon-color "#cc6666")
 '(custom-safe-themes
   (quote
    ("ae65ccecdcc9eb29ec29172e1bfb6cadbe68108e1c0334f3ae52414097c501d2" "4cf9ed30ea575fb0ca3cff6ef34b1b87192965245776afa9e9e20c17d115f3fb" "939ea070fb0141cd035608b2baabc4bd50d8ecc86af8528df9d41f4d83664c6a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(dante-load-flags
   (quote
    ("+c" "-fdefer-typed-holes" "-fno-diagnostics-show-caret")))
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(inhibit-startup-screen t)
 '(minimap-highlight-line nil)
 '(package-selected-packages
   (quote
    (moe-theme gruvbox-theme terraform-mode nix-buffer evil-terminal-cursor-changer evil-org white-space ensime flycheck-rust racer rust-mode git-timemachine evil-magit magit cider pdf-tools zoom yaml-mode which-key use-package smartparens smart-mode-line rainbow-mode ox-pandoc nix-mode neotree minimap markdown-mode linum-relative google-this general fzf flycheck-haskell evil diff-hl dante counsel-projectile counsel-dash company color-theme-sanityinc-tomorrow buffer-move auctex-latexmk all-the-icons ace-window)))
 '(safe-local-variable-values
   (quote
    ((dante-target . "lib:bowling")
     (dante-target . "level07")
     (dante-target . "lib:bmm"))))
 '(sp-autoinsert-pair nil)
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
 '(window-divider-mode nil)
 '(zoom-size (quote (0.618 . 0.618))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-active-region-background ((t (:background "gray0"))))
 '(mode-line-highlight ((t (:foreground "white" :box nil :weight bold))))
 '(org-level-1 ((t (:inherit outline-1 :foreground "light coral" :height 1.15))))
 '(org-level-2 ((t (:inherit outline-2 :foreground "wheat" :height 1.1)))))
;;; init.el ends here
