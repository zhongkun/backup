;; -*- Emacs-Lisp -*-

;;Xcode configure
(add-to-list 'load-path "~/.emacs.d/plugin/xcode-doc-viewer/")

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
    "          keystroke \"R\" using {command down} \r"
    "    end tell \r"
    "end tell \r"
    ))))

(add-hook 'objc-mode-hook
         (lambda ()
           (define-key objc-mode-map (kbd "C-c C-r") 'xcode:buildandrun)
         ))


(ffap-bindings)
;; 设定搜索的路径 ffap-c-path
;; (setq ffap-c-path
;;     '("/usr/include" "/usr/local/include"))
;; 如果是新文件要确认
(setq ffap-newfile-prompt t)
;; ffap-kpathsea-expand-path 展开路径的深度
(setq ffap-kpathsea-depth 5)

(setq ff-other-file-alist
     '(("\\.mm?$" (".h"))
       ("\\.cc$"  (".hh" ".h"))
       ("\\.hh$"  (".cc" ".C"))

       ("\\.c$"   (".h"))
       ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

       ("\\.C$"   (".H"  ".hh" ".h"))
       ("\\.H$"   (".C"  ".CC"))

       ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
       ("\\.HH$"  (".CC"))

       ("\\.cxx$" (".hh" ".h"))
       ("\\.cpp$" (".hpp" ".hh" ".h"))

       ("\\.hpp$" (".cpp" ".c"))))
(add-hook 'objc-mode-hook
         (lambda ()
           (define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)
         ))


;;(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;     (normal-top-level-add-subdirs-to-load-path)))

;; 加载
;;(require 'auto-complete)
;;(require 'auto-complete-config)
;;(require 'ac-company)

;; (global-auto-complete-mode t)
;; ;; ac-company 中设置 company-xcode 有效
;; (ac-company-define-source ac-source-company-xcode company-xcode)
;; ;; 设定 objc-mode 中补全 ac-mode
;; (setq ac-modes (append ac-modes '(objc-mode)))
;; ;; hook
;; (add-hook 'objc-mode-hook
;;          (lambda ()
;;            (define-key objc-mode-map (kbd "\t") 'ac-complete)
;;            ;; 使用 XCode 的补全功能有效
;;            (push 'ac-source-company-xcode ac-sources)
;;            ;; C++ 关键词补全
;;            (push 'ac-source-c++-keywords ac-sources)
;;          ))
;; ;; 补全窗口中的热键
;; (define-key ac-completing-map (kbd "C-n") 'ac-next)
;; (define-key ac-completing-map (kbd "C-p") 'ac-previous)
;; (define-key ac-completing-map (kbd "M-/") 'ac-stop)
;; ;; 是否自动启动补全功能
;; (setq ac-auto-start nil)
;; ;; 启动热键
;; (ac-set-trigger-key "TAB")
;; ;; 候補的最大件数（缺省 10件）
;; (setq ac-candidate-max 20)
;; (define-key ac-mode-map (kbd "M-TAB") 'auto-complete) 
