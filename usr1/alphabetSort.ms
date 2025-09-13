wordLen = 5
wordSwap = ""

word1 = "ac"
word2 = "ab"

print "sorting '" + word1 + ", " + word2 + "' alphabetically"

for i in range(0, wordLen - 1)
	if word1[i] > word2[i] then
		print "swapping '" + word1 + "' with '" + word2 + "'"
		wordSwap = word1
		word1 = word2
		word2 = wordSwap
		print "new order is now '" + word1 + ", " + word2 + "'"
		break
	end if
end for