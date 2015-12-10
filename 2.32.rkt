#lang racket
(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (n) (cons (car s) n)) rest)))))

;; explanation
;; (subset s) -> (subset [h,t]) where h -> car s, t -> cdr s
;; if rest -> (subset t), the elements of (subset s) have two classes,
;; the other ones that have h, and the other ones that have h,
;; rest is the result of first class, 
;; for the second class, we insert h to every elements of rest
