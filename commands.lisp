;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Thomas de Grivel <thoxdg@gmail.com> +33614550127
;;

(in-package :remap)

(defun cat (&rest paths)
  (let ((remap *remap*)
        (out *stdout*))
    (dolist (path paths)
      (with-stream (in (babel-input-stream
                        (remap-open remap path :read t)))
        (stream-copy in out)))))

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

(defun ls (&rest paths)
  (let ((count 0))
    (dolist (path (or paths '("")))
      (let* ((abs (absolute-or-wild! path))
             (dir (dir :path abs)))
        (dolist (name dir)
          (unless (char= #\. (char name 0))
            (write-sequence name)
            (write #\Newline)
            (incf count)))))
    count))

(defun pwd ()
  (write-sequence (cwd))
  (write-char #\Newline)
  (values))

(defun rm (&rest paths)
  (let ((remap *remap*))
    (dolist (path paths)
      (remap-unlink remap path))))
