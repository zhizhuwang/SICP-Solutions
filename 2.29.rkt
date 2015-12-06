(define (make-mobile left right)
	(list left right))

(define (make-branch length structure)
	(list length structure))

;; part a
(define (branch-length b) 
    (car b))
(define (branch-structure b) 
    (car (cdr b)))
(define (left-branch m)
	(car m))
(define (right-branch m)
	(car (cdr m)))

;; part b
 (define (total-weight m)
    (+ (branch-weight (left-branch m))
       (branch-weight (right-branch m))))

(define (branch-weight b)
    (if (integer? (branch-structure b))
        (branch-structure b)
        (branch-weight (branch-structure b)))

 (define mobile (make-mobile (make-branch 10 25)
                             (make-branch 5 20)))

> (left-branch mobile)
'(10 25)
> (total-weight mobile)
45