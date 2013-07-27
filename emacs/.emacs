;; -*- Emacs-Lisp -*-

;; Private Emacs Configuration file 
;; Mail:kun77416@gmail.com


;; Import custom configuration

(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'elisp-load-dir)
(elisp-load-dir "~/.emacs.d/init")
;;(elisp-load-dir "~/.emacs.d/plugin/")
;; then comes all the custom-set-faces stuff that emacs puts there


;; Enable Plugin

;;plugin: ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;;plugin: git-emacs
(add-to-list 'load-path "~/.emacs.d/plugin/git-emacs/")
(require 'git-emacs)



(setenv "PATH" (concat "/usr/texbin:/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/texbin" "/usr/local/bin") exec-path))
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;;Doc-view

(defun wl-doc-view-bookmark-make-record ()
  (nconc (bookmark-make-record-default)
         `((page . ,(doc-view-current-page))
           (resolution . ,doc-view-resolution)
           (handler . wl-doc-view-bookmark-jump))))

(defun wl-bookmark-get-resolution (bookmark)
  "Get doc view resolution."
  (or (bookmark-prop-get bookmark 'resolution)
      (default-value 'doc-view-resolution)))

(defun wl-doc-view-bookmark-jump (bookmark)
  (prog1 (doc-view-bookmark-jump bookmark)
    (let ((resolution (wl-bookmark-get-resolution bookmark)))
      (assert (> resolution 0))
      (when (/= doc-view-resolution resolution)
        (set (make-local-variable 'doc-view-resolution) resolution)
        (doc-view-reconvert-doc)))))

        



;; Installation:
;; In .emacs add:
;; (require 'doubanfm)

;; (dolist (path-list (list "./lib/"
;;                          "./lib/http-emacs"
;;                          "./lib/emms-3.0"))
;;   (add-to-list 'load-path
;;                (expand-file-name path-list (file-name-directory load-file-name))))

;; (require 'emms-setup)
;; (require 'http-get)
;; (require 'json)
;; (emms-standard)
;; (emms-default-players)
;; (defvar playlist_url
;;   "http://api.douban.com/v2/fm/playlist?type=n&channel=%s&app_name=pldoubanfms&version=2&sid=0&apikey=Key0c57daf39b62cfbf250790dad2286f3d")
;; (defvar default-channel 27)
;; (defvar length 0)

;; (defun event (process message)
;;   (parse-data))

;; (defun parse-data ()
;;   (set 'length 0)
;;   (set 'currbuf (buffer-name (current-buffer)))
;;   (switch-to-buffer "songs")
;;   (set 'data (buffer-string))
;;   (switch-to-buffer currbuf)
;;   (set 'data (json-read-from-string data))
;;   (set 'songs (cdr (car data)))
;;   (if (vectorp songs)
;;       (mapcar (lambda (x)
;;                 (dolist (slst x)
;;                   (if (string-equal (car slst) "url")
;;                       (emms-add-url (cdr slst)))
;;                   (if (string-equal (car slst) "length")
;;                       (set 'length (+ length (cdr slst))))
;;                   )) songs))
;;   (unless (equal length 0)
;;     (emms-start)))

;; (defun get-play-list (&optional channel)
;;   (http-get
;;    (format playlist_url channel) nil 'event nil "songs"))

;; (defun play-fm (&optional channel time)
;;   (if time (sit-for time))
;;   (unless channel (set 'channel default-channel))
;;   (get-play-list channel)
;;     (unless (equal length 0)
;;       (sit-for length)
;;       (play-fm))
;;     (interactive))

;; (defun pause-fm(&optional time) 
;;   (if time (sit-for time))
;;      (emms-stop)
;;      (interactive))

;; (defun continue-fm(&optional time)
;;   (if time (sit-for time))
;;    (emms-start)
;;    (interactive))


;; (defun play-channel (channel)
;;   (play-fm channel)
;;   (interactive))

;; (provide 'doubanfm)



(add-to-list 'load-path "~/.emacs.d/el-get/el-get/")
(add-to-list 'load-path "~/.emacs.d/el-get/emacs-w3m/")
 (unless (require 'el-get nil 'noerror)
   (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
     (eval-print-last-sexp)))

 (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;;(el-get 'sync)

;;(add-to-list 'exec-path "~/.emacs.d/el-get/emacs-w3m/")

;;w3m
;; (require 'w3m)
;; (setq w3m-use-favicon nil)
;; (setq w3m-command-arguments '("-cookie" "-F"))
;; (setq w3m-use-cookies t)
;; (setq w3m-home-page "http://www.google.com")


(load-file "~/.emacs.d/plugin/emacs-for-python/epy-init.el")
