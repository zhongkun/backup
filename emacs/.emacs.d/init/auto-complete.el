;; -*- Emacs-Lisp -*-

(add-to-list 'load-path "~/.emacs.d/plugin/auto-complete-1.3.1/")
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))
(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue") 
(define-key ac-completing-map "\M-n" 'ac-next) 
(define-key ac-completing-map "\M-p" 'ac-previous)
(setq ac-auto-start 2)
(setq ac-dwim t)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

;;yasnippet
(add-to-list 'load-path "~/.emacs.d/plugin/yasnippet-0.6.1c/")
(require 'yasnippet)
(yas/initialize) 
(yas/load-directory "~/.emacs.d/plugin/yasnippet-0.6.1c/snippets")

       (add-to-list 'load-path "~/.emacs.d/plugin/auto-java-complete/")
       (require 'ajc-java-complete-config)
       (add-hook 'java-mode-hook 'ajc-java-complete-mode)
       (add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)
;;       read ajc-java-complete-config.el  for more info .


