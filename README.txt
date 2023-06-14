the first commit

(define add
 (fun ([:a Int] [–> (Int –> Int)]))
  (fun (b) 
   (+ a b)))
   
(define add
 (fun ([:a Int 2] [–> Int]))
  (fun (b) 
   (+ a b)) 1)

(record A
 (:a Int 2))
 
 ------------parameter------------
 ------------subtype--------------
 (typename (:T Show))
 (define add
  (fun ([:a T] [-> Void])
   (print a)))
