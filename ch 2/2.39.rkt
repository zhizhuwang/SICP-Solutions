#lang racket
(define (foldl fun initial sequence)
  (if (null? sequence)
      initial
      (foldl fun 
             (fun (car sequence) initial) 
             (cdr sequence))))

(define (reverse-left sequence)
  (foldl cons '() sequence))


(define (foldr fun initial sequence)
  (if (null? sequence)
      initial
      (fun (car sequence) (foldr fun initial (cdr sequence)))))

(define (reverse-right sequence)
  (foldr (lambda (x y) (append y (list x))) '() sequence))
