#lang racket
(define (unique-pair n)
  (flatmap
   (lambda (i) 
     (map 
      (lambda (j) (list j i)) 
      (enumerate 1 (- i 1))))
   (enumerate 2 n)))

(define (enumerate low high)
  (if (> low high)
      '()
      (cons low (enumerate (+ low 1) high))))

(define (map fun sequence)
  (if (null? sequence)
      '()
      (cons (fun (car sequence)) 
            (map fun (cdr sequence)))))

(define (flatmap fun sequence)
  (if (null? sequence)
      '()
      (append (fun (car sequence)) 
              (flatmap fun (cdr sequence)))))


;; > (unique-pair 4)
;; '((1 2) (1 3) (2 3) (1 4) (2 4) (3 4))

(define (square x) (* x x))
(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divided? n test-divisor) test-divisor)
          (else (find-divisor n (next test-divisor)))
          )
    )
(define (next test-divisor)
    (if (= 2 test-divisor) 3
        (+ 2 test-divisor)
        )
    )
(define (divided? n divisor) 
     (= 0 (remainder n divisor)))

(define (prime? n)
     (= n (smallest-divisor n))
     )
(define (smallest-divisor n)
    (find-divisor n 2)
  )

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))



(define (prime-sum-pairs n)
  (map make-pair-sum 
       (filter prime-sum? 
               (flatmap
                (lambda (i) 
                  (map 
                   (lambda (j) (list j i)) 
                   (enumerate 1 (- i 1)))) 
                (enumerate 2 n)))))


;; >(prime-sum-pairs 4)
;; '((1 2 3) (2 3 5) (1 4 5) (3 4 7)) 


;;use unique-pair simplify
(define (prime-sum-pairs2 n)
  (map make-pair-sum 
       (filter prime-sum? 
               (unique-pair n))))

