(define (random-in-range low high)
    (let ((range (- high low)))
      (+ low (random range))))

(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
      (cond ((= trials-remaining 0)
             (/ trials-passed trials))
            ((experiment)
             (iter (- trials-remaining 1) (+ trials-passed 1)))
            (else
             (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))

(define (square x) (* x x))

(define (in-region-test x1 x2 y1 y2)
    (let ((center-x (/ (+ x1 x2) 2)))
      (let ((center-y (/ (+ y1 y2) 2)))
        (let ((r (/ (- x1 x2) 2)))
          (lambda ()
            (<= (+ (square (- (random-in-range x2 x1) center-x)) (square (- (random-in-range y2 y1) center-y))) (* r r)))
        ))))
> ((in-region-test 2 0 2 0) )
#t
> ((in-region-test 2 0 2 0) )
#t
> ((in-region-test 2 0 2 0) )
#f
> 


(define (estimate-integral P x1 x2 y1 y2 trials)
    (monte-carlo trials (P x1 x2 y1 y2)))
> (estimate-integral in-region-test 2 0 2 0 10)
4/5
> (estimate-integral in-region-test 2 0 2 0 100)
21/25
> (estimate-integral in-region-test 2 0 2 0 10000)
468/625
> (estimate-integral in-region-test 2 0 2 0 1000000)
46893/62500
> (estimate-integral in-region-test 2 0 2 0 10000000)
#e0.7501317


> (define pi (* 4 (estimate-integral in-region-test  10 0 10 0 100000) ))
> pi
#e3.15408