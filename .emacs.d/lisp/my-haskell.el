(use-package haskell-mode
  :ensure t
  :commands haskell-mode
  :init
  (add-hook 'haskell-mode-hook 'haskell-doc)
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
   "e"    '(:ignore t :which-key "eval")
   "eb"   'dante-eval-block
   "r"    'dante-restart))

(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'dante-mode)
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  ;; load dir-local dante-target before dante-mode
  (add-hook 'haskell-mode-hook 'hack-dir-local-variables-non-file-buffer)
  (add-hook 'dante-mode-hook
            '(lambda () (flycheck-add-next-checker 'haskell-dante
                                                   '(warning . haskell-hlint))))
  :config
  (setq company-backend 'dante-company))

(use-package flycheck-haskell
  :ensure t
  :commands flycheck-haskell-configure
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-haskell-setup))


(provide 'my-haskell)
