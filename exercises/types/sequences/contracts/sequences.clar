;; --------------------------------------------------------------------------------
;; Sequences hold a sequence of data.
;; More here: https://book.clarity-lang.org/ch02-02-sequence-types.html
;; --------------------------------------------------------------------------------

;; list of signed integers
(list 4 8 15 u16 23 42)

;; list of unsigned integers
(list u5 10 "hello")

(map not (list true true "0" false))

(fold + (list u737 u6488 u321) 0)

;; length of a list of integers
(len (list 4 8 15 16 23 42 true))

;; find the "element-at" at a given index.
(element-at (list 4 8 15 16 23 42) 3)

;; find the "index-of" an element in the list.
(index-of (list 4 8 15 16 23 0x21) 23)
