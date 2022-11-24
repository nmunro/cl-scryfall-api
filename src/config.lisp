(defpackage cl-scryfall-api/config
  (:use :cl)
  (:export #:+config-dir+
           #:+config-file+
           #:make-config-dir))

(in-package cl-scryfall-api/config)

(defconstant +config-dir+ (merge-pathnames #p".config/cl-scryfall-api/" (user-homedir-pathname)))
(defconstant +config-file+ (merge-pathnames #p"config.db" +config-dir+))

(defun make-config-dir ()
  (ensure-directories-exist +config-dir+))
