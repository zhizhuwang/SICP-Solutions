#lang racket
(define (count-leaves t)
  (accumulate + 0 (map (lambda (sub-tree) 
                         (if (not (pair? sub-tree)) 
                             1
                             (count-leaves sub-tree)))
                       t)))


(define (accumulate fn initial sequence)
  (if (null? sequence)
      initial
      (fn (car sequence) 
          (accumulate fn initial (cdr sequence)))))

(define (map f s)
  (if (null? s) (list )
      (cons (f (car s)) (f (cdr s)))))


(define tree (list 1
         (list 2 (list 3 4) 5) (list 6 7)))

(count-leave tree)