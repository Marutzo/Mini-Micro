clear
print "Welcome to BogoSort"
print ""

listLength = input("Please input list length (number of elements to sort): ").val
bogoList = []
elements = 0
while elements < listLength
	nextNumber = ceil(rnd * 1000)
	if bogoList.indexOf(nextNumber) == null then
		bogoList.insert -1, nextNumber
		elements = elements + 1
	else
		continue
	end if
end while

print "List contains " + listLength + " random elements."
print bogoList
print "Press any key to continue.. at your own peril!"
input

attempts = 1
sorted = false
while not sorted
	print attempts
	for i in range(0, listLength)
		if i < listLength - 1 then
			if bogoList[i] < bogoList[i + 1] then
				continue
			else
				attempts = attempts + 1
				bogoList.shuffle
				break
			end if
		else if i == listLength then
			if attempts >= 100 then
				print "Well, that took time.."
			else if attempts == 1 then
				print ""
				print "Wow! Really?? On the first try.."
			end if
			print ""
			print "Sorted in " + attempts + " attempts."
			sorted = true
			break
		end if
	end for
end while