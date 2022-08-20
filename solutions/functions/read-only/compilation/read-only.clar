;; --------------------------------------------------------------------------------
;; Read-only functions can be called by the contract itself, as well as from the outside.
;; They can return any type, just like private functions.
;; More here: https://book.clarity-lang.org/ch05-03-read-only-functions.html
;; --------------------------------------------------------------------------------

(define-constant contract-owner tx-sender)
(define-map counters principal uint)

(map-set counters tx-sender u55)

(define-read-only (add (a uint) (b uint))
    (+ a b)
)

(define-read-only (get-my-counter)
    (some true)
)
