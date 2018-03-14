(use-package cider
  :ensure t
  :pin melpa-stable
  :commands cider-mode
  :init
  (add-hook 'cider-mode-hook 'clojure-doc)
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
   "'"    'cider-jack-in))

(provide 'my-clojure)
