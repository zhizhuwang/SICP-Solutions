#lang racket

(define (reverse l)
    (if (null? l)
        '()
        (append (reverse (cdr l)) (list (car l)))))

(define (reverse2 l)
    (define (reverse-iter l r)
      (if (null? l)
          r
          (reverse-iter (cdr l) (cons (car l) r))))
    (reverse-iter l '())
    )