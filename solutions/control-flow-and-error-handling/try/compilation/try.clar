;; --------------------------------------------------------------------------------
;; "try!" takes an optional or a response type and will attempt to unwrap it
;; More here: https://book.clarity-lang.org/ch06-02-try.html
;; --------------------------------------------------------------------------------

(define-public (try-example (input (response uint uint)))
    (begin
        (try! input)
        (ok "end of the function")
    )
)
