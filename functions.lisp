;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Copyright 2018 Thomas de Grivel <thoxdg@gmail.com>
;;

(in-package :remap)

(defun cwd ()
  (remap-cwd *remap*))

(defun dir (&key (path (cwd)) (sort 'name) (order '<))
  (remap-dir *remap* path sort order))
