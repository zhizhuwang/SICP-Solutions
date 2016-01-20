  
(define (triangle n k)
    (cond ((and (= n 0) (= k 0)) 1)
          ((= k 0) 1)
          ((< n k) 0)
          (else (+ (triangle (- n 1) (- k 1)) (triangle (- n 1) k)))
          )
    )
