#lang racket

(define ext-env
  (lambda (name value env)
    (cons (cons name value) env)))

(define ext-env*
  (lambda (names values env)
    (cond
      [(and (null? names) (null? values))
       env]
      [(and (pair? names) (pair? values))
       (ext-env*
        (cdr names)
        (cdr values)
        (ext-env (car names) (car values) env))]
      [else
       (error "number of names and values don't match")])))

(define env0
  `((+ . ,+)
    (- . ,-)
    (* . ,*)
    (/ . ,/)))

;; -------- type checker --------

(define type-env0
  `((+ . (-> int int int))
    (- . (-> int int int))
    (* . (-> int int int))
    (/ . (-> int int int))))

(define typecheck1
  (lambda (exp env)
    (match exp
      [(? number? exp)
       'int]
      [(? boolean? exp)
       'bool]
      [(? symbol? exp)
       (let ([p (assq exp env)])
         (cond
           [(not p)
            (error "Unbound variable: " exp)]
           [else
            (cdr p)]))]
      [`(fun ([: ,params ,in-types] ... [-> ,out-type])
          ,body)
       (let* ([env1 (ext-env* params in-types env)]
              [actual (typecheck1 body env1)])
         (cond
           [(equal? actual out-type)
            `(-> ,@in-types ,out-type)]
           [else
            (error "expected output type: " out-type ", but got: " actual)]))]
      [`(,op ,args ...)
       (let ([op-type (typecheck1 op env)]
             [arg-types (map (lambda (a) (typecheck1 a env)) args)])
         (match op-type
           [`(-> ,in-types ... ,out-type)
            (cond
              [(equal? arg-types in-types)
               out-type]
              [else
               (error "expected input type: " in-types ", but got: " arg-types)])]
           [_
            (error "Calling non-function: " op)]))])))

(define typecheck
  (lambda (exp)
    (typecheck1 exp type-env0)))


(typecheck 2)
(typecheck #f)

(typecheck '(fun ([: a int] [-> int]) (+ a 1)))
(typecheck '(fun ([: b int] [-> int]) (* b 2)))
