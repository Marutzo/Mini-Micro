map1 = {}
map1.private = {}
map1.private.secret = 5
map1.private.getSecret = function()
	return self.secret
end function

map2 = new map1
map2.private = {}
map2.getSecret = function()
	return super.private.getSecret
end function

print "Map1: " + map1.private.getSecret
print "Map2: " + map2.private
print "Map2 Super: " + map2.getSecret