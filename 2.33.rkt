#lang racket

(define (accumulate fn initial sequence)
	(if (null? sequence) 
		initial
		(fn (car sequence)
                    (accumulate fn initial (cdr sequence)))))
(define (map p sequence)
	(accumulate (lambda (x y) (cons (p x) y)) (list ) sequence))
	
(define (append2 seq1 seq2)
  (accumulate cons seq2 seq1))
