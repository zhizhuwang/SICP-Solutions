#lang racket
(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (square x) (* x x))




(define (square-tree tree)
  (map (lambda (element)  
         (if (pair? element)
             (square-tree element)
             (square element))) 
       tree
  ))

