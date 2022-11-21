(defsystem "cl-scryfall-api"
  :version "0.0.1"
  :author "nmunro"
  :license "BSD3-Clause"
  :depends-on (:dexador
               :cl-json)
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "Generate a skeleton for modern project"
  :in-order-to ((test-op (test-op "cl-scryfall-api/tests"))))

(defsystem "cl-scryfall-api/tests"
  :author "nmunro"
  :license "BSD3-Clause"
  :depends-on ("cl-scryfall-api"
               :rove)
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for cl-scryfall-api"
  :perform (test-op (op c) (symbol-call :rove :run c)))
