#lang racket
(define (unique-pair n)
  (flatmap
   (lambda (i) 
     (map 
      (lambda (j) (list j i)) 
      (enumerate 1 (- i 1))))
   (enumerate 2 n)))

(define (enumerate low high)
  (if (> low high)
      '()
      (cons low (enumerate (+ low 1) high))))

(define (map fun sequence)
  (if (null? sequence)
      '()
      (cons (fun (car sequence)) 
            (map fun (cdr sequence)))))

(define (flatmap fun sequence)
  (if (null? sequence)
      '()
      (append (fun (car sequence)) 
              (flatmap fun (cdr sequence)))))
