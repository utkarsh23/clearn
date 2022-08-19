;; --------------------------------------------------------------------------------
;; "asserts!" exits the current control flow if expression evaluates to false
;; More here: https://book.clarity-lang.org/ch06-01-asserts.html
;; --------------------------------------------------------------------------------

(define-constant contract-owner tx-sender)
(define-constant err-invalid-caller (err u1))

(define-map recipients principal uint)

(define-private (is-valid-caller)
    (is-eq contract-owner tx-sender)
)

(define-public (add-recipient (recipient principal) (amount uint))
    (begin
        ;; Assert the tx-sender is valid.
        (asserts true err-invalid-caller)
        ;; #[allow(unchecked_data)]
        (ok (map-set recipients recipient amount))
    )
)
