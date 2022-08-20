;; --------------------------------------------------------------------------------
;; Sequences hold a sequence of data.
;; More here: https://book.clarity-lang.org/ch02-02-sequence-types.html
;; --------------------------------------------------------------------------------

;; list of signed integers
(list 4 8 15 16 23 42)

;; list of unsigned integers
(list u5 u10 u15)

(map not (list true true false false))

(fold + (list u737 u6488 u321) u0)

;; length of a list of integers
(len (list 4 8 15 16 23 42 51))

;; find the "element-at" at a given index.
(element-at (list 4 8 15 16 23 42) u3)

;; find the "index-of" an element in the list.
(index-of (list 4 8 15 16 23 21) 23)
