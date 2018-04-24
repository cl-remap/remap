
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
