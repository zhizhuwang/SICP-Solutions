#lang racket

(define (unique-pairs n)
  (flatmap (lambda (i) 
             (map 
              (lambda (j) (list j i)) 
              (enumerate 1 (- i 1)))) 
           (enumerate 1 n)))


(define (enumerate low high)
  (if (> low high)
      '()
      (cons low (enumerate (+ low 1) high))))

(define (flatmap fun sequence)
  (if (null? sequence)
      '()
      (append (fun (car sequence)) 
              (flatmap fun (cdr sequence)))))

(define (sum li)
  (if (null? li)
      0
      (+ (car li) (sum (cdr li)))))

(define (unique-triples n s)
  (filter 
   (lambda (triple) (= (sum triple) s))
   (flatmap (lambda (pair)
             (map 
              (lambda (k) (cons k pair)) 
              (enumerate 1 (- (car pair) 1))))
            (unique-pairs n))))


;; > (unique-triples 10 20                  )
;; '((5 7 8) (5 6 9) (4 7 9) (3 8 9) (4 6 10) (3 7 10) (2 8 10) (1 9 10))

;; > (unique-triples 10 25)
;; '((7 8 10) (6 9 10))


(define (fold-right fun initial sequence)
  (if (null? sequence)
      initial
      (fun (car sequence) (fold-right fun initial (cdr sequence)))))

(define (sum-of-triple-equals-to? triple s)
  (= (fold-right + 0 triple) s))

(define (unique-triples2 n s)
  (filter 
   (lambda (t) (sum-of-triple-equals-to? t s))
   (flatmap
    (lambda (pair) 
      (map (lambda (k) (cons k pair)) (enumerate 1 (- (car pair) 1))))
    
    
;; > (unique-triples2 10 25)
;; '((7 8 10) (6 9 10))
    (unique-pairs n))))