while true
	// pprint key.keyNames, invaluable
	if key.pressed("left ctrl") then
		// [number] is numpad
		if key.pressed([5]) then
			// bell without newline
			print char(7), ""
			// alternatively
			// print char(7)
			// text.row += 1
			wait
		else if key.pressed(5) then
			print "5?! You're suppsed to press numpad 5!"
			wait
		end if
	end if
end while