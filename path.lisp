;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Copyright 2018 Thomas de Grivel <thoxdg@gmail.com>
;;

(in-package :remap)

(defun absolute-p (path)
  (declare (type string path))
  (unless (zerop (length path))
    (char= #\/ (char path 0))))

(defun absolute (&optional path)
  (let ((cwd (cwd)))
    (or (when (null path)
          cwd)
        (when (absolute-p path)
          path)
        (str cwd path))))

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

(defun path-as-directory (path)
  (if (path-directory-p path)
      path
      (str path "/")))

(defun path-filename (path)
  (declare (type string path))
  (first (split-sequence #\/ path :from-end t :count 1)))

#+test (path-filename "/hop/plop/file.txt")
#+test (path-filename "file.txt")
#+test (path-filename "/hop/plop/")
