(define (f n)
    (if (< n 3) n
    (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))


(define (f2 n) (f_iter 0 1 2 n))

(define (f_iter f0 f1 f2 n) 
    (cond ((< n 3) f2)
    (else (f_iter f1 f2 (+ (+ f2 (* 2 f1)) (* 3 f0)) (- n 1)))
    )
  )

