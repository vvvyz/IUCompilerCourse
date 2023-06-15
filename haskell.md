```haskell
--求列表的和
--total :: [Int] -> Int
--total [] = 0
--total (x:xs) = x + total xs
--这样会导致这个分配空间层层嵌套
--比如1, 2, 3, 4, 5

--使用$!强制对这个表达式进行求值
totalx :: [Int] -> Int -> Int
totalx [] n = n
totalx (x : xs) n = totalx xs $! (n + x) 

total :: [Int] -> Int
total xs = totalx xs 0
```
