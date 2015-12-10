#lang racket
(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (n) (cons (car s) n)) rest)))))

