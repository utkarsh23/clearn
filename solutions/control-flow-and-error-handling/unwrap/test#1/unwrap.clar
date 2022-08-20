;; --------------------------------------------------------------------------------
;; "unwrap!" takes an optional or a response type and will attempt to unwrap it
;; More here: https://book.clarity-lang.org/ch06-03-unwrap-flavours.html
;; --------------------------------------------------------------------------------

(define-constant err-unknown-listing (err u100))
(define-constant err-not-the-maker (err u101))
(define-constant creator tx-sender)

(define-map listings
    {id: uint}
    {name: (string-ascii 50), maker: principal, rank: uint}
)

(map-set listings {id: u1} {name: "First Listing", maker: tx-sender, rank: u1})
(map-set listings {id: u2} {name: "Second Listing", maker: tx-sender, rank: u2})

(define-read-only (get-listing (id uint))
    (map-get? listings {id: id})
)

(define-public (update-name (id uint) (new-name (string-ascii 50)))
    (let
        (
            (listing (unwrap! (get-listing id) err-unknown-listing))
        )
        (asserts! (is-eq tx-sender (get maker listing)) err-not-the-maker)
        ;; #[allow(unchecked_data)]
        (map-set listings {id: id} (merge listing {name: new-name}))
        (ok true)
    )
)
