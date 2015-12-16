(define (map f v1 v2)
    (if (and (null? v1) (null? v2))
        '()
        (cons (f (car v1) (car v2)) 
              (map f (cdr v1) (cdr v2)))))

;; > (map * (list 1 2 3) (list 4 5 6))
;; '(4 10 18)

(define (accumulate f initial sequence)
    (if (null? sequence)
        initial
        (f (car sequence)
           (accumulate f initial (cdr sequence)))))

(define (dot-product v w)
    (accumulate + 0 (map * v w)))

;; > (dot-product (list 1 2 3) (list 4 5 6))
;; 32
