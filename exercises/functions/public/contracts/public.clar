;; --------------------------------------------------------------------------------
;; Public functions are callable from the outside by both standard principals and contract principals.
;; More here: https://book.clarity-lang.org/ch05-01-public-functions.html
;; --------------------------------------------------------------------------------

(define-data-var even-values uint u0)

(define-public (count-even number uint)
    (begin
        (var-set even-values (+ (var-get even-values) u1))

        (if (is-eq (mod number u2) u0)
            (ok "the number is even")
            (err "the number is uneven")
        )
    )
)

(define-public (sum-three)
    (err true)
)
