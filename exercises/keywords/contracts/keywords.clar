;; --------------------------------------------------------------------------------
;; Keywords are special terms that have an assigned meaning. e.g. true, false, none
;; More here: https://book.clarity-lang.org/ch03-00-keywords.html
;; --------------------------------------------------------------------------------

(define-read-only (get-burn-block-height)
    (some burn-block-height)
)

(define-read-only (get-block-height)
    (some (+ block-height 128))
)

(define-read-only (get-sender-principal)
    (some tx-sender)
)
