;; NOTE: composites will be better understood in the coming exercises.
;; In this exercise, it would suffice to simply know which composite types exist in Clarity.

;; The type system in Clarity does not allow for empty values.
;; "optional" is used to express variable that could have some value or nothing.
;; Few Examples:
(unwrap-panic (some u10)) ;; Tries to unwrap the some value - unsigned int 10
(if (> 5 10) (some 5) none) ;; Returns none since if condition evaluates to false
;; Fix the error below in representation of a principal
(some ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE)

;; "tuples" can hold key-value structured data.
;; Tuples are immutable, but you can perform merge operation on two tuples.
;; More here: https://docs.stacks.co/docs/write-smart-contracts/clarity-language/language-functions#merge
;; Fix the error due to missing parentheses below
(merge
    {id: 5, score: 10, username: "ClarityIsAwesome"}
    {score: 20, winner: true}


;; "responses" wrap another type just like optional.
;; Responses also indicate if an action was successful or failure.
;; A response of the form: (ok ...) or (err ...)
;; Few Examples:
(ok "Success")
(err u16)
;; Fix the Clarity error and return a boolean error response: true
(err "true)
