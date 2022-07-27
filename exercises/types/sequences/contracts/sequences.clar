;; list of signed integers
(list 4 8 15 u16 23 42)

;; list of unsigned integers
(list u5 10 "hello")

;; "map" applies an input function to each element and returns this new list.
;; Fix the error in the list below.
;; More here: https://docs.stacks.co/docs/write-smart-contracts/clarity-language/language-functions#map
(map not (list true true "0" false))

;; "fold" applies an input function to every element & the output of previous application.
;; Fix the error in the list below for computing (+ u3 (+ u2 (+ u1 u0))) using fold.
;; More here: https://docs.stacks.co/docs/write-smart-contracts/clarity-language/language-functions#fold
(fold + (list u1 u2 3) u0)

;; "len" is used to retrieve the length of a sequence.
;; More here: https://docs.stacks.co/docs/write-smart-contracts/clarity-language/language-functions#len
;; Few Examples:
(len 0x68656c6c6f21) ;; Length of a Buffer (each byte in a buffer made up of two hexits)
(len "How long is this string?") ;; Length of an ASCII String
(len u"And this is an UTF-8 string \u{1f601}") ;; Length of a UTF-8 String
;; Fix the error in the sequence below.
(len (list 4 8 15 "16" 23 42))

;; "element-at" extracts the element at a given index.
;; Fix the types to fix the error: (element-at sequence uint)
;; More here: https://docs.stacks.co/docs/write-smart-contracts/clarity-language/language-functions#element-at
(element-at (list 4 8 15 16 23 42) 3)

;; "index-of" returns the index of an element.
;; Fix the error in the list below.
;; More here: https://docs.stacks.co/docs/write-smart-contracts/clarity-language/language-functions#index-of
(index-of (list 4 8 15 16 23 0x21) 23)
