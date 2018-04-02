(use-package shell-script-mode
  :commands shell-script-mode
  :init
  (general-define-key
   :states 'normal
   :prefix ","
   :keymaps 'sh-mode-map
   "r"    '(:ignore t :which-key "run")
   "rs"   'shell-command
   "rr"   'shell-command-on-buffer
   "rg"   'shell-command-on-region))

(defun shell-command-on-buffer ()
  "Asks for a command and executes it in inferior shell with current buffer
as input."
  (interactive)
  (shell-command-on-region
   (point-min) (point-max)
   (read-shell-command "Shell command on buffer: ")))

(provide 'my-shell)
