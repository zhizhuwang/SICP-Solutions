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
