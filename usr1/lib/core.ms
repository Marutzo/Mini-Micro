// String Utilities.
//	This module adds some additional methods to the `string` type.

// contains: return true if this string contains the given substring anywhere.
string.contains = function(self, whatToCheckFor)
	for i in whatToCheckFor
		if self.indexOf(i) != null then
			return true
		end if
	end for
	return false
end function