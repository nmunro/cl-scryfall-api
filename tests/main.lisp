(defpackage cl-scryfall-api/tests/main
  (:use :cl
        :cl-scryfall-api
        :rove))
(in-package :cl-scryfall-api/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-scryfall-api)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
  (format t "Testing~%")
    (ok (= 1 1))))