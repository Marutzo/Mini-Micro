import "listUtil"
import "stringUtil"

clear
promptColor = color.orange
text.color = promptColor

// Read words, and filter to 5-letter words
words = file.readLines("/sys/data/englishWords.txt")
words.filter function(w); return w.len == 5; end function

// Prepare alphabet and initial colors
alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
alphaColor = {}
for letter in alphabet
	alphaColor[letter] = color.silver
end for

// Function to print a letter (or many letters) in the correct color
printInColor = function(letters, delimiter = " ")
	text.delimiter = delimiter
	for letter in letters
		text.color = alphaColor[letter]
		print letter
	end for
	text.delimiter = char(13)
	text.color = promptColor
end function

// Pick a word
word = words.any.upper

// Main loop
guesses = 1
while true
	printInColor alphabet
	print
	inp = input("Guess #" + guesses + "? ").lower
	if not words.contains(inp) then
		print "Invalid word."
		continue
	end if
	inp = inp.upper
	text.delimiter = ""
	print "Result:   "
	for i in word.indexes
		if inp[i] == word[i] then
			alphaColor[inp[i]] = color.green
		else if word.contains(inp[i]) then
			alphaColor[inp[i]] = color.yellow
		else
			alphaColor[inp[i]] = color.gray
		end if
		printInColor inp[i], ""
	end for
	print
	if inp == word then
		print "You got it in " + guesses + " guesses!"
		break
	else if guesses == 5 then
		print "Too bad! The word was: " + word
		break
	end if
	guesses = guesses + 1
end while

print
_printMark "(Enter `run` to try again.)"