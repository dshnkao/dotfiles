(use-package auctex-latexmk
  :ensure t
  :commands auctex-latex-mk-setup
  :init
  (setq TeX-PDF-mode t)
  (setq auctex-latexmk-inherit-TeX-PDF-mode t)
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'LaTeX-mode-map
   "v"      'TeX-view
   "r"      'TeX-command-run-all))

(provide 'my-latex)
