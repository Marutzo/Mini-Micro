while true
	clear
	display(5).drawRect(100, 365, 600, 180, color.red, 5)
	text.row = 21; text.column = 23; print "main menu"
	text.row = 18; text.column = 8; print "(1) new game"
	text.row = 18; text.column = 35; print "(2) load game"
	text.row = 15; text.column = 8; inp = input(">|:")
end while