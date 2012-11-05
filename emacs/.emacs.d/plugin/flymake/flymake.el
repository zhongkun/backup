;;; flymake.el -- a universal on-the-fly syntax checker

;; Copyright (C) 2003 Free Software Foundation

;; Author:  Pavel Kobiakov <pk_at_work@yahoo.com>
;; Version: 0.2

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111, USA.

;;; Commentary:
;;
;; Flymake is a minor Emacs mode performing on-the-fly syntax
;; checks using the external syntax check tool (for C/C++ this
;; is usually the compiler)

(defcustom flymake-log-level -1
    "Logging level, only messages with level > flymake-log-level will not be logged
-1 = NONE, 0 = ERROR, 1 = WARNING, 2 = INFO, 3 = DEBUG"
	:group 'flymake
	:type 'integer
)

(defun flymake-log(level text &rest args)
    "Log a message with optional arguments"
	(if (<= level flymake-log-level)
		(let* ((msg (apply 'format text args)))
		    (message msg)
			;(with-temp-buffer
			;    (insert msg)
			;	(insert "\n")
			;   (flymake-save-buffer-in-file (current-buffer) "d:/flymake.log" t)  ; make log file name customizable
			;)
		)
    )
)

(defun flymake-ins-after(list pos val)
    "insert val into list after position pos"
	(let ((tmp (copy-sequence list))) ; (???) 
	    (setcdr (nthcdr pos tmp) (cons val (nthcdr (1+ pos) tmp)))
	    tmp
	)
)

(defun flymake-set-at(list pos val)
    "set val at position pos in list"
	(let ((tmp (copy-sequence list))) ; (???) 
	    (setcar (nthcdr pos tmp) val)
	    tmp
	)
)

(defvar flymake-pid-to-names(makehash)
    "pid -> source buffer name, output file name mapping"
)

(defun flymake-reg-names(pid source-buffer-name)
    "Save into in pid map"
    (unless (stringp source-buffer-name)
        (error "invalid buffer name")
    )
	(puthash pid (list source-buffer-name) flymake-pid-to-names)
)

(defun flymake-get-source-buffer-name(pid)
    "Return buffer name stored in pid map"
	(nth 0 (gethash pid flymake-pid-to-names))
)

(defun flymake-unreg-names(pid)
    "Delete pid->buffer name mapping"
	(remhash pid flymake-pid-to-names)
)

(defun flymake-get-buffer-var(buffer var-name)
    "switch to buffer if necessary and return local variable var"
	(unless (bufferp buffer)
	    (error "invalid buffer")
	)
			
	(if (eq buffer (current-buffer))
		(symbol-value var-name)
	;else
	    (save-excursion
		    (set-buffer buffer)
			(symbol-value var-name)
		)
	)
)

(defun flymake-set-buffer-var(buffer var-name var-value)
    "switch to buffer if necessary and set local variable var-name to var-value"
	(unless (bufferp buffer)
	    (error "invalid buffer")
	)
			
	(if (eq buffer (current-buffer))
		(set var-name var-value)
	;else
	    (save-excursion
		    (set-buffer buffer)
			(set var-name var-value)
		)
	)
)

(defvar flymake-buffer-data(makehash)
    "data specific to syntax check tool, in name-value pairs"
)
(make-variable-buffer-local 'flymake-buffer-data)
(defun flymake-get-buffer-data(buffer)
    (flymake-get-buffer-var buffer 'flymake-buffer-data)
)
(defun flymake-set-buffer-data(buffer data)
    (flymake-set-buffer-var buffer 'flymake-buffer-data data)
)
(defun flymake-get-buffer-value(buffer name)
    (gethash name (flymake-get-buffer-data buffer))
)
(defun flymake-set-buffer-value(buffer name value)
    (puthash name value (flymake-get-buffer-data buffer))
)

(defvar flymake-output-residual nil
  ""
)
(make-variable-buffer-local 'flymake-output-residual)
(defun flymake-get-buffer-output-residual(buffer)
    (flymake-get-buffer-var buffer 'flymake-output-residual)
)
(defun flymake-set-buffer-output-residual(buffer residual)
    (flymake-set-buffer-var buffer 'flymake-output-residual residual)
)

(defcustom flymake-allowed-file-name-masks '((".+\\.c$" flymake-simple-make-init flymake-simple-cleanup flymake-get-real-file-name)
											 (".+\\.cpp$" flymake-simple-make-init flymake-simple-cleanup flymake-get-real-file-name)
											 (".+\\.cs$" flymake-simple-make-init flymake-simple-cleanup flymake-get-real-file-name)
											 (".+\\.pl$" flymake-perl-init flymake-simple-cleanup flymake-get-real-file-name)
											 (".+\\.h$" flymake-master-make-header-init flymake-master-cleanup flymake-get-real-file-name)
											 (".+\\.java$" flymake-simple-make-java-init flymake-simple-java-cleanup flymake-get-real-file-name)
											 (".+[0-9]+\\.tex$" flymake-master-tex-init flymake-master-cleanup flymake-get-real-file-name)
											 (".+\\.tex$" flymake-simple-tex-init flymake-simple-cleanup flymake-get-real-file-name)
											 (".+\\.idl$" flymake-simple-make-init flymake-simple-cleanup flymake-get-real-file-name)
;											 (".+\\.cpp$" 1)
;											 (".+\\.java$" 3)
;											 (".+\\.h$" 2 (".+\\.cpp$" ".+\\.c$")
;											     ("[ \t]*#[ \t]*include[ \t]*\"\\([\w0-9/\\_\.]*[/\\]*\\)\\(%s\\)\"" 1 2))
;											 (".+\\.idl$" 1)
;											 (".+\\.odl$" 1)
;											 (".+[0-9]+\\.tex$" 2 (".+\\.tex$")
;											     ("[ \t]*\\input[ \t]*{\\(.*\\)\\(%s\\)}" 1 2 ))
;											 (".+\\.tex$" 1)
											 )
    "*Files syntax checking is allowed for"
	:group 'flymake
	:type '(repeat (string symbol symbol symbol))
)
 
(defun flymake-get-file-name-mode-and-masks(file-name)
    "return the corresponding entry from flymake-allowed-file-name-masks"
    (unless (stringp file-name)
        (error "invalid file-name")
    )
	(let ((count           (length flymake-allowed-file-name-masks))
		  (idx             0)
		  (mode-and-masks  nil))
	    (while (and (not mode-and-masks) (< idx count))
    	    (if (string-match (nth 0 (nth idx flymake-allowed-file-name-masks)) file-name)
				(setq mode-and-masks (cdr (nth idx flymake-allowed-file-name-masks)))
			)
	        (setq idx (1+ idx))
		)
		(flymake-log 3 "file %s, init=%s" file-name (car mode-and-masks))
		mode-and-masks
	)
)

(defun flymake-can-syntax-check-file(file-name)
    "Determine whether we can syntax check file-name: nil if cannot, non-nil if can"
	(if (flymake-get-init-function file-name)
		t
    ;else
        nil
    )
)

(defun flymake-get-init-function(file-name)
    "return init function to be used for the file"
	(let* ((init-f 	(nth 0 (flymake-get-file-name-mode-and-masks file-name))))
        ;(flymake-log 0 "calling %s" init-f)
        ;(funcall init-f (current-buffer))
    )
	(nth 0 (flymake-get-file-name-mode-and-masks file-name))
)

(defun flymake-get-cleanup-function(file-name)
    "return cleanup function to be used for the file"
	(nth 1 (flymake-get-file-name-mode-and-masks file-name))
)

(defun flymake-get-real-file-name-function(file-name)
    ""
	(or (nth 2 (flymake-get-file-name-mode-and-masks file-name)) 'flymake-get-real-file-name)
)

(defcustom flymake-buildfile-dirs '("." ".." "../.." "../../.." "../../../.." "../../../../.." "../../../../../.." "../../../../../../..")
    "dirs to look for buildfile"
	:group 'flymake
	:type '(repeat (string))
)

(defvar flymake-find-buildfile-cache (makehash 'equal))
(defun flymake-get-buildfile-from-cache(dir-name)
    (gethash dir-name flymake-find-buildfile-cache)
)
(defun flymake-add-buildfile-to-cache(dir-name buildfile)
    (puthash dir-name buildfile flymake-find-buildfile-cache)
)
(defun flymake-clear-buildfile-cache()
    (clrhash flymake-find-buildfile-cache)
)

(defun flymake-find-buildfile(buildfile-name source-dir-name dirs)
    "find buildfile (i.e. Makefile, build.xml, etc.) starting from current directory. Return its path or nil if not found"
	(if (flymake-get-buildfile-from-cache source-dir-name)
		(progn
 		    (flymake-get-buildfile-from-cache source-dir-name)
		)
	;else
		(let* ((buildfile-dir          nil)
			   (buildfile              nil)
			   (dir-count              (length dirs))
			   (dir-idx                0)
			   (found                  nil))

			(while (and (not found) (< dir-idx dir-count))

				(setq buildfile-dir (concat source-dir-name (nth dir-idx dirs)))
				(setq buildfile (concat buildfile-dir "/" buildfile-name))

				(when (file-exists-p buildfile)
					(setq found t)
				)

				(setq dir-idx (1+ dir-idx))
			)
			(if found
				(progn
					(flymake-log 3 "found buildfile at %s/%s" buildfile-dir buildfile-name)
					(flymake-add-buildfile-to-cache source-dir-name buildfile-dir)
					buildfile-dir
				)
			;else
				(progn
					(flymake-log 3 "buildfile for %s not found" source-dir-name)
					nil
				)
			)
		)
	)
)

(defun flymake-fix-path-name(name)
    "replace all occurences of '\' with '/'"
	(when name
		(let* ((new-name (expand-file-name (replace-regexp-in-string "[\\]" "/" name)))
			   (last-char (elt new-name (1- (length new-name)))))
			(setq new-name (replace-regexp-in-string "\\./" "" new-name))
			(if (equal "/" (char-to-string last-char))
				(setq new-name (substring new-name 0 (1- (length new-name))))
			)
			new-name
		)
	)
)

(defun flymake-same-files(file-name-one file-name-two)
    "t if file-name-one and file-name-two actually point to the same file"
	(equal (flymake-fix-path-name file-name-one) (flymake-fix-path-name file-name-two))
)

(defun flymake-ensure-ends-with-slash(path)
    (if (not (= (elt path (1- (length path))) (string-to-char "/")))
		(concat path "/")
	;else
	    path
	)
)

(defun flymake-get-common-path-prefix(string-one string-two)
    "return common prefix for two paths"
	(when (and string-one string-two)
		(let* ((slash-pos-one  -1)
			   (slash-pos-two  -1)
			   (done           nil)
			   (prefix         nil))

		    (setq string-one (flymake-ensure-ends-with-slash string-one))
		    (setq string-two (flymake-ensure-ends-with-slash string-two))
			
		    (while (not done)
			    (setq slash-pos-one (string-match "/" string-one (1+ slash-pos-one)))
				(setq slash-pos-two (string-match "/" string-two (1+ slash-pos-two)))

			    (if (and slash-pos-one slash-pos-two
					     (= slash-pos-one slash-pos-two)
						 (string= (substring string-one 0 slash-pos-one) (substring string-two 0 slash-pos-two)))
					(progn
						(setq prefix (substring string-one 0 (1+ slash-pos-one)))
					)
				;else
				    (setq done t)
				)
			)
			prefix
		)
    )
)

(defun flymake-build-relative-path(from-dir to-dir)
    "return rel: from-dir/rel == to-dir"
    (if (not (equal (elt from-dir 0) (elt to-dir 0)))
	    (error "first chars in paths %s, %s must be equal (same drive)" from-dir to-dir)
	;else
		(let* ((from        (flymake-ensure-ends-with-slash (flymake-fix-path-name from-dir)))
			   (to          (flymake-ensure-ends-with-slash (flymake-fix-path-name to-dir)))
			   (prefix      (flymake-get-common-path-prefix from to))
			   (from-suffix (substring from (length prefix)))
			   (up-count    (length (split-string from-suffix "[/]")))
			   (to-suffix   (substring to   (length prefix)))
			   (idx         0)
			   (rel         nil))

		    (if (and (> (length to-suffix) 0) (equal "/" (char-to-string (elt to-suffix 0))))
			    (setq to-suffix (substring to-suffix 1))
			)

		    (while (< idx up-count)
			    (if (> (length rel) 0)
					(setq rel (concat rel "/"))
				)
			    (setq rel (concat rel ".."))
				(setq idx (1+ idx))
			)
			(if (> (length rel) 0)
				(setq rel (concat rel "/"))
			)
			(if (> (length to-suffix) 0)
			   (setq rel (concat rel to-suffix))
			)

		    (or rel "./")
		)
	)
)

(defcustom flymake-master-file-dirs '("." "./src" "./UnitTest")
    "dirs where to llok for master files"
	:group 'flymake
	:type '(repeat (string))
)

(defcustom flymake-master-file-count-limit 32
    "max number of master files to check"
	:group 'flymake
	:type 'integer
)

(defun flymake-find-possible-master-files(file-name master-file-dirs masks)
    "find (by name and location) all posible master files, which are .cpp and .c for and .h.
Files are searched for starting from the .h directory and max max-level parent dirs.
File contents are not checked."
    (let* ((dir-idx    0)
		  (dir-count  (length master-file-dirs))
		  (files  nil)
		  (done   nil)
		  (masks-count (length masks)))

	    (while (and (not done) (< dir-idx dir-count))
			(let* ((dir (concat (flymake-fix-path-name (file-name-directory file-name)) "/"	(nth dir-idx master-file-dirs)))
				   (masks-idx 0))
			    (while (and (file-exists-p dir) (not done) (< masks-idx masks-count))
			        (let* ((mask        (nth masks-idx masks))
						   (dir-files   (directory-files dir t mask))
						   (file-count  (length dir-files))
						   (file-idx    0))

			            (flymake-log 3 "dir %s, %d file(s) for mask %s" dir file-count mask)
				        (while (and (not done) (< file-idx file-count))
				            (when (not (file-directory-p (nth file-idx dir-files)))
					            (setq files (cons (nth file-idx dir-files) files))
						        (when (>= (length files) flymake-master-file-count-limit)
						            (flymake-log 3 "master file count limit (%d) reached" flymake-master-file-count-limit)
						            (setq done t)
						        )
				            )
				            (setq file-idx (1+ file-idx))
						)
			        )
					(setq masks-idx (1+ masks-idx))