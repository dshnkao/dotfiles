(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'markdown-mode-map
   "p"    '(:ignore t :which-key "preview")
   "pl"   'markdown-live-preview-mode
   "pb"   'markdown-preview))

(provide 'my-markdown)
