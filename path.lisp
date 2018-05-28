;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Thomas de Grivel <thoxdg@gmail.com> +33614550127
;;

(in-package :remap)

(defun absolute-p (path)
  (declare (type string path))
  (unless (zerop (length path))
    (char= #\/ (char path 0))))

(defun absolute (&optional path)
  (let* ((cwd (cwd))
         (abs (or (when (null path)
                    cwd)
                  (when (absolute-p path)
                    path)
                  (let ((m (concatenate 'string cwd path)))
                    (when (absolute-p m)
                      m))
                  (error "~S" path))))
    abs))

(defun absolute! (&optional path)
  (let ((abs (absolute path)))
    (or (when (probe-file abs)
          abs)
        (error "No such file or directory: ~S" path))))

(defun absolute-or-wild! (&optional path)
  (let ((abs (absolute path)))
    (or (when (or (wild-pathname-p abs)
                  (probe-file abs))
          abs)
        (error "No such file or directory: ~S" abs))))

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
