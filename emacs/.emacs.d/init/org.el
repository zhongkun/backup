(setq org-startup-indented t)

(defun org-toggle-iimage-in-org () 
(interactive) 
(if (face-underline-p 'org-link) 
(set-face-underline-p 'org-link nil)
(set-face-underline-p 'org-link t))
(iimage-mode))
