#lang racket

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ 1 low) high))))
(define (flatmap proc seqs)
  (accumulate append '() (map proc seqs)))
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) 
          (accumulate op initial (cdr sequence)))))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (adjoin-position row col rest)
  (cons row rest))
  
(define empty-board (list ))

(define (safe-row? row col i poss)
  (cond ((= i col) #t)
        ((or (= row (car poss))
             (= row (+ (car poss) i))
             (= row (- (car poss) i))
             ) #f)
         (else (safe-row? row col (+ i 1) (cdr poss)))
         ))

(define (safe? col positions)
  (let ((new-row (car positions))
        (i 1))
         (safe-row? new-row col i (cdr positions))
         ))

