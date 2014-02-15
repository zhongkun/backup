(setq org-startup-indented t)

(defun org-toggle-iimage-in-org () 
(interactive) 
(if (face-underline-p 'org-link) 
(set-face-underline-p 'org-link nil)
(set-face-underline-p 'org-link t))
(iimage-mode))


(require 'org-publish)

(setq org-publish-project-alist
      '(("org-notes"
	 :base-directory "~/Documents/org/blog/org"
	 :base-extension "org"
	 :publishing-directory "~/Documents/org/blog/publish_html/"
	 :recursive t
	 :publishing-function org-publish-org-to-html
	 :headline-levels 4
	 :auto-preamble t
	 :auto-index nil
         :index-filename "index.org"
         :index-title "index"
         :link-home "index.html"
         :section-numbers nil
	 :style "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/stylesheet.css\" />"
	 )
	("org-static"
	 :base-directory "~/Documents/org/blog/org"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	 :publishing-directory "~/Documents/org/blog/publish_html/"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )
	("org" :components ("org-notes" "org-static")
	       :author "kun77416@gmail.com")
	))

(global-set-key (kbd "C-x C-p") 'org-publish)
