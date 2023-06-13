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
