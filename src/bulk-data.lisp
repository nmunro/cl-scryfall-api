(defpackage cl-scryfall-api/bulk-data
  (:use :cl))

(in-package cl-scryfall-api/bulk-data)

(defconstant +oracle-cards+ "https://data.scryfall.io/oracle-cards/oracle-cards-20221121100237.json")
(defconstant +unique-artwork+ "https://data.scryfall.io/unique-artwork/unique-artwork-20221121100329.json")
(defconstant +default-cards+ "https://data.scryfall.io/default-cards/default-cards-20221121100557.json")
(defconstant +all-cards+ "https://data.scryfall.io/all-cards/all-cards-20221121101623.json")
(defconstant +all-rulings+ "https://data.scryfall.io/rulings/rulings-20221121100027.json")

(defun process-json (json)
  json)

(defun get-json (url dest)
  (serapeum:write-stream-into-file (dex:get url :want-stream t) dest :if-exists :supersede))

(defun get-bulk-data (&optional download-type)
  (cond
    ((eq download-type :oracle-cards)
     (get-json +oracle-cards+ #p"~/Desktop/scryfall.json"))

    ((eq download-type :unique-artwork)
     (get-json +unique-artwork+ #p"~/Desktop/scryfall.json"))

    ((eq download-type :all-cards)
     (get-json +all-cards+ #p"~/Desktop/scryfall.json"))

    ((eq download-type :all-rulings)
     (get-json +all-rulings+ #p"~/Desktop/scryfall.json"))

    (t
     (get-json +default-cards+ #p"~/Desktop/scryfall.json"))))

(get-bulk-data)
(get-bulk-data :all-rulings)
