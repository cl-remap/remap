;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Copyright 2018 Thomas de Grivel <thoxdg@gmail.com>
;;

(in-package :remap)

(defclass remap ()
  ())

(defgeneric remap-cat (remap path)
  (:documentation "Prints file at PATH for REMAP."))

(defgeneric remap-cd (remap directory)
  (:documentation "Changes current working directory of REMAP to
 DIRECTORY."))

(defgeneric remap-cp (remap source destination)
  (:documentation "Copies SOURCE into DESTINATION for REMAP."))

(defgeneric remap-cwd (remap)
  (:documentation "Return a string describing the current working dir
 of REMAP."))

(defgeneric remap-cut (remap path start end)
  (:documentation "Cut file at PATH from START to END for REMAP.
START and END can be NIL to denote respectively start and end of file."))

(defgeneric remap-dir (remap path sort order)
  (:documentation "Return a directory listing of REMAP at PATH, sorted
 according to SORT and ORDER."))

(defgeneric remap-home (remap user)
  (:documentation "Return USER home directory for REMAP or current user
 home dir if USER is NIL."))

(defgeneric remap-mv (remap source destination)
  (:documentation "Moves SOURCE into DESTINATION for REMAP."))

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

(defmethod remap-cat ((remap remap) (path null))
  (stream-copy *stdin* *stdout*))

(defmethod remap-cat ((remap remap) (path string))
  (with-stream (in (remap-open remap path :create nil :read t))
    (stream-copy in *stdout*)))

(defmethod remap-cp ((remap remap) (source string) (destination string))
  (let ((dest (if (path-directory-p destination)
                  (str destination (path-filename source))
                  destination)))
    (with-stream (out (remap-open remap dest :write t))
      (with-stream (in (remap-open remap source :read t))
        (stream-copy in out)))))

(defmethod remap-cut ((remap remap) (path string)
                      (start null) (end null))
  (remap-cat remap path))

(defmethod remap-cut ((remap remap) (path string)
                      (start null) end)
  (remap-cut remap path 0 end))

(defmethod remap-cut ((remap remap) (path null)
                      (start integer) (end null))
  (let ((in *stdin*))
      (stream-discard-n in start)
      (stream-copy in *stdout*)))

(defmethod remap-cut ((remap remap) (path null)
                      (start integer) (end integer))
  (let ((in *stdin*))
    (when (< start end)
      (stream-discard-n in start)
      (stream-copy-n in *stdout* (- end start)))))

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

(defmethod remap-mv ((remap remap) (source string) (destination string))
  (remap-cp remap source destination)
  (remap-unlink remap source))

(defvar *remap*)

(declaim (type remap *remap*))
