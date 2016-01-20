#lang racket
(define (make-leaf symbol weight)
    (list 'leaf symbol weight))

(define (leaf? object)
    (eq? (car object) 'leaf))

(define (symbol-leaf x)
    (cadr x))

(define (weight-leaf x)
    (caddr x))

;; tree

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
    (cond ((= bit 0)
            (left-branch branch))
          ((= bit 1)
            (right-branch branch))
          (else
            (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (encode-symbol symbol tree)
    (cond ((leaf? tree)                                         ; 如果已经到达叶子节点，那么停止积累
            '())
          ((symbol-in-tree? symbol (left-branch tree))          ; 符号在左分支(左子树)，组合起 0 
            (cons 0
                  (encode-symbol symbol (left-branch tree))))
          ((symbol-in-tree? symbol (right-branch tree))         ; 符号在右分支(右子树)，组合起 1
            (cons 1
                  (encode-symbol symbol (right-branch tree))))
          (else                                                 ; 给定符号不存在于树，报错
            (error "This symbol not in tree: " symbol))))

(define (symbol-in-tree? given-symbol tree)
    (not 
        (false?
            (findf (lambda (s)                   ; 使用 find 函数，在树的所有符号中寻找给定符号
                      (eq? s given-symbol))
                  (symbols tree))))) 

(define (encode message tree)
    (if (null? message)
        '()
        (append (encode-symbol (car message) tree)
                (encode (cdr message) tree))))


> (define sample-tree
        (make-code-tree (make-leaf 'A 4)
                        (make-code-tree
                            (make-leaf 'B 2)
                            (make-code-tree (make-leaf 'D 1)
                                            (make-leaf 'C 1)))))
>  (encode (list 'A 'D 'A 'B 'B 'C 'A) sample-tree)
;;'(0 1 1 0 0 1 0 1 0 1 1 1 0)                



(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))

(define (successive-merge ordered-set)
    (cond ((= 0 (length ordered-set))
            '())
          ((= 1 (length ordered-set))
            (car ordered-set))
          (else
            (let ((new-sub-tree (make-code-tree (car ordered-set)
                                                (cadr ordered-set)))
                  (remained-ordered-set (cddr ordered-set)))
                (successive-merge (adjoin-set new-sub-tree remained-ordered-set))))))

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

> (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1)))
;; ((leaf a 4) ((leaf b 2) ((leaf d 1) (leaf c 1) (d c) 2) (b d c) 4) (a b d c) 8)


(define tree (generate-huffman-tree '((A 1) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1))))

(encode '(GET A  JOB) tree)
;;'(1 1 0 0 1 1 1 1 0 1 1 1 1 1)

