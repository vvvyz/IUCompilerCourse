关于递归缓存的简单优化
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


常见操作符简单说明
```haskell
可以将一些二元函数用反单引号来转化成为参数中间的运算符号
比如 4 `div` 2 表示 div 4 2
```



常见list操作函数说明
```haskell
null 判断一个列表是否为空
length函数返回列表的长度
!! 获取列表中的元素
head 返回列表的第一个元素
last 返回列表的最后一个元素
init 将列表的第一个元素去掉
tail 将列表的最后一个元素去掉
map 会将函数映射到列表的每一个元素
filter 根据条件进行去除元素
zip 将两个元素进行打包

take : take 3 [1 ,2 ,3 ,4] 从列表中找到几个元素
splitAt : 在列表中使用这个进行分隔
repeat True : 在列表中重复无数次
replicate 3 True ：在列表中重复3次
```
