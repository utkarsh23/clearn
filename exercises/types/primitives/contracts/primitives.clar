;; operate on unsigned integers
(+ 2 u3)

;; operate on signed integers
(* 2 u16)

;; "and" operation: true and true and true = true
(and true true 2)

;; principal is a type that represents a Stacks address. e.g. SZ2J6ZY48GV1EZ5V2V5RB9MP66SW86PYKKQ9H6DPR
;; A literal principal value is prefixed by a single quote (') in Clarity.
(stx-get-balance ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE)
(stx-get-balance ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE.my-contract)

;; Follow this syntax to fix the error: (stx-transfer? uint, principal, principal)
;; More here: https://docs.stacks.co/docs/write-smart-contracts/clarity-language/language-functions#stx-transfer
(stx-transfer? 500 tx-sender 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE)
