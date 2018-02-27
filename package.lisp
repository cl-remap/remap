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
        :unistd-stream)
  #.(cl-stream:shadowing-import-from)
  (:export #:*hooks*
           #:*remap*
           #:absolute
           #:absolute!
           #:absolute-or-wild!
           #:absolute-p
           #:cat
           #:cd
           #:cwd
           #:dir
           #:from
           #:ftp
           #:home
           #:http
           #:html
           #:ls
           #:open
           #:pwd
           #:remap
           #:remap-cat
           #:remap-cd
           #:remap-cwd
           #:remap-dir
           #:remap-home
           #:remap-open
           #:shell
           #:sync
           #:to))

(defpackage :remap-user
  (:use :cl :remap))
