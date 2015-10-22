(define (make-interval a b) (cons a b))
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))
                   
(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
      (make-interval (min p1 p2 p3 p4)
                     (max p1 p2 p3 p4))))

(define (div-interval x y)
    (mul-interval x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y)))))
                                 
(define (make-center-percent center percent) 
   (let ((width (/ (* center percent) 100)))
     (make-interval (- center width) (+ center width))
     )
   )
(define (center i) 
    (/ (+ (lower-bound i) (upper-bound)) 2)
    )
(define (width i)
    (/ (- (upper-bound i) (lower-bound i)) 2)
    )

(define (center i) 
    (/ (+ (lower-bound i) (upper-bound i)) 2)
    )
(define (width i)
    (/ (- (upper-bound i) (lower-bound i)) 2)
    )
    
 (define (percent i)
    (* (/ (interval-width i) (center i)) 100.0))
    
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2) 
                (add-interval r1 r2)))
                
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
      (div-interval one 
          (add-interval (div-interval one r1)
                        (div-interval one r2))
          )
  )
)

(define R1 (make-center-percent 40000 0.001))
(define R2 (make-center-percent 80000 0.001))


(par1 R1 R2)
'(26665.866677333222 . 26667.466677333443)
  

(par1 R1 R2)
'(26665.866677333222 . 26667.466677333443)
(par2 R1 R2)
'(26666.399999999998 . 26666.933333333334)

(center (par1 R1 R2))
26666.666677333335
(percent (par1 R1 R2))
0.0029999999992133654

(center (par2 R1 R2))
26666.666666666664
(percent (par2 R1 R2))
0.001000000000005912


the percent torlerences are different, since the manipulation of equation of intervals re-introduces new uncertainty. 
