clear
buffer = []
print "All pressed keys will be saved and printed"
print "... Including typos!"
wait 3
while true
	if key.available then
		buffer.push key.get
		wait 0.1
	else
		print
		print "All available keys handled"
		print "Press LEFT CTRL to exit"
		while not key.pressed("left ctrl"); end while
		break
	end if
end while
print char(10) + "Key buffer = " + buffer.join("")
key.clear