#lang racket

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x)
  (cadr x))

(define (weight-leaf x)
  (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree)
  (car tree))

(define (right-branch tree)
  (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch 
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))


;;; 2.67
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;;; > (decode sample-message sample-tree)
;;; '(A D A B B C A)

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (contains? x set)
  (cond ((null? set) #f)
        ((eq? x (car set)) #t)
        (else (contains? x (cdr set)))))

(define (encode-symbol symbol tree)
  (let ((left (left-branch tree))
        (right (right-branch tree)))
    (cond ((and (leaf? left) (eq? (symbol-leaf left) symbol)) '(0))
          ((and (leaf? right) (eq? (symbol-leaf right) symbol)) '(1))
          ((and (not (leaf? left)) (contains? symbol (symbols left))) (cons 0 (encode-symbol symbol left)))
          ((and (not (leaf? right)) (contains? symbol (symbols right))) (cons 1 (encode-symbol symbol right)))
          (else (error "error message")))))



;; > (encode '(A) sample-tree)
;; '(0)

;; > (encode '(B) sample-tree)
;; '(1 0)
;; > (encode '(C) sample-tree)
;; '(1 1 1)
;; > (encode '(D) sample-tree)
;; '(1 1 0)

;; > (encode '(E) sample-tree)
;; error message

;; > (encode '(A D A B B C A) sample-tree)
;; '(0 1 1 0 0 1 0 1 0 1 1 1 0)


(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge ordered-pairs)
   (cond ((= 0 (length ordered-pairs))
          '())
         ((= 1 (length ordered-pairs))
          (car ordered-pairs))
         (else
          (let ((new-sub-tree (make-code-tree (car ordered-pairs)
                                              (cadr ordered-pairs)))
                (remained-ordered-set (cddr ordered-pairs)))
            (successive-merge (adjoin-set new-sub-tree remained-ordered-set))))))




;; > (generate-huffman-tree (list (list 'C 1) (list 'D 1)))
;; '((leaf D 1) (leaf C 1) (D C) 2)
;; > (generate-huffman-tree (list (list 'A 4) (list 'B 2) (list 'C 1) (list 'D 1)))
;; '((leaf A 4)
;;  ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4)
;;  (A B D C)
;;  8)

;; > (make-leaf-set (list (list 'A 4) (list 'B 2) (list 'C 1) (list 'D 1)))
;; '((leaf D 1) (leaf C 1) (leaf B 2) (leaf A 4))




> (define (eight-symbols-tree)
    (generate-huffman-tree
     '((A 2) (BOOM 1) (GET 2) (JOB 2) (NA 16) (SHA 3) (YIP 9) (WAH 1))))

> eight-symbols-tree
'((leaf NA 16)
  ((leaf YIP 9)
   (((leaf A 2)
     ((leaf WAH 1) (leaf BOOM 1) (WAH BOOM) 2)
     (A WAH BOOM)
     4)
    ((leaf SHA 3)
     ((leaf JOB 2) (leaf GET 2) (JOB GET) 4)
     (SHA JOB GET)
     7)
    (A WAH BOOM SHA JOB GET)
    11)
   (YIP A WAH BOOM SHA JOB GET)
   20)
  (NA YIP A WAH BOOM SHA JOB GET)
  36)



> (encode '(GET A JOB) eight-symbols-tree )
'(1 1 1 1 1 1 1 0 0 1 1 1 1 0)




