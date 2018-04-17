;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Thomas de Grivel <thoxdg@gmail.com> +33614550127
;;

(in-package :remap)

(defun cat (&rest paths)
  (let ((remap *remap*)
        (out (stdout)))
    (dolist (path paths)
      (with-stream (in (babel-input-stream
                        (remap-open remap path :read t)))
        (stream-copy in out)))))

(defun cd (&optional directory)
  (let ((remap *remap*))
    (remap-cd remap (or directory
                        (remap-home remap nil)))))

(defun ls (&rest paths)
  (dolist (path (or paths '("")))
    (let* ((abs (absolute-or-wild! path))
           (count 0)
           (dir (dir abs)))
      (dolist (name dir)
        (unless (char= #\. (char name 0))
          (write-string name)
          (write-char #\Newline)
          (incf count)))
      count)))

(defun pwd ()
  (write-string (cwd))
  (write-char #\Newline)
  (values))

(defun rm (&rest paths)
  (let ((remap *remap*))
    (dolist (path paths)
      (remap-unlink remap path))))
