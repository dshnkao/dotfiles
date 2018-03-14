(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.

(setq backup-directory-alist '(("" . "~/.emacs.d/backup/per-save")))

(toggle-scroll-bar -1)
(tool-bar-mode -1)     ;; appearance settings, see Xresources also
(column-number-mode t) ;; display column num in mode line
(winner-mode t)        ;; more window functions
(show-paren-mode t)
(setq help-window-select t)
(setq require-final-newline t)
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq dired-auto-revert-buffer t)
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

(provide 'my-settings)
