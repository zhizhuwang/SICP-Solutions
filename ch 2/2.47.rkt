#lang racket
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frm)
  (car frm))
(define (edge1-frame frm)
  (cadr frm))
(define (edge2-frame frm)
  (caddr frm))

(define (make-frame2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame2 frm)
  (car frm))
(define (edge1-frame2 frm)
  (car (cdr frm)))
(define (edge2-frame2 frm)
  (cdr (cdr frm)))

