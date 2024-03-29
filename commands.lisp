;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Copyright 2018 Thomas de Grivel <thoxdg@gmail.com>
;;

(in-package :remap)

(defun cat (&rest paths)
  (let ((remap *remap*))
    (dolist (path (or paths '(())))
      (remap-cat remap path))))

(defun cd (&optional directory)
  (let ((remap *remap*))
    (remap-cd remap (or directory
                        (remap-home remap nil)))))

(defun cp (&rest paths)
  (let ((remap *remap*)
        (destination (first (last paths)))
        (sources (butlast paths)))
    (dolist (path sources)
      (remap-cp remap path destination))))

(defun cut (path start &optional end)
  (when (string= "-" path)
    (setf path nil))
  (setf start (parse-integer start))
  (when end
    (setf end (parse-integer end)))
  (remap-cut *remap* path start end))

(defvar *exit-shell*)

(defun exit ()
  (when (boundp '*exit-shell*)
    (setf *exit-shell* t)))

(defun ls (&rest paths)
  (let ((count 0))
    (dolist (path (or paths '("")))
      (let* ((abs (absolute-or-wild! path))
             (dir (dir :path abs)))
        (dolist (name dir)
          (unless (char= #\. (char name 0))
            (write-string name)
            (write #\Newline)
            (incf count)))))
    count))

(defun mv (&rest paths)
  (let ((remap *remap*)
        (destination (first (last paths)))
        (sources (butlast paths)))
    (dolist (path sources)
      (remap-mv remap path destination))))

(defun pwd ()
  (write-sequence (cwd))
  (write-char #\Newline)
  (values))

(defun rm (&rest paths)
  (let ((remap *remap*))
    (dolist (path paths)
      (remap-unlink remap path))))
