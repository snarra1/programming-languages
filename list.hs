

--append (xs) (ys) = (xs) ++ (ys)
append [] ys = ys
append (x:xs) ys = x: append xs ys

member a [] = False
member a (b:xs)	| a==b = True
		|otherwise = member a xs

rev[] = []
rev (x:ss) = rev ss ++ [x]

len (x:xs) = 1 + len xs
len[] = 0

add[] = 0
add (x:xs) = x + add xs
