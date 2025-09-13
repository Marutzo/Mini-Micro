clear

letters = "abcdefghijklmnopqrstuvwxyz"

enteredValue = false
while not enteredValue
	error = false
	x = input("Enter an integer (whole number, no decimals): ").lower
	
	if x.indexOf(".") then
		print char(13) + stackTrace
		print "Float detected, trying again.." +
		char(7) + char(13)
		error = true
		continue
	end if
	
	for i in letters.split("")
		if x.split("").indexOf(i) != null then
			print char(13) + stackTrace
			print "Letter detected, trying again.." +
			char(7) + char(13)
			error = true
			break
		end if
		continue
	end for
	
	if error then
		continue
	else
		enteredValue = true
	end if
	
end while

print char(13) + "Accepted user input: " + x