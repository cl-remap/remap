;;
;;  remap  -  modular transactional file system in Common Lisp
;;  Thomas de Grivel <thoxdg@gmail.com> +33614550127
;;

(in-package :common-lisp-user)

(defpackage :remap.system
  (:use :cl :asdf))

(in-package :remap.system)

(defsystem :remap
  :name "remap"
  :author "Thomas de Grivel <thoxdg@gmail.com>"
  :version "0.2"
  :description "modular transactional file system"
  :depends-on ("babel-stream"
               "cl-stream"
               "split-sequence"
               "str"
               "unistd-stream"
               "utf8-stdio")
  :components
  ((:file "package")
   (:file "path" :depends-on ("package"))
   (:file "remap" :depends-on ("path"))
   (:file "functions" :depends-on ("remap"))
   (:file "commands" :depends-on ("functions"))
   (:file "shell" :depends-on ("commands"))))
