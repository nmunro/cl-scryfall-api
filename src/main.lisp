(defpackage cl-scryfall-api
  (:use :cl)
  (:export #:get-by-scryfall-id
           #:set-id
           #:set-code
           #:set-name
           #:set-type
           #:set-uri
           #:set-search-uri
           #:object
           #:id
           #:oracle-id
           #:multiverse-ids
           #:tcgplayer-id
           #:cardmarket-id
           #:name
           #:lang
           #:released-at
           #:uri
           #:scryfall-uri
           #:layout
           #:highres-image
           #:image-status
           #:image-uris
           #:mana-cost
           #:cmc
           #:type-line
           #:oracle-text
           #:power
           #:toughness
           #:colors
           #:color-identity
           #:keywords
           #:legalities
           #:games
           #:reserved
           #:foil
           #:non-foil
           #:finishes
           #:oversized
           #:promo
           #:reprint
           #:variation
           #:set-info
           #:scryfall-search-uri
           #:rulings-uri
           #:prints-search-uri
           #:collector-number
           #:digital
           #:rarity
           #:flavor-text
           #:card-back-id
           #:artist
           #:artist-ids
           #:illustration-id
           #:border-color
           #:frame
           #:security-stamp
           #:full-art
           #:textless
           #:booster
           #:story-spotlight
           #:edhrec-rank
           #:penny-rank
           #:prices
           #:related-uris
           #:purchase-uris))

(in-package cl-scryfall-api)

(defclass set-info ()
  ((id         :initarg :set-id         :initform nil :reader set-id)
   (code       :initarg :set-code       :initform nil :reader set-code)
   (name       :initarg :set-name       :initform nil :reader set-name)
   (type       :initarg :set-type       :initform nil :reader set-type)
   (uri        :initarg :set-uri        :initform nil :reader set-uri)
   (search-uri :initarg :set-search-uri :initform nil :reader set-search-uri)))

(defmethod print-object ((obj set-info) out)
  (print-unreadable-object (obj out)
    (format out "~A" (set-name obj))))

(defun make-set-info (id code name type uri search-uri)
  (make-instance 'set-info :set-id id :set-code code :set-name name :set-type type :set-uri uri :set-search-uri search-uri))

(defclass card ()
  ((object            :initarg :object            :initform (error "Must provide an object")    :reader object)
   (id                :initarg :id                :initform (error "Must provide an id")        :reader id)
   (oracle-id         :initarg :oracle-id         :initform (error "Must provide an oracle id") :reader oracle-id)
   (multiverse-ids    :initarg :multiverse-ids    :initform '()                                 :reader multiverse-ids)
   (tcgplayer-id      :initarg :tcgplayer-id      :initform 0                                   :reader tcgplayer-id)
   (cardmarket-id     :initarg :cardmarket-id     :initform 0                                   :reader cardmarket-id)
   (name              :initarg :name              :initform (error "Must provide a name")       :reader name)
   (lang              :initarg :lang              :initform ""                                  :reader lang)
   (released-at       :initarg :released-at       :initform ""                                  :reader released-at)
   (uri               :initarg :uri               :initform ""                                  :reader uri)
   (scryfall-uri      :initarg :scryfall-uri      :initform ""                                  :reader scryfall-uri)
   (layout            :initarg :layout            :initform ""                                  :reader layout)
   (highres-image     :initarg :highres-image     :initform ""                                  :reader highres-image)
   (image-status      :initarg :image-status      :initform ""                                  :reader image-status)
   (image-uris        :initarg :image-uris        :initform '()                                 :reader image-uris)
   (mana-cost         :initarg :mana-cost         :initform ""                                  :reader mana-cost)
   (cmc               :initarg :cmc               :initform 0                                   :reader cmc)
   (type-line         :initarg :type-line         :initform ""                                  :reader type-line)
   (oracle-text       :initarg :oracle-text       :initform ""                                  :reader oracle-text)
   (power             :initarg :power             :initform 0                                   :reader power)
   (toughness         :initarg :toughness         :initform 0                                   :reader toughness)
   (colors            :initarg :colors            :initform '()                                 :reader colors)
   (color-identity    :initarg :color-identity    :initform '()                                 :reader color-identity)
   (keywords          :initarg :keywords          :initform '()                                 :reader keywords)
   (legalities        :initarg :legalities        :initform '()                                 :reader legalities)
   (games             :initarg :games             :initform '()                                 :reader games)
   (reserved          :initarg :reserved          :initform nil                                 :reader reserved)
   (foil              :initarg :foil              :initform nil                                 :reader foil)
   (non-foil          :initarg :non-foil          :initform nil                                 :reader non-foil)
   (finishes          :initarg :finishes          :initform '()                                 :reader finishes)
   (oversized         :initarg :oversized         :initform nil                                 :reader oversized)
   (promo             :initarg :promo             :initform nil                                 :reader promo)
   (reprint           :initarg :reprint           :initform nil                                 :reader reprint)
   (variation         :initarg :variation         :initform nil                                 :reader variation)
   (set-info          :initarg :set-info          :initform (error "Must provide set info")     :reader set-info)
   (scryfall-set-uri  :initarg :scryfall-set-uri  :initform nil                                 :reader scryfall-search-uri)
   (rulings-uri       :initarg :rulings-uri       :initform nil                                 :reader rulings-uri)
   (prints-search-uri :initarg :prints-search-uri :initform nil                                 :reader prints-search-uri)
   (collector-number  :initarg :collector-number  :initform nil                                 :reader collector-number)
   (digital           :initarg :digital           :initform nil                                 :reader digital)
   (rarity            :initarg :rarity            :initform nil                                 :reader rarity)
   (flavor-text       :initarg :flavor-text       :initform ""                                  :reader flavor-text)
   (card-back-id      :initarg :card-back-id      :initform ""                                  :reader card-back-id)
   (artist            :initarg :artist            :initform ""                                  :reader artist)
   (artist-ids        :initarg :artist-ids        :initform '()                                 :reader artist-ids)
   (illustration-id   :initarg :illustration-id   :initform '()                                 :reader illustration-id)
   (border-color      :initarg :border-color      :initform ""                                  :reader border-color)
   (frame             :initarg :frame             :initform ""                                  :reader frame)
   (security-stamp    :initarg :security-stamp    :initform ""                                  :reader security-stamp)
   (full-art          :initarg :full-art          :initform nil                                 :reader full-art)
   (textless          :initarg :textless          :initform nil                                 :reader textless)
   (booster           :initarg :booster           :initform nil                                 :reader booster)
   (story-spotlight   :initarg :story-spotlight   :initform nil                                 :reader story-spotlight)
   (edhrec-rank       :initarg :edhrec-rank       :initform ""                                  :reader edhrec-rank)
   (penny-rank        :initarg :penny-rank        :initform ""                                  :reader penny-rank)
   (prices            :initarg :prices            :initform ""                                  :reader prices)
   (related-uris      :initarg :related-uris      :initform ""                                  :reader related-uris)
   (purchase-uris     :initarg :purchase-uris     :initform ""                                  :reader purchase-uris)))

(defmethod print-object ((obj card) out)
  (print-unreadable-object (obj out)
    (format out "~A: ~A" (name obj) (set-name (set-info obj)))))

(defun get-property (property object)
  (cdr (assoc property object)))

(defun get-by-scryfall-id (id)
  (multiple-value-bind (body status headers)
    (dexador:get (format nil "https://api.scryfall.com/cards/~A" id))

    (let ((json (cl-json:decode-json-from-string body)))
      (let ((set-info (make-set-info
                       (get-property :set--id json)
                       (get-property :set--name json)
                       (get-property :set--code json)
                       (get-property :set--type json)
                       (get-property :set--uri json)
                       (get-property :set--search--uri json))))
        (make-instance 'card
                   :object            (get-property :object              json)
                   :id                (get-property :id                  json)
                   :oracle-id         (get-property :oracle--id          json)
                   :multiverse-ids    (get-property :multiverse--ids     json)
                   :tcgplayer-id      (get-property :tcgplayer--id       json)
                   :cardmarket-id     (get-property :cardmarket--id      json)
                   :name              (get-property :name                json)
                   :lang              (get-property :lang                json)
                   :released-at       (get-property :released--at        json)
                   :uri               (get-property :uri                 json)
                   :scryfall-uri      (get-property :scryfall--uri       json)
                   :layout            (get-property :layout              json)
                   :highres-image     (get-property :highres--image      json)
                   :image-status      (get-property :image--status       json)
                   :image-uris        (get-property :image--uris         json)
                   :mana-cost         (get-property :mana--cost          json)
                   :cmc               (get-property :cmc                 json)
                   :type-line         (get-property :type--line          json)
                   :oracle-text       (get-property :oracle--text        json)
                   :power             (get-property :power               json)
                   :toughness         (get-property :toughness           json)
                   :colors            (get-property :colors              json)
                   :color-identity    (get-property :color--identity     json)
                   :keywords          (get-property :keywords            json)
                   :legalities        (get-property :legalities          json)
                   :games             (get-property :games               json)
                   :reserved          (get-property :reserved            json)
                   :foil              (get-property :foil                json)
                   :non-foil          (get-property :non--foil           json)
                   :finishes          (get-property :finishes            json)
                   :oversized         (get-property :oversized           json)
                   :promo             (get-property :promo               json)
                   :reprint           (get-property :reprint             json)
                   :variation         (get-property :variation           json)
                   :set-info          set-info
                   :scryfall-set-uri  (get-property :scryfall--set--uri  json)
                   :rulings-uri       (get-property :rulings--uri        json)
                   :prints-search-uri (get-property :prints--search--uri json)
                   :collector-number  (get-property :collectors--number  json)
                   :digital           (get-property :digital             json)
                   :rarity            (get-property :rarity              json)
                   :flavor-text       (get-property :flavor--text        json)
                   :card-back-id      (get-property :card-back--id       json)
                   :artist            (get-property :artist              json)
                   :artist-ids        (get-property :artist--ids         json)
                   :illustration-id   (get-property :illustration--id    json)
                   :border-color      (get-property :border--color       json)
                   :frame             (get-property :frame               json)
                   :security-stamp    (get-property :security--stamp     json)
                   :full-art          (get-property :full--art           json)
                   :textless          (get-property :textless            json)
                   :booster           (get-property :booster             json)
                   :story-spotlight   (get-property :story--spotlight    json)
                   :edhrec-rank       (get-property :edhrec--rank        json)
                   :penny-rank        (get-property :penny--rank         json)
                   :prices            (get-property :prices              json)
                   :related-uris      (get-property :related--uris       json)
                   :purchase-uris     (get-property :purchase--uris      json))))))
