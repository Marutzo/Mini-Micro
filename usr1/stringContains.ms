import "stringUtil"
contains = function(string, array)
	result = 0
	for i in array
		if string.contains(i) then
			result = 1
		end if
	end for
	return result
end function
myStr = "abc"
print(contains(myStr, "ace"))