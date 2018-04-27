;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Thomas de Grivel <thoxdg@gmail.com> +33614550127
;;

(in-package :remap)

(defclass remap ()
  ())

(defgeneric remap-cat (remap &rest paths)
  (:documentation "Prints concatenated files at PATHS for REMAP."))

(defgeneric remap-cd (remap directory)
  (:documentation "Changes current working directory of REMAP to
 DIRECTORY."))

(defgeneric remap-cp (remap source destination)
  (:documentation "Copies SOURCE into DESTINATION for REMAP."))

(defgeneric remap-cwd (remap)
  (:documentation "Return a string describing the current working dir
 of REMAP."))

(defgeneric remap-dir (remap path sort order)
  (:documentation "Return a directory listing of REMAP at PATH, sorted
 according to SORT and ORDER."))

(defgeneric remap-home (remap user)
  (:documentation "Return USER home directory for REMAP or current user
 home dir if USER is NIL."))

(defgeneric remap-open (remap path &key read write append create)
  (:documentation "Returns a cl-stream STREAM of (unsigned-byte 8)
element type, opened by REMAP at PATH.
STREAM is an INPUT-STREAM if READ is non-NIL or an OUTPUT-STREAM if
WRITE is non-NIL or an IO-STREAM if both READ and WRITE are non-NIL.
Position is set at end of STREAM if APPEND is non-NIL. CREATE indicates
UNIX permissions to use for creating a new file. CREATE can also be NIL
in which case no file will be created."))

(defgeneric remap-unlink (remap path)
  (:documentation "Removes a link to a file at PATH for REMAP."))

(defun path-directory-p (path)
  (declare (type string path))
  (char= #\/ (char path (1- (length path)))))

#+test (path-directory-p "/")
#+test (path-directory-p "/hop")
#+test (path-directory-p "hop/")

(defun path-filename (path)
  (declare (type string path))
  (first (split-sequence #\/ path :from-end t :count 1)))

#+test (path-filename "/hop/plop/file.txt")
#+test (path-filename "file.txt")
#+test (path-filename "/hop/plop/")

(defmethod remap-cp ((remap remap) (source string) (destination string))
  (let ((dest (if (path-directory-p destination)
                  (str destination (path-filename source))
                  destination)))
    (with-stream (out (remap-open remap dest :write t))
      (with-stream (in (remap-open remap source :read t))
        (stream-copy in out)))))

(defmethod remap-dir ((remap remap) (path null) (sort symbol)
                      (order symbol))
  (remap-dir remap (remap-cwd remap) sort order))

(defmethod remap-dir ((remap remap) (path string)
                      (sort (eql :name))
                      (order (eql :<)))
  (sort (remap-dir remap path nil nil) #'string<))

(defmethod remap-dir ((remap remap) (path string)
                      (sort (eql 'name))
                      (order (eql '>)))
  (sort (remap-dir remap path nil nil) #'string>))

(defvar *remap*)

(declaim (type remap *remap*))
