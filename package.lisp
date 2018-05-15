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
        :local-time
        :remap.uri
        :rollback
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
           #:cwd
           #:dir
           #:ls
           #:name
           #:open
           #:pwd
           #:remap
           #:remap-cat
           #:remap-cd
           #:remap-cp
           #:remap-cwd
           #:remap-dir
           #:remap-home
           #:remap-open
           #:remap-unlink
           #:rm
           #:shell))

(defpackage :remap-user
  (:use :cl :remap))
