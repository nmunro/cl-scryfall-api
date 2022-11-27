(defpackage cl-scryfall-api/bulk-data
  (:use :cl)
  (:export #:get-bulk-data))

(in-package cl-scryfall-api/bulk-data)

(defconstant +bulk-data-url+ "https://api.scryfall.com/bulk-data")
(defconstant +bulk-data-db+ (merge-pathnames #p"bulk-data.db" cl-scryfall-api/config:+config-dir+))

(defun process-json (&optional file)
  "Make sure you have --dynamic-size (in sbcl) set high enough to process the json files"
  nil)
  
(defun download-data (url dest)
  (serapeum:write-stream-into-file (dexador:get url :want-stream t) dest :if-exists :supersede))

(defun make-download-path-name (item)
  (merge-pathnames (format nil "~A.json" (getf item :type)) cl-scryfall-api/config:+config-dir+))

(defun process-bulk-data-object (object)
  `(:type ,(cdr (assoc :type object)) :uri ,(cdr (assoc :download--uri object))))

(defun download-json-file (item count length)
    (format t "Downloading ~A/~A ~A..." count length (getf item :type))
    (force-output)
    (download-data (getf item :uri) (make-download-path-name item))
    (format t " Done!~%"))

(defun recover ()
  (format t " Failed!~%"))
  
(defun get-bulk-data ()
 (multiple-value-bind (body status headers)
     (dexador:get +bulk-data-url+)
   (declare (ignore status))
   (declare (ignore headers))

   (let ((data (cl-json:decode-json-from-string body))
	 (count 1))
     (dolist (item (mapcar #'process-bulk-data-object (cdr (assoc :data data))))
       (handler-case (download-json-file item count (length (cdr (assoc :data data))))
         (error (err) (recover)))
       (incf count)))))
       
;; (get-bulk-data)

;; (ql:quickload :dexador)
;; (ql:quickload :cl-json)
;; (ql:quickload :serapeum)
