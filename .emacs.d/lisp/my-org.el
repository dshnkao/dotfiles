(use-package org
  :ensure t
  :commands org-mode
  :init
  (setq org-directory "~/repos/my/org")
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'org-mode-map
   "e"    '(:ignore t :which-key "export")
   "em"   'org-pandoc-export-as-gfm
   "ep"   'org-pandoc-export-as-plain
   "eh"   'org-pandoc-export-as-html5
   "ti"   'org-display-inline-images)
  :config
  (setq org-log-done 'time))

(use-package ox-pandoc
  :ensure t
  :after org)

(provide 'my-org)
