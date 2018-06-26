(use-package scala-mode
  :ensure t
  :commands scala-mode
  :init
  (add-hook 'ensime-mode-hook 'scala-doc)
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'scala-mode-map
   "ht"   'ensime-type-at-point
   "gg"   'ensime-goto-source-location
   "ee"   'ensime-print-errors-at-point))

(use-package ensime
  :ensure t
  :commands ensime-mode)

(provide 'my-scala)
