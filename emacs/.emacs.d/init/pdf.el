;; -*- Emacs-Lisp -*-

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
