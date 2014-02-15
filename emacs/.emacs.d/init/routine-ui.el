;; -*- Emacs-Lisp -*-

;;Display Configuration

(setq display-time-24hr-format t)    
(setq display-time-day-and-date t)
(display-time)    

(setq inhibit-startup-message t)    
(setq kill-ring-max 150)    
(tool-bar-mode 0)
(scroll-bar-mode 0);;Abnormal in XWindow
(setq x-select-enable-clipboard t);
(font-lock-mode t)
'(tab-width 4) 


(add-to-list 'custom-theme-load-path "~/.emacs.d/theme/molokai-theme/")
(setq molokai-theme-kit t)
(load-theme 'molokai t)

;;color theme     
;; (add-to-list 'load-path "~/.emacs.d/plugin/color-theme-6.6.0/")    
;; (require 'color-theme)    
;; (color-theme-initialize)  
;; (color-theme-solarized-dark)  
;;(color-theme-robin-hood)
;;(color-theme-billw)
;;(color-theme-charcoal-black) 

(desktop-save-mode 1)

;;Coding encode
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;;Alhpa 
;;(set-frame-parameter (selected-frame) 'alpha (list 85 50))
(defun transform-window (a ab)
  (set-frame-parameter (selected-frame) 'alpha (list a ab))
  (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
)

(global-set-key [(f7)] (lambda()
                         (interactive)
                         (transform-window 95 80)))

(global-set-key [(f8)] (lambda()
                         (interactive)
                         (transform-window 100 100)))


;; display system fonts 
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


;;Rezie lanunch emacs window size
(setq default-frame-alist 
'((height . 60) (width . 220) (menu-bar-lines . 20) (tool-bar-lines . 0))) 
;;(set-default-font "Courier New-12n") 

;;(set-default-font "Menlo Regular-11")

;; Setting English Font
;;(set-face-attribute 'default nil :font "Consolas 11")
(set-face-attribute 'default nil :font "Menlo Regular-11")

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset (font-spec :family "Heiti SC"
                                       :size 11)))


;;session

(add-to-list 'load-path "~/.emacs.d/plugin/session")
(require 'session)
(add-hook 'after-init-hook
          'session-initialize)
(add-to-list 'session-globals-exclude
             'org-mark-ring)


;;(define-key global-map "\C-c\C-g" 'goto-line) 
(define-key global-map [f5] 'goto-line) 

(defun my-yes-or-mumble-p (prompt)
    "PROMPT user with a yes-or-no question, but only test for yes."
    (if (string= "yes"
                 (downcase
                  (read-from-minibuffer
                   (concat prompt "(yes or no) "))))
        t
      nil))
  
(defalias 'yes-or-no-p 'my-yes-or-mumble-p)


;;Number window
(add-to-list 'load-path "~/.emacs.d/plugin/window-numbering/")
(require 'window-numbering)
(window-numbering-mode 1)


;;Winner Mode
(winner-mode 1)
; copied from http://puntoblogspot.blogspot.com/2011/05/undo-layouts-in-emacs.html
(global-set-key (kbd "C-x 4 u") 'winner-undo)
(global-set-key (kbd "C-x 4 r") 'winner-redo)

;auto install
(add-to-list 'load-path "~/.emacs.d/plugin/auto-install/")
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/plugin/")
