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
  (:documentation "Returns a cl-stream STREAM opened by REMAP at PATH.
STREAM is an INPUT-STREAM if READ is non-NIL and an OUTPUT-STREAM if
WRITE is non-NIL and an IO-STREAM if both READ and WRITE are non-NIL.
Position is set at end of STREAM if APPEND is non-NIL. CREATE indicates
UNIX permissions to use for creating a new file. CREATE can also be NIL
in which case no file will be created."))

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
