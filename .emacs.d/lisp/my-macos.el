(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta
        mac-command-modifier 'super)
  (menu-bar-mode t))

(provide 'my-macos)
