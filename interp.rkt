#lang racket

(define empty '())

(struct Closure
    (param body env) 
    #:transparent)

(define interp
    (lambda (expr env)
        (macth expr
            ([? literal? x] x)
            ([? symbol? var] (lookup var))
            ([`(lambda (,x) ,body)] (Closure x body))
            ([`(,op ,x ,y)] ((getop op) (interp a env) (interp b env)))
            ([`(if ,a ,b ,c)] 
                (if (interp a env)
                    (interp b env)
                    (interp c env))))))

(interp '3222 '())
(interp 'x '((x . 1)))
(interp '(lambda (x) (+ x 1)) '((x . 1)))
(interp '((lambda (x) (+ x 1)) 10) empty)
(interp '(if (> 3 2) 3 2) empty)

