;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Copyright 2018 Thomas de Grivel <thoxdg@gmail.com>
;;

(in-package :common-lisp-user)

(defpackage :remap.test
  (:use :cl :remap))

(in-package :remap.test)

(defun test (&optional (*remap* *remap*))
  (cwd)
  (pwd)
  (cd)
  (cd "/")
  (dir)
  (ls)
  (dir :path "*.txt"))
