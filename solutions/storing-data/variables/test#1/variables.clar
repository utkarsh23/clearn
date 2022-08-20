;; --------------------------------------------------------------------------------
;; Variables are data members that can be changed over time.
;; More here: https://book.clarity-lang.org/ch04-02-variables.html
;; --------------------------------------------------------------------------------

(define-constant SUCCESS-RESP u200)
(define-data-var high-score
    {
        score: uint,
        who: (optional principal),
        at-height: uint
    }
    {
        score: u0,
        who: none,
        at-height: u0
    }
)

(define-public (set-high-score (score uint))
    (begin
        (var-set high-score {score: u10, who: (some tx-sender), at-height: block-height})
        (ok SUCCESS-RESP)
    )
)

(define-read-only (get-high-score)
    (some (var-get high-score))
)
