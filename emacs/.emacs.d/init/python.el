;; -*- Emacs-Lisp -*-

;;===== PyFlakes
;; code checking via pyflakes+flymake
;; (when (load "flymake" ) 
;;   (defun flymake-pyflakes-init () 
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy 
;;                        'flymake-create-temp-inplace)) 
;;            (local-file (file-relative-name 
;;                         temp-file 
;;                         (file-name-directory buffer-file-name)))) 
;;       (list "/usr/local/bin/pyflakes" (list local-file)))) 
;;   (add-to-list 'flymake-allowed-file-name-masks 
;;                '("\\.py\\'" flymake-pyflakes-init))) 

;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;; ;;(load-library "flymake-cursor")  ;在minibuffer显示错误信息
;; (global-set-key (kbd "<f11>") 'flymake-start-syntax-check)
;; (global-set-key (kbd "<s-up>") 'flymake-goto-prev-error)
;; (global-set-key (kbd "<s-down>") 'flymake-goto-next-error)

;; (setq flymake-gui-warnings-enabled nil)
;; (setq flymake-log-level 0)

;; (custom-set-faces
;;      '(flymake-errline ((((class color)) (:underline "red"))))
;;      '(flymake-warnline ((((class color)) (:underline "yellow1")))))
;;  (setq flymake-no-changes-timeout 600)

;; (defun flymake-display-current-error ()
;;   "Display errors/warnings under cursor."
;;   (interactive)
;;   (let ((ovs (overlays-in (point) (1+ (point)))))
;;     (catch 'found
;;       (dolist (ov ovs)
;;         (when (flymake-overlay-p ov)
;;           (message (overlay-get ov 'help-echo))
;;           (throw 'found t))))))
;; (defun flymake-goto-next-error-disp ()
;;   "Go to next error in err ring, then display error/warning."
;;                    (interactive)
;;   (flymake-goto-next-error)
;;   (flymake-display-current-error))
;; (defun flymake-goto-prev-error-disp ()
;;   "Go to previous error in err ring, then display error/warning."
;;   (interactive)
;;   (flymake-goto-prev-error)
;;   (flymake-display-current-error))

;; (defvar flymake-mode-map (make-sparse-keymap))
;; (define-key flymake-mode-map (kbd "C-c C-n") 'flymake-goto-next-error-disp)
;; (define-key flymake-mode-map (kbd "C-c C-p") 'flymake-goto-prev-error-disp)
;; (define-key flymake-mode-map (kbd "C-c C-j")
;;   'flymake-display-err-menu-for-current-line)
;; (or (assoc 'flymake-mode minor-mode-map-alist)
;;     (setq minor-mode-map-alist
;;           (cons (cons 'flymake-mode flymake-mode-map)
;;                 minor-mode-map-alist)))


;; ;; (add-to-list 'load-path"~/.emacs.d/plugin/Pymacs/")
;; ;; ;;(add-to-list 'load-path"~/.emacs.d/plugin/")
;; ;; (autoload 'pymacs-apply "pymacs")
;; ;; (autoload 'pymacs-call "pymacs")
;; ;; (autoload 'pymacs-eval "pymacs" nil t)
;; ;; (autoload 'pymacs-exec "pymacs" nil t)
;; ;; (autoload 'pymacs-load "pymacs" nil t)

;; ;; (pymacs-load "ropemacs" "rope-")
;; ;; (setq ropemacs-enable-autoimport t)

;; ;;;Also note that ropemacs may redefine some standard Emacs and your custom key
;; ;;bindings.  To prevent this, put the following example lines to your
;; ;;``~/.emacs`` *before* the lines presented above:

;; ;; (setq ropemacs-enable-shortcuts nil)
;; ;; (setq ropemacs-local-prefix "C-c C-p")

;; ;; (add-to-list 'load-path"~/.emacs.d/plugin/pycomplete//")
;; ;; (require 'pycomplete)
;; ;; (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
;; ;; (autoload 'python-mode "python-mode" "Python editing mode." t)
;; ;; (setq interpreter-mode-alist(cons '("python" . python-mode)
;; ;;                            interpreter-mode-alist))

;; ;;;escope
;; (add-to-list 'load-path"~/.emacs.d/plugin/cscope/")
;; (require 'xcscope)
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(display-time-mode t)
;;  '(session-use-package t nil (session)))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  )
;;(load-file "~/.emacs.d/plugin/emacs-epc/epc.el")
;;(require 'epc)

