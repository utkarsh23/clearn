;; --------------------------------------------------------------------------------
;; Constants are useful to define the contract owner, error codes, and other static values.
;; More here: https://book.clarity-lang.org/ch04-01-constants.html
;; --------------------------------------------------------------------------------

(define-constant my-constant "Constant value ")
(define-constant my-second-constant
    (concat my-constant "1212")
)
(define-constant contract-owner 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE)

(define-read-only (get-second-constant)
    (some my-second-constant)
)

(define-read-only (get-deployer-contract)
    (some contract-owner)
)
