#lang racket
(define (foldl fun initial sequence)
  (if (null? sequence)
      initial
      (foldl fun 
             (fun (car sequence) initial) 
             (cdr sequence))))

(define (reverse-left sequence)
  (foldl cons '() sequence))

;; (reverse-left '(1 2 3 4))
;; '(4 3 2 1)

(define (foldr fun initial sequence)
  (if (null? sequence)
      initial
      (fun (car sequence) (foldr fun initial (cdr sequence)))))

(define (reverse-right sequence)
  (foldr (lambda (x y) (append y (list x))) '() sequence))

;; (reverse-right '(1 2 3 4 5))
;; '(5 4 3 2 1)


;; foldl and foldr in Hashell
;; foldl (\acc x -> [x] ++ acc) []  [1,2,3,4,5]
;; [5,4,3,2,1]

;; foldr (\x acc -> acc ++ [x]) []  [1,2,3,4,5]
;; [5,4,3,2,1]
