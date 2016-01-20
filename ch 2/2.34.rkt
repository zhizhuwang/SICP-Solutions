#lang racket

(define (horner-eval x coefficient-sequence)
    (accumulate (lambda (this-coeff higher-terms) (+ this-coeff (* x higher-terms)))
                0
                coefficient-sequence))
  
;; 1 + 3x              
> (horner-eval 2 (list 1 3))
7

;; 1 + 3x + 5x^3
> (horner-eval 2 (list 1 3 0 5))
47
