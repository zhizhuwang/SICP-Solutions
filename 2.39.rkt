#lang racket
(define (foldl fun initial sequence)
  (if (null? sequence)
      initial
      (foldl fun 
             (fun (car sequence) initial) 
             (cdr sequence))))

(define (reverse-left sequence)
  (foldl cons '() sequence))