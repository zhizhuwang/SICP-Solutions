#lang racket

(define (accumulate fn initial sequence)
  (if (null? sequence) 
      initial
      (fn (car sequence) (accumulate fn initial (cdr sequence)))
      ))


(define (map fn sequence)
  (if (null? sequence)
      '()
      (cons (fn (car sequence)) 
            (map fn (cdr sequence)))))


(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))


> (define seqs (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
> (accumulate-n + 0 seqs)
'(22 26 30)












