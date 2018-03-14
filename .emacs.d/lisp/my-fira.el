
;;; Code:

(require 'dash)

(defun my-correct-symbol-bounds (pretty-alist)
  "Prepend a TAB character to each symbol in this alist,
this way compose-region called by prettify-symbols-mode
will use the correct width of the symbols
instead of the width measured by char-width."
    (mapcar (lambda (el)
              (setcdr el (string ?\t (cdr el)))
              el)
            pretty-alist))

(defun my-ligature-list (ligatures codepoint-start)
  "Create an alist of strings to replace with codepoints 
starting from codepoint-start."
  (let ((codepoints (-iterate '1+ codepoint-start (length ligatures))))
    (-remove (lambda (x) (equal x '("x" . #Xe16b)))
      (-zip-pair ligatures codepoints))))

(setq my-fira-ligatures
    (let* ((ligs '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
                  "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
                  "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
                  "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
                  ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
                  "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
                  "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
                  "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
                  ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
                  "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
                  "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
                  "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
                  "x" ":" "+" "+" "*")))
      (my-correct-symbol-bounds (my-ligature-list ligs #Xe100))))

;; nice glyphs for haskell with hasklig
(defun my-set-fira-ligatures ()
  "Add fira ligatures for use with prettify-symbols-mode."
  (setq prettify-symbols-alist
        (append my-fira-ligatures prettify-symbols-alist))
  (prettify-symbols-mode))


(use-package fira
  :load-path "lisp"
  :pin manual
  :defer t
  :init
  ;; without emacs daemon
  (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")
  ;; emacs daemon
  (add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")))
  :config
  (add-hook 'prog-mode-hook 'my-set-fira-ligatures))

(provide 'my-fira)

