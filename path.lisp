;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Thomas de Grivel <thoxdg@gmail.com> +33614550127
;;

(in-package :remap)

(defun absolute-p (path)
  (check-uri path))
  (unless (zerop (length (symbol-name path)))
    (char= #\/ (char (symbol-name path) 0))))

(defun absolute (&optional path)
  (let ((cwd (cwd)))
    (or (when (null path)
          cwd)
        (when (absolute-p path)
          path)
        (uri (str cwd path)))))

(defun absolute! (&optional path)
  (let ((abs (absolute path)))
    (or (when (probe-file (symbol-name abs))
          abs)
        (error "No such file or directory: ~A" path))))

(defun absolute-or-wild! (&optional path)
  (let ((abs (absolute path)))
    (or (when (or (wild-pathname-p (symbol-name abs))
                  (probe-file (symbol-name abs)))
          abs)
        (error "No such file or directory: ~A" path))))

(defun path-directory-p (path)
  (check-uri path)
  (let ((name (symbol-name path)))
    (char= #\/ (char name (1- (length name))))))

#+test (path-directory-p (uri "/"))
#+test (path-directory-p (uri "/hop"))
#+test (path-directory-p (uri "hop/"))

(defun path-filename (path)
  (check-uri path)
  (uri (first (split-sequence #\/ (symbol-name path)
                              :from-end t :count 1))))

#+test (path-filename (uri "/hop/plop/file.txt"))
#+test (path-filename (uri "file.txt"))
#+test (path-filename (uri "/hop/plop/"))
