baseMap = {}

baseMap.name = "User"

baseMap.timesGreeted = 1

baseMap.incrementTimesGreeted = function()
	self.timesGreeted += 1
end function

baseMap.greet = function()
	print "Hello, " + self.name + "! I've greeted you " + self.timesGreeted + " times!"
	self.incrementTimesGreeted
end function

baseMap.make = function(name)
	temp = new baseMap
	temp.name = name
	return temp
end function