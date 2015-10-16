#    x      y         z(mul x y)
# x1 x2  y1  y2       z1     z2
# +  +   +   +      x1*y1   x2*y2
# +  +   -   +      x2*y1   x2*y2
# +  +   -   -      x2*y1   x1*y2

# -  +   +   +      x1*y2   x2*y2
# -  -   +   +      x1*y2   x2*y1
# -  +   -   +       min     max

# -  +   -   -      x2*y1   x1*y1
# -  -   -   +      x1*y2   x1*y1
# -  -   -   -      x2*y2   x1*y1     

(define (make-interval a b) (cons a b))
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

(define (mul-interval-old x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
      (make-interval (min p1 p2 p3 p4)
                     (max p1 p2 p3 p4))))
                     
 (define (mul-interval x y)
    (let ((x1 (lower-bound x))
          (x2 (upper-bound x))
          (y1 (lower-bound y))
          (y2 (upper-bound y))
          (neg-x1 ( <  (lower-bound x) 0))
          (pos-x1 ( >= (lower-bound x) 0))
          (neg-x2 ( <  (upper-bound x) 0))
          (pos-x2 ( >= (upper-bound x) 0))
          (neg-y1 ( < (lower-bound y) 0))
          (pos-y1 ( >= (lower-bound y) 0))
          (neg-y2 ( < (upper-bound y) 0))
          (pos-y2 ( >= (upper-bound y) 0)))
      (cond ((and pos-x1 pos-x2 pos-y1 pos-y2) (make-interval (* x1 y1) (* x2 y2)))
            ((and pos-x1 pos-x2 neg-y1 pos-y2) (make-interval (* x2 y1) (* x2 y2)))
            ((and pos-x1 pos-x2 neg-y1 neg-y2) (make-interval (* x2 y1) (* x1 y2)))
            ((and neg-x1 pos-x2 pos-y1 pos-y2) (make-interval (* x1 y2) (* x2 y2)))
            ((and neg-x1 neg-x2 pos-y1 pos-y2) (make-interval (* x1 y2) (* x2 y1)))
            ((and neg-x1 pos-x2 neg-y1 neg-y2) (make-interval (* x2 y1) (* x1 y1)))
            ((and neg-x1 neg-x2 neg-y1 pos-y2) (make-interval (* x1 y2) (* x1 y1)))
            ((and neg-x1 neg-x2 neg-y1 neg-y2) (make-interval (* x2 y2) (* x1 y1)))
            ((and neg-x1 pos-x2 neg-y1 pos-y2) 
             (let ((p1 (* x1 y1))
                   (p2 (* x1 y2))
                   (p3 (* x2 y1))
                   (p4 (* x2 y2)))
             (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))
            (else 0))
      )
    
    )
(define (equals-interval? a b)
    (and (= (lower-bound a) (lower-bound b))
         (= (upper-bound a) (upper-bound b)))
    )

(define (ensure-mul-works aL aH bL bH)
    (let ((a (make-interval aL aH))
          (b (make-interval bL bH)))
      (if (equals-interval? (mul-interval-old a b) 
                            (mul-interval  a b))
          true
          (error "new mul return different value!"
                 a
                 b
                 (mul-interval-old a b) 
                 (mul-interval  a b)))
      )) 

#validation
(ensure-mul-works  +10 +10   0 10) 

(ensure-mul-works  +10 +10   -3 10) 

(ensure-mul-works  +10 +10   -3 -2) 

(ensure-mul-works  -10 +10   10 20) 

(ensure-mul-works  -10 -2   3 12) 

(ensure-mul-works  -10 2   -3 12) 

(ensure-mul-works  -10 2   -30 -12) 

(ensure-mul-works  -10 -2   -30 12) 

(ensure-mul-works  -10 -2   -30 -12) 
