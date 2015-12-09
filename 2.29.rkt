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
    (let ((s (branch-structure b)))
    (if (integer? s)
        s
        (branch-weight s))))  

 (define mobile (make-mobile (make-branch 10 25)
                             (make-branch 5 20)))

> (left-branch mobile)
'(10 25)
> (total-weight mobile)
45

;; part c
(define (balanced? m)
    (cond ((integer? m) #t) 
      ((= (* (branch-length (left-branch m)) (branch-weight (left-branch m))) 
          (* (branch-length (right-branch m)) (branch-weight (right-branch m))))
        (and (balanced? (branch-structure (left-branch m))) 
             (balanced? (branch-structure (right-branch m))))) 
      (else #f)))

;; after refacoring
 (define (torque b) 
    (* (branch-length b) (branch-weight b)))
 
 (define (mobile? m) (pair? m))

 (define (branch-balanced? b)
    (let ((structure (branch-structure b)))
      (if (mobile? structure)
        (banlanced? structrue)
        #t)))
(define (balanced? m)
	(let ((left (left-branch m))
              (right (right-branch m)))
          (if (mobile? m)
              (and (= (torque left) (torque right))
                   (branch-balanced? left)
                   (branch-balanced? right))
              #t)
          )
	)
    


;; part d
;; we need to change the constructors and selectors
(define (make-mobile left right)
	(cons left right))
(define (make-branch length structure)
	(cons length structure))


(define (branch-structure b) 
    (cdr b))
(define (right-branch m)
	(cdr m))