clear
while true
	input
	var = ""
	for i in range(0, 67)
		var = var + text.cell(i, text.row + 1)
	end for
	print var
end while