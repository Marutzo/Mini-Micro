gfx.clear

d = function(x, y, c = "orange")
	gfx.setPixel x, y, color[c]
end function

y = "yellow"

d 10, 9, y
d 10, 22, y
d 15, 10
d 16, 10
d 17, 10
d 18, 9, y
d 18, 22, y

d 15, 11

d 15, 12
d 16, 12
d 17, 12

d 11, 13
d 17, 13

d 12, 14
d 15, 14
d 16, 14
d 17, 14

d 13, 15

d 14, 16

d 12, 17
d 15, 17

d 12, 18
d 16, 18

d 12, 19
d 12, 20
d 12, 21