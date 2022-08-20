;; --------------------------------------------------------------------------------
;; Data Map is a kind of data structure that allows you to map keys to specific values.
;; Unlike tuple keys, data map keys are not hard-coded names.
;; More here: https://book.clarity-lang.org/ch04-03-maps.html
;; --------------------------------------------------------------------------------

(define-constant SUCCESS-RESP u200)
(define-map orders uint {maker: principal, orderAmount: uint})

(define-public (set-order-one (amt uint))
    (begin
        ;; #[allow(unchecked_data)]
        (map-set orders u1 {maker: tx-sender, orderAmount: u100})
        (ok SUCCESS-RESP)
    )
)

(define-read-only (order-one)
    (map-get? orders u1)
)

(define-map highest-bids
    {listing-id: uint, asset: (optional principal)}
    {bid-id: uint}
)

(define-public (set-highest-bids)
    (begin
        (map-set highest-bids {listing-id: u5, asset: none} {bid-id: u20})
        (ok SUCCESS-RESP)
    )
)

(define-read-only (get-highest-bids)
    (map-get? highest-bids {listing-id: u5, asset: (some 'SP3KANBW2C4E5BRPWNTWZCCDGF2F87CW9D9KV0FFK)})
)
