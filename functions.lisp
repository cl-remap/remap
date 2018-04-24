;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Thomas de Grivel  <thoxdg@gmail.com>  +33614550127
;;

(in-package :remap)

(defun cwd ()
  (remap-cwd *remap*))

(defun dir (&key (path (cwd)) (sort 'name) (order '<))
  (remap-dir *remap* path sort order))
