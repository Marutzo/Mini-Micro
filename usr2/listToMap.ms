clear

listA = ["a", "b", "c", "d", "e", "f", "g", "h"]
listB = [1, 2, 3, 4, 5, 6, 7, 8]

print "listA " + listA
print "listB " + listB
print
print "Combining lists into map:"

if listA.len == listB.len then
	myMap = {}
	for i in range(0, listA.len - 1)
		myMap[listA[i]] = listB[i]
	end for
else
	// TODO: Handle assymetric lists by inserting
	// dummy elements?
	print "Lists must be of same length!"
end if

print "myMap " + myMap
print
print "Randomizing order:"

shumap = myMap.indexes
shumap.shuffle

for i in range(0, shumap.len - 1)
	print shumap[i] + " : " + myMap[shumap[i]]
end for

print

temp = {}
for i in range(0, shumap.len - 1)
	temp[shumap[i]] = myMap[shumap[i]]
end for
myMap = temp

print "Original map changed:"
print "myMap " + myMap

// Cleanup
cleanup = ["listA", "listB", "shumap", "temp"]
for i in cleanup
	outer.remove(i)
end for