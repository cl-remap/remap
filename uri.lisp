;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Thomas de Grivel  <thoxdg@gmail.com>  +33614550127
;;

(in-package :remap)

;;  All reusable URIs and paths should go here

(unless (find-package :remap-uri)
  (defpackage :remap-uri))

(defparameter *remap-uri*
  (find-package :remap-uri))

(defun uri (&rest parts)
  (intern (apply #'str parts) *remap-uri*))

(defun uri-p (x)
  (and (symbolp x) (eq *remap-uri* (symbol-package x))))

#.(let ((check-uri t))
    `(defun check-uri (x)
       ,(if check-uri
            `(assert (uri-p x) (x))
            nil)))

(declaim (inline check-uri))
