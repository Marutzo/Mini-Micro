clear

import "listUtil"
import "mapUtil"

ordinal_string = function(n)
	if [11,12,13].contains(n % 100) then
		suffix = "th"
	else
		suffix = {1: "st", 2: "nd", 3: "rd"}.get(n % 10, "th")
	end if
	
	ordinal = n + suffix
	if ordinal != "0th" then
		return ordinal
	else
		return "Unranked"
	end if
end function

print "This is a simple ordinal number converter."
print "It takes a number and appends a suffix to it."
print
print "Simply put if the last digit of a number is not preceded by a 1 ie. '11'/'12'/'13' it then gets the 'st'/'nd'/'rd' suffix respectively for 1st, 2nd, 3rd. In all other cases it gets 'th'."
print

validInput = 0
while not validInput
	userString = input(">>> Enter a number: ")
	if userString.val or userString == char(48) then
		validInput = 1
		print "Thank you."
		print
	else
		print "Numbers only please."
		print "Decimals are removed by script."
		print
		continue
	end if
end while

ranking = ordinal_string(abs(floor(userString.val)))

option = ""
if ranking != "Unranked" then
	option = " place"
else
	option = ""
end if

print "Your number would appear as " + ranking + option + " on a leaderboard."