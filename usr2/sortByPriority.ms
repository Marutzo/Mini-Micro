// Function to create a formatted string of a list
formatList = function(lst)
	str = "["
	for i in range(0, len(lst)-1)  // Loop through all except last
		str = str + "" + lst[i] + ", "
	end for
	if len(lst) > 0 then str = str + "" + lst[len(lst)-1]  // Last element without trailing comma
	return str + "]"
end function

// Function to pad a string with spaces to a fixed width
pad = function(str, width)
	while len(str) < width
		str = str + " "
	end while
	return str
end function

// Function to display the lists side by side
printSideBySide = function(original, sorted)
	colWidth = 18  // Adjust this for alignment
	
	print pad("Unsorted", colWidth) + " | " + pad("Sorted", colWidth)
	print "-" * (colWidth * 2 + 3)  // Separator line
	
	for i in range(0, len(original)-1)  // Ensure we don't go out of bounds
		origStr = formatList(original[i])
		sortStr = formatList(sorted[i])
		print pad(origStr, colWidth) + " | " + pad(sortStr, colWidth)
	end for
end function

// Insertion sort that maintains order of duplicate values
sortStable = function(listOfList)
	n = len(listOfList)
	for i in range(1, n-1)
		current = listOfList[i]
		j = i - 1
		
		// Move elements that should come after "current" one position ahead
		while j >= 0 and listOfList[j][0] < current[0]
			listOfList[j+1] = listOfList[j]
			j = j - 1
		end while
		
		// Place the current element at the correct position
		listOfList[j+1] = current
	end for
	return listOfList
end function

// Original list (copy to keep unchanged)
targets = [
[12, 5, 3], [7, 2, 9], [5, 6, 8], [13, 1, 4], 
[9, 7, 2], [5, 1, 5], [11, 4, 6], [8, 3, 1], 
[6, 8, 7], [5, 9, 3], [7, 2, 1], [10, 5, 2], 
[5, 6, 1], [13, 2, 1], [12, 5, 7], [9, 6, 5]]

// Sort without modifying original
targetsByPriority = sortStable(targets[:])

// Print side-by-side
printSideBySide(targets, targetsByPriority)