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

(define (map-single f s)
         (if (null? s)
             '()
             (cons (f (car s)) 
                   (map-single f (cdr s)))))

(define (matrix-*-vector m v)
    (map-single (lambda (sub-vec) (dot-product sub-vec v)) m))

(define m (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))

;; > (matrix-*-vector m (list 1 1 1 1))
;; '(10 21 30)
