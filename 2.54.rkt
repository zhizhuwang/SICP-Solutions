#lang racket
(define (equal? a b)
  (cond ((eq? a b) #t)
        ((and (list? a) 
              (list? b) 
              (equal? (car a) (car b))) 
         (equal? (cdr a) (cdr b)))
        (else #f)))

