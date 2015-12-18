(define make_counter 
    (lambda () 
      (let (( count 0))
       (lambda () 
         ((set! count (+ 1 count))
         count)))))
         
         
(define f (make_counter))
;; > f
;; #<procedure>
;; > (f)
;; 1
;; > (f)
;; 2
;; > (f)
;; 3
;; > (f)
;; 4
;; > (f)
;; 5
