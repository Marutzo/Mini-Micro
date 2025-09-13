text.delimiter = ""

alignRight = function(message)
	text.column = 67 - message.len + 1
	print message
end function

alignCenter = function(message)
	text.column = (67 - message.len) / 2
	print message
end function

text.inverse = true
print "                           "
str = " five plus five equals tent"
print char(13) + str + char(8) + char(3) + char(13)
print "                           "
text.inverse = false