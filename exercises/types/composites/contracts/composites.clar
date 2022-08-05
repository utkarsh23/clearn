;; --------------------------------------------------------------------------------
;; Composites are complex types that contain a number of other types.
;; More here: https://book.clarity-lang.org/ch02-03-composite-types.html
;; --------------------------------------------------------------------------------

;; "optional" is used to express variable that could have some value or nothing.
(some ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE)

;; "tuples" can hold key-value structured data.
{
    id: 5,
    score: u10,
    playersBuffered: (list 0x31adba 0x5893eadb 0x733),
    username: "ClarityIsAwesome"
}

;; response wraps a value in concrete (ok ...) or (err ...) response types.
(ok (list false true false false 0))
