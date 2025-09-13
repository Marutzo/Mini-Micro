dice = {
"d4" : range(1, 4),
"d6" : range(1, 6),
"d8" : range(1, 8),
"d12" : range(1, 12),
"d20" : range(1, 20)}

throw = function(dice, throws = 1)
	result = []
	for t in range(throws - 1)
		shuffle(dice)
		result.push(dice[rnd * dice.len])
	end for
	// print(result + " Dice : Sum [" + sum(result) + "]")
	return result
end function

attempts = 0
while throw(dice.d6, 6) != [1, 2, 3, 4, 5, 6]
	throw(dice.d6, 6)
	attempts = attempts + 1
end while
print "It took " + attempts + " attempts to get 1 through 6 in a row!"