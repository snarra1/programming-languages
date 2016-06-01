--Commemnts beginning

max3 x y z | x>=y && x>=z =x
		| y>=z =y
		| otherwise =z

fact :: Integer -> Integer
fact x 	|x<0 =error"Negative value"
	|x==1 = 1
	|x>0 = x * fact(x-1)

iseven n = (n `mod` 2 == 0)

sqsum n m = sq n + sq m 
sq x = x * x
{-
 sq finds squares of numbers and sqsum evaluates their sum
-}
