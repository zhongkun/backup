;; -*- Emacs-Lisp -*-

;;AppleScript Configure
(autoload 'applescript-mode "applescript-mode" "major mode for
editing AppleScript source." )
(setq auto-mode-alist
      (cons '("\\.applescript$" . applescript-mode) auto-mode-alist))

