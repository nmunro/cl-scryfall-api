(defpackage cl-scryfall-api/bulk-data
  (:use :cl))

(in-package cl-scryfall-api/bulk-data)

(defconstant +oracle-cards+ "https://data.scryfall.io/oracle-cards/oracle-cards-20221121100237.json")
(defconstant +unique-artwork+ "https://data.scryfall.io/unique-artwork/unique-artwork-20221121100329.json")
(defconstant +default-cards+ "https://data.scryfall.io/default-cards/default-cards-20221121100557.json")
(defconstant +all-cards+ "https://data.scryfall.io/all-cards/all-cards-20221121101623.json")
(defconstant +all-rulings+ "https://data.scryfall.io/rulings/rulings-20221121100027.json")

(defun process-json (&optional file)
  "Make sure you have --dynamic-size (in sbcl) set high enough to process the json files"
  (cond
    ((eq file :oracle-cards)
     (let ((path (merge-pathnames #p"oracle.json" cl-scryfall-api/config:+config-dir+)))
       (with-open-file (s path :direction :input :if-does-not-exist nil)
        (cl-json:decode-json-from-source s))))

    ((eq file :unique-artwork)
     (let ((path (merge-pathnames #p"unique-artwork.json" cl-scryfall-api/config:+config-dir+)))
       (with-open-file (s path :direction :input :if-does-not-exist nil)
        (cl-json:decode-json-from-source s))))

    ((eq file :all-cards)
     (let ((path (merge-pathnames #p"all-cards.json" cl-scryfall-api/config:+config-dir+)))
       (with-open-file (s path :direction :input :if-does-not-exist nil)
        (cl-json:decode-json-from-source s))))

    ((eq file :all-rulings)
     (let ((path (merge-pathnames #p"rulings.json" cl-scryfall-api/config:+config-dir+)))
       (with-open-file (s path :direction :input :if-does-not-exist nil)
        (cl-json:decode-json-from-source s))))

    (t
     (let ((path (merge-pathnames #p"default.json" cl-scryfall-api/config:+config-dir+)))
       (with-open-file (s path :direction :input :if-does-not-exist nil)
        (cl-json:decode-json-from-source s))))))

(defun get-json (url dest)
  (serapeum:write-stream-into-file (dexador:get url :want-stream t) dest :if-exists :supersede))

(defun get-bulk-data (&optional download-type)
  (cond
    ((eq download-type :oracle-cards)
     (let ((path (merge-pathnames #p"oracle.json" cl-scryfall-api/config:+config-dir+)))
       (format t "Beginning download of: oracle.json... ")
       (force-output)
       (get-json +oracle-cards+ path)
       (format t "Done!~%")))

    ((eq download-type :unique-artwork)
     (let ((path (merge-pathnames #p"unique-artwork.json" cl-scryfall-api/config:+config-dir+)))
       (format t "Beginning download of: unique-artwork.json... ")
       (force-output)
       (get-json +unique-artwork+ path)
       (format t "Done!~%")))

    ((eq download-type :all-cards)
     (let ((path (merge-pathnames #p"all-cards.json" cl-scryfall-api/config:+config-dir+)))
       (format t "Beginning download of: all-cards.json... ")
       (force-output)
       (get-json +all-cards+ path)
       (format t "Done!~%")))

    ((eq download-type :all-rulings)
     (let ((path (merge-pathnames #p"rulings.json" cl-scryfall-api/config:+config-dir+)))
       (format t "Beginning download of: rulings.json... ")
       (force-output)
       (get-json +all-rulings+ path)
       (format t "Done!~%")))

    (t
     (let ((path (merge-pathnames #p"default.json" cl-scryfall-api/config:+config-dir+)))
       (format t "Beginning download of: default.json... ")
       (force-output)
       (get-json +default-cards+ path)
       (format t "Done!~%")))))

;; (get-bulk-data)
;; (process-json)

(get-bulk-data :all-rulings)
;(process-json :all-rulings)
(process-json)

;; (ql:quickload :dexador)
;; (ql:quickload :cl-json)
;; (ql:quickload :serapeum)
