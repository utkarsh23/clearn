;; --------------------------------------------------------------------------------
;; Private functions are defined in the same manner as public functions.
;; The difference is that they can only be called by the current contract.
;; More here: https://book.clarity-lang.org/ch05-02-private-functions.html
;; --------------------------------------------------------------------------------

(define-constant contract-owner tx-sender)
(define-constant err-invalid-caller err u1)

(define-map recipients principal uint)

(define-private (is-valid-caller)
    false
)

(define-public (add-recipient (recipient principal) (amount uint))
    (if (is-valid-caller)
        ;; #[allow(unchecked_data)]
        (ok (map-set recipients recipient amount))
        err-invalid-caller
    )
)

(define-public (delete-recipient (recipient principal))
    (if (is-valid-caller)
        ;; #[allow(unchecked_data)]
        (ok (map-delete recipients recipient))
        err-invalid-caller
    )
)
