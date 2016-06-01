{-
Q.5. Haskell function 'transpose lt' that transposes the row and column of lt (i.e. groups the 
ith element of the sub-lists together)
-}

transpose [[]] = []
transpose ([] : xs ) = transpose xs

	--transpose function
transpose ((x:xs):y ) =  (x : [a | (a:b) <- y]) : transpose (xs : [b| (a:b)<- y])

{-
Q.4. Haskell function 'delete_last x lt' to delete last occurrence of x 
-}
	--reverse the list
reverse1 [] = []
reverse1 (x:xs) = reverse1 (xs) ++ [x]

	--deletes the first occurrence of x
delete_first n [] = []
delete_first n (x:xs)
			|n==x = xs
			|otherwise = x : delete_first n xs

	--calls reverse and delete_first function
delete_last n (x) = reverse1(delete_first n (reverse1 (x)))  


{-
Q.3. Haskell function 'collect_leaf n bt' to collect all the leaves that are odd numbers in BT
-}

data Tree = Leaf Int| Node Tree Int Tree

	--selects leaves which are odd
collect_leaf (Leaf x)
		|x `mod` 2 == 1 = [x]
		|otherwise = []

	--ignores nodes values and parses through the leaves
collect_leaf (Node tr1 x tr2) = collect_leaf(tr1) ++ collect_leaf(tr2)

{-
Q.2. Haskell code for function 'delete k lt' to delete kth occurence in the list
-}

	--delete function calls delk to delete every kth element
delete k [] = []
delete k (x:xs) = delk k 1 (x:xs)

	--delk skips every kth element till no element is left in the list
delk k _ [] = []
delk k i (x:xs)
		|k==i = delk k 1 xs
		|otherwise = x:delk k (i+1) xs

{-
Q.1. Haskell function 'union lt1 lt2' to find union of 2 lists
The output does not repeat any elements from both the lists
-}

	--finds if element 'a' is member of list
member a [] = False
member a (x:xs) 
		|a==x = True
		|otherwise = member a xs

union [] [] = []

	--to check if 2nd list has repeated elements
union [] (y:ys) 
		|member y ys==True = union [] ys
		|otherwise = [y] ++ union [] ys

	--unifies list 1 with elements of list 2 without adding repeated elements
union (x:xs) ys
		| member x ys==True = union xs ys
		| otherwise = [x] ++ union xs ys
