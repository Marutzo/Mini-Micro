clear
targetFile = "/usr2/users.txt"
reader = file.open(targetFile, "r")
print "Reading: " + targetFile
lineNum = 1
while not reader.atEnd
	print "Line " + lineNum + ": " + reader.readLine
	lineNum = lineNum + 1
end while