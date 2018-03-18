(use-package cider
  :ensure t
  :pin melpa-stable
  :commands cider-mode
  :init
  (add-hook 'cider-mode-hook 'clojure-doc)
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'clojure-mode-map
   "h"    '(:ignore t :which-key "documentation")
   "ha"   'cider-apropos
   "hg"   'cider-grimoire
   "hj"   'cider-javadoc
   "hn"   'cider-browse-ns
   "ht"   'cider-doc
   "e"    '(:ignore t :which-key "eval")
   "eb"   'cider-eval-buffer
   "ee"   'cider-eval-last-sexp
   "ef"   'cider-eval-defun-at-point
   "er"   'cider-eval-last-sexp-to-repl
   "eg"   'cider-eval-defun-to-comment
   "g"    '(:ignore t :which-key "goto")
   "gb"   'cider-pop-back
   "ge"   'cider-jump-to-compilation-error
   "gr"   'cider-jump-to-locref-at-point
   "sb"   'cider-load-buffer
   "sx"   'cider-refresh
   "="    'cider-format-buffer
   "'"    'cider-jack-in))

(provide 'my-clojure)
