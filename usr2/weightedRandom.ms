clear
weightedRandom = function(chanceMap)
	choice = null
	for i in range(0, chanceMap.len - 1)
		if chanceMap.values[i] <= rnd then
			choice = chanceMap.indexes[i]
			break
		end if
	end for
	if choice != null then
		return choice
	else
		return "Bad luck"
	end if
end function

choicesAndWeights = {
"A": 0.50,
"B": 0.25,
"C": 0.25,
}
for i in range(1, 25)
	print weightedRandom(choicesAndWeights)
end for