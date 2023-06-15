#lang racket

(define empty '())

(struct Closure
    (param body env) 
    #:transparent)

(define extend
  (lambda (env var value)
    (cons `(var . value) env)))

(define lookup
  (lambda (var env)
    (cdr (assoc var env))))

(define getop
  (lambda (name)
    (match name
      ('+ +)
      ('- -)
      ('* *)
      ('/ /)
      ('< <)
      ('> >)
      ('+ +))))

(define literal?
  (lambda (value)
    (or (number? value)
        (string? value))))

(define interp
    (lambda (expr env)
        (match expr
            ([? literal? x] x)
            ([? symbol? var] (lookup var env))
            (`(lambda (,x) ,body) (Closure x body env))
            (`(,op ,x ,y) ((getop op) (interp x env) (interp y env)))
            (`(if ,a ,b ,c) 
                (if (interp a env)
                    (interp b env)
                    (interp c env))))))

(interp '3222 '())
(interp 'x '((x . 1)))
(interp '(+ x 1) '((x . 1)))
(interp '(- x 1) '((x . 2)))
(interp '(* x 1) '((x . 2)))
(interp '(/ x 1) '((x . 2)))
(interp '(lambda (x) (+ x 1)) '((x . 1)))
(interp '(lambda (x) (+ x 1)) '())
(interp '(if (> 3 2) 3 2) empty)
