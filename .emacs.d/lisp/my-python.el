(use-package elpy
  :ensure t
  :commands elpy-mode
  :init
  (add-hook 'python-mode-hook 'python-doc)
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'elpy-mode-map
   "'"    'run-python
   "ht"   'python-eldoc-at-point
   "rb"   'python-shell-send-buffer))

(provide 'my-python)
