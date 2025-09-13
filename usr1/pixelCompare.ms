clear
img = Image.create(128, 128, color.red)
gfx.drawImage img, 0, 0
img = Image.create(128, 128, color.blue)
gfx.drawImage img, 128, 0
img1 = gfx.getImage(0, 0, 64, 64)
img2 = gfx.getImage(192, 0, 64, 64)
gfx.drawImage img1, 480, 0
gfx.drawImage img2, 544, 0
different = false
while not different
	for i in range(img1.width - 1)
		if img1.pixel(i, 0) != img2.pixel(i, 0) then
			different = true
			break
		end if
	end for
	print("Finished checking")
	break
end while
if not different then
	print("Images are the same")
else
	print("Images are not the same")
end if
