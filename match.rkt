#lang racket

(define (match-fun expr)
  (match expr
    [`(fun ([: ,parms ,ity] ... [-> ,oty])) ity]
    [else #f]))

(displayln (match-fun '(fun ([: a Int] [: b Int] [-> Int])))) ; 输出 #t
(displayln (match-fun '(fun ([: b String] [-> Int])))) ; 输出 #t
