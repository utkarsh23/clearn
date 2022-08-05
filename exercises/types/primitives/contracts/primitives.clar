;; --------------------------------------------------------------------------------
;; Types are strictly enforced and cannot mix in Clarity.
;; More here: https://book.clarity-lang.org/ch02-01-primitive-types.html
;; --------------------------------------------------------------------------------

;; operate on unsigned integers
(+ 2 u3)

;; operate on signed integers
(* 2 u16)

;; "and" operation: true and true and true = true
(and true true 2)

;; A literal principal value is prefixed by a single quote (') in Clarity.
(stx-get-balance ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE)
(stx-get-balance ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE.my-contract)

;; Syntax for stx-fransfer: https://docs.stacks.co/docs/write-smart-contracts/clarity-language/language-functions#stx-transfer
(stx-transfer? 90 tx-sender 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE)
