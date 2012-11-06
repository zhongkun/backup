;; -*- Emacs-Lisp -*-
 

;; Time-stamp: <2010-04-09 10:22:51 Friday by ahei>

;;(setq load-path (cons "" load-path))


;; So the idea is that you copy/paste this code into your *scratch* buffer,
;; hit C-j, and you have a working el-get.

;; el-get


;;;; 显示时间    
(setq display-time-24hr-format t)    
(setq display-time-day-and-date t)    (display-time)    
;;;; 关闭启动画面    
(setq inhibit-startup-message t)    
;;;;设置大的kill ring    
(setq kill-ring-max 150)    
;;(tool-bar-mode nil);去掉那个大大的工具栏    
;;(scroll-bar-mode nil);去掉滚动条，因为可以使用鼠标滚轮了 ^_^   
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴    
(font-lock-mode t) ; 开启语法高亮    
'(tab-width 4) ;;'(tab-width 4)  

(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;;plugin install  
 ;;color theme     
(add-to-list 'load-path "/Users/kun/.emacs.d/plugin/color-theme-6.6.0/")    
(require 'color-theme)    
(color-theme-initialize)    
(color-theme-robin-hood)
;;(color-theme-billw)
;;(color-theme-charcoal-black) 


(add-to-list 'load-path "~/.emacs.d/plugin/auto-complete-1.3.1/")
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))
(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue") ;;; 设置比上面截图中更好看的背景颜色
(define-key ac-completing-map "\M-n" 'ac-next)  ;;; 列表中通过按M-n来向下移动
(define-key ac-completing-map "\M-p" 'ac-previous)
(setq ac-auto-start 2)
(setq ac-dwim t)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

;;yasnippet
(add-to-list 'load-path "~/.emacs.d/plugin/yasnippet-0.6.1c/")
(require 'yasnippet)
(yas/initialize) 
(yas/load-directory "~/.emacs.d/plugin/yasnippet-0.6.1c/snippets")


(define-key global-map "\C-c\C-g" 'goto-line) 

(desktop-save-mode 1)

;;session

(add-to-list 'load-path "~/.emacs.d/plugin/session/")
(require 'session)
(add-hook 'after-init-hook
          'session-initialize)
(add-to-list 'session-globals-exclude
             'org-mark-ring)

(add-to-list 'load-path"~/.emacs.d/plugin/Pymacs/")
;;(add-to-list 'load-path"~/.emacs.d/plugin/")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;;;Also note that ropemacs may redefine some standard Emacs and your custom key
;;bindings.  To prevent this, put the following example lines to your
;;``~/.emacs`` *before* the lines presented above:

(setq ropemacs-enable-shortcuts nil)
(setq ropemacs-local-prefix "C-c C-p")

(add-to-list 'load-path"~/.emacs.d/plugin/pycomplete//")
(require 'pycomplete)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq interpreter-mode-alist(cons '("python" . python-mode)
                           interpreter-mode-alist))

;;;escope
(add-to-list 'load-path"~/.emacs.d/plugin/cscope/")
(require 'xcscope)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(display-time-mode t)
 '(session-use-package t nil (session)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )




;;字体大小的配置过程 
;;#xlsfonts ;display system fonts 
;;# 
(defun sacha/increase-font-size () 
(interactive) 
(set-face-attribute 'default 
nil 
:height 
(ceiling (* 1.10 
(face-attribute 'default :height))))) 
(defun sacha/decrease-font-size () 
(interactive) 
(set-face-attribute 'default 
nil 
:height 
(floor (* 0.9 
(face-attribute 'default :height))))) 
(global-set-key (kbd "C-+") 'sacha/increase-font-size) 
(global-set-key (kbd "C--") 'sacha/decrease-font-size) 

;;(set-default-font "Courier New-12n") 
(set-default-font "Menlo Regular-11")


;;AppleScript Configure
(add-to-list 'load-path "~/.emacs.d/lisp/")
(autoload 'applescript-mode "applescript-mode" "major mode for
editing AppleScript source." )
(setq auto-mode-alist
      (cons '("\\.applescript$" . applescript-mode) auto-mode-alist))


;;Xcode configure

(add-to-list 'auto-mode-alist '("\\.mm?$" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . objc-mode))

(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))



(defun xcode:buildandrun ()
 (interactive)
 (do-applescript
  (format
   (concat
    "tell application \"Xcode\" to activate \r"
    "tell application \"System Events\" \r"
    "     tell process \"Xcode\" \r"
    "          keystroke \"r\" using {command down} \r"
    "    end tell \r"
    "end tell \r"
    ))))

(add-hook 'objc-mode-hook
         (lambda ()
           (define-key objc-mode-map (kbd "C-c C-r") 'xcode:buildandrun)
         ))


;;===== PyFlakes
;; code checking via pyflakes+flymake
(when (load "flymake" ) 
  (defun flymake-pyflakes-init () 
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                       'flymake-create-temp-inplace)) 
           (local-file (file-relative-name 
                        temp-file 
                        (file-name-directory buffer-file-name)))) 
      (list "/usr/local/bin/pyflakes" (list local-file)))) 
  (add-to-list 'flymake-allowed-file-name-masks 
               '("\\.py\\'" flymake-pyflakes-init))) 

(add-hook 'find-file-hook 'flymake-find-file-hook)
;;(load-library "flymake-cursor")  ;在minibuffer显示错误信息
(global-set-key (kbd "<f11>") 'flymake-start-syntax-check)
(global-set-key (kbd "<s-up>") 'flymake-goto-prev-error)
(global-set-key (kbd "<s-down>") 'flymake-goto-next-error)

(setq flymake-gui-warnings-enabled nil)
(setq flymake-log-level 0)

(custom-set-faces
     '(flymake-errline ((((class color)) (:underline "red"))))
     '(flymake-warnline ((((class color)) (:underline "yellow1")))))
 (setq flymake-no-changes-timeout 600)

(defun flymake-display-current-error ()
  "Display errors/warnings under cursor."
  (interactive)
  (let ((ovs (overlays-in (point) (1+ (point)))))
    (catch 'found
      (dolist (ov ovs)
        (when (flymake-overlay-p ov)
          (message (overlay-get ov 'help-echo))
          (throw 'found t))))))
(defun flymake-goto-next-error-disp ()
  "Go to next error in err ring, then display error/warning."
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-current-error))
(defun flymake-goto-prev-error-disp ()
  "Go to previous error in err ring, then display error/warning."
  (interactive)
  (flymake-goto-prev-error)
  (flymake-display-current-error))

(defvar flymake-mode-map (make-sparse-keymap))
(define-key flymake-mode-map (kbd "C-c C-n") 'flymake-goto-next-error-disp)
(define-key flymake-mode-map (kbd "C-c C-p") 'flymake-goto-prev-error-disp)
(define-key flymake-mode-map (kbd "C-c C-j")
  'flymake-display-err-menu-for-current-line)
(or (assoc 'flymake-mode minor-mode-map-alist)
    (setq minor-mode-map-alist
          (cons (cons 'flymake-mode flymake-mode-map)
                minor-mode-map-alist)))

