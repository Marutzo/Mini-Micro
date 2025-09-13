random = {}

random.getInt = function(pow=2)
	return floor(rnd * pow)
end function

random.getClampedInt = function(pow=2, minval=0, maxval=1)
	// Argument Type Check handling
	// Converting if possible
	args = {}
	args.pow = pow
	args.minval = minval
	args.maxval = maxval
	
	for i in args
		if i.value isa string then
			if i.value.val then
				args[i.key] = i.value.val
			else
				print "String argument must be in the form of a number"
				return null
			end if
		else if i.value isa number then
			continue
		else
			print "Args must be of type string or number"
			return null
		end if
	end for
	
	// Argument Type Checking done
	
	pow = args.pow
	minval = args.minval
	maxval = args.maxval
	
	// Argument Value Control
	
	if pow < 0 or minval < 0 or maxval < 0 then
		print "Args must be positive"
		return null
	end if
	
	if minval > maxval or maxval < minval then
		print "Minval must be less than maxval"
		print "Maxval must be greater than minval"
		return null
	end if
	
	// Error handling done
	
	x = random.getInt(pow)
	if x < minval then return minval
	if x > maxval then return maxval
	return x
end function