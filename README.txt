-------some-----------------------
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
 (define showName
  (fun ([:s T] [-> Void])
   (print a)))
 
 
 (showName :s 1)
 (showName :s 5.67)
 (showName :s "hello, World")
 
 -----------------------------
 (typename (:T Any))
 (define self
  (fun ([:x T] [-> T])
   a))
 
 (add :x 2)
 (add :x "hello")
 (add :x "ccc")
 (add :x (fun ([:x Int] [=> Int]) x))
