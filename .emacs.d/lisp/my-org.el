(use-package org
  :ensure t
  :commands org-mode
  :init
  (setq org-directory "~/repos/my/org")
  (setq org-agenda-files (append (file-expand-wildcards "~/repos/my/org/*.org")))
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'org-mode-map
   "e"    '(:ignore t :which-key "export")
   "em"   'org-pandoc-export-as-gfm
   "ep"   'org-pandoc-export-as-plain
   "eh"   'org-pandoc-export-as-html5
   "ti"   'org-toggle-inline-images
   "tl"   'org-toggle-link-display
   "ta"   'outline-show-all)
  :config
  (set-face-attribute 'org-block nil :background (color-darken-name (face-attribute 'default :background) 3))
  (setq org-agenda-window-setup "only-window")
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-confirm-babel-evaluate nil)
  (setq org-edit-src-content-indentation 0)
  (setq org-agenda-span 14)
  (setq org-log-done 'time)
  (setq org-agenda-todo-ignore-with-date 1)
  (setq org-image-actual-width nil))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package ox-pandoc
  :ensure t
  :after org)

(provide 'my-org)
