#lang racket
(define (square-tree tree) (tree-map square tree))
(define (square x) (* x x))

(define (tree-map fn tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (fn tree))
        (else (cons (tree-map fn (car tree)) (tree-map fn (cdr tree))))))


> (square-tree (list 1
         (list 2 (list 3 4) 5) (list 6 7)))
'(1 (4 (9 16) 25) (36 49))