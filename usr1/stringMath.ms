string.math = function(self)
	firstNumber = val(self[:self.indexOf("=") - 2])
	secondNumber = val(self[self.indexOf("=") + 2:])
	if self[self.indexOf("=") - 1] == "^" then
		result = firstNumber ^ secondNumber
	else if self[self.indexOf("=") - 1] == "*" then
		result = firstNumber * secondNumber
	else if self[self.indexOf("=") - 1] == "/" then
		result = firstNumber / secondNumber
	else if self[self.indexOf("=") - 1] == "+" then
		result = firstNumber + secondNumber
	else if self[self.indexOf("=") - 1] == "-" then
		result = firstNumber - secondNumber
	else
		print "Error in stringMath"
	end if
	return result
end function