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

使用haskell实现二分查找

search :: (Ord a) => a -> [a] -> Bool
search a [] = False
search a xs | m < a = search a behind
            | m > a = search a front
            | otherwise = True
            where (front, m : behind) = splitAt (length xs `div` 2) xs

--函数作为值返回
(|>) :: b -> (b -> c) -> c
(|>) = fiip($)
```


常见操作符简单说明
```haskell
可以将一些二元函数用反单引号来转化成为参数中间的运算符号
比如 4 `div` 2 表示 div 4 2
运算符可能有三种属性, 分别是优先级, 结合性和位置
```

定义下一个数据结构
```haskell
data Bool = False 
        | True
    deriving(Show, Eq, Ord, Enum)

--通过这个类型你就可以实现一些东西
    
data Day = Mon | Tue | Wed | Thu | Fri | Sat | Sun
    deriving(Show, Eq, Ord, Enum)

--使用模式匹配
tomorrow :: Day -> Day
tomorrow Mon = Tue
tomorrow Tue = Wed
tomorrow Wed = Thu
tomorrow Thu = Fri
tomorrow Fri = Sat
tomorrow Sat = Sun
tomorrow Sun = Mon

--实现了枚举类型类Enum后, 有很多函数可以立即使用
--比如使用succ, pred以及其他的函数
tom :: Day -> Day
tom Sun = Mon
tom d = succ d


yes :: Day -> Day
yes Mon = Sun
yes d = pred d

--还有一个函数叫做read, 比如read "Mon"::Day
data () = ()

--定义一种类型作为参数
type Name = String
type Author = String
type ISBN = String
type Price = Float

data Book = Book Name Author ISBN Price deriving(Show, Eq)

--这样就需要使用一些访问器去访问, 就像这样
name (Book n _ _ _) = n
author (Book _ a _ _) = a
```

定义一下数据结构并优化访问器
```haskell
--访问器被称之为字段
data Book = Book
    { name   :: Name
    , author :: Author
    , isbn   :: ISBN
    , price  :: Price
    }


incrisePrice :: ([Book], [Book]) -> Book -> Float -> ([Book], [Book])
incrisePrice (b1, b2) b pri = 
    ((b : b1), Book (name b) (author b) (isbn b) (price b + pri))

--使用下面这种定义, 进行模式匹配
incrisePrice (b1 b2) (Book nm ath isbn prc) pri =
    ((Book nm ath isbn prc) : b1, 
     (Book nm ath isbn (prc + pri)) : b2)

--这个东西就和临时变量的作用是相同的
incrisePrice (b1 b2) b@(Book nm ath isbn prc) pri =
    (b : b1, (Book nm ath isbn (prc + pri)) : b2)
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


关于Y不动点的讨论
在正统的Lambda演算中函数全部是没有名字的, 因此是无法通过递归函数去实现的
```haskell
fib x | x > 0  =  x * fib(n - 1)
      | x == 0 =  1
```

