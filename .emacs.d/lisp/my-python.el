(use-package elpy
  :ensure t
  :commands python-mode
  :init
  (elpy-enable)
  (add-hook 'python-mode-hook 'python-doc)
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'python-mode-map
   "'"    'run-python
   "ht"   'python-eldoc-at-point
   "rb"   'python-shell-send-buffer))

(provide 'my-python)
