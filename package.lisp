;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Thomas de Grivel <thoxdg@gmail.com> +33614550127
;;

(in-package :common-lisp-user)

;;  All reusable URIs and paths should go here

(defpackage :remap.uri)

;;  Here we control data remapping

(defpackage :remap
  (:use :babel-stream
        :cl
        :cl-stream
        :remap.uri
        :split-sequence
        :str
        :unistd-stream)
  #.(cl-stream:shadowing-import-from)
  (:export #:*remap*
           #:absolute
           #:absolute!
           #:absolute-or-wild!
           #:absolute-p
           #:cat
           #:cd
           #:cp
           #:cut
           #:cwd
           #:dir
           #:ls
           #:name
           #:open
           #:path-directory-p
           #:path-filename
           #:pwd
           #:remap
           #:remap-cat
           #:remap-cd
           #:remap-cp
           #:remap-cut
           #:remap-cwd
           #:remap-dir
           #:remap-home
           #:remap-open
           #:remap-unlink
           #:rm
           #:shell))

(defpackage :remap-user
  (:use :cl :remap))
