min = function(a,b)
	if b.len < a.len then return b else return a
end function

print min([1,2,3,4],[5,6,7])