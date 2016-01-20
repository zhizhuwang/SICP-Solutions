(define (make-interval a b) (cons a b))
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

(define (print-interval name i)
    (newline)
    (display name)
    (display ":  [")
    (display (lower-bound i))
    (display ",")
    (display (upper-bound i))
    (display "]"))

(define (div-interval x y)
    (if (>= 0 (* (lower-bound y) (upper-bound y))) 
        (error "Division error (interval spans 0)" y)
        (mul-interval x
                      (make-interval (/ 1.0 (upper-bound y))
                                     (/ 1.0 (lower-bound y))))))
(define i (make-interval 2 7))
 (define j (make-interval 8 3))

(print-interval "j/i" (div-interval j i))
#j/i:  [0.42857142857142855,4.0]

(print-interval "i/j" (div-interval i j))
#i/j:  [0.25,2.333333333333333]

(print-interval "i/j" (div-interval i (make-interval -1 1)))
Division error (interval spans 0) (-1 . 1)

 

