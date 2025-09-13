clear()

gfx.print "- Pig Latin Transformer -", 0, gfx.height - (32 + 5), color.aqua, "large"
gfx.print "Transform a string to Pig Latin:", 125, gfx.height - (14 * 4), color.aqua, "small"
text.row = 22
msg = input(">>> ").split(" ")
pigLatin = []
v = "aeiou"
p1 = "ay"
p2 = "way"

for i in range(msg.len - 1)
	c1 = msg[i][0]
	c2 = msg[i][1]
	
	if v.indexOf(c1) != null then
		pigLatin.insert 0, msg[i] + "way"
	else
		if v.indexOf(c2) != null then
			pigLatin.insert 0, msg[i][1:] + c1 + p1
		else
			pigLatin.insert 0, msg[i][2:] + c1 + p1
		end if
	end if
end for

print char(13) + ">>> " + pigLatin.join(" ")
text.column = 0
print " "