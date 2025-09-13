conditionalPrint = function(args)
	parsedArgs = {}
	i = 0
	while i < args.len
		arg = args[i]
		if arg.startsWith("--") or arg.startsWith("-") then
			// This is a flag
			flagName = arg
			// Check if the next argument is a value or another flag
			if i + 1 < args.len and not (args[i+1].startsWith("--") or args[i+1].startsWith("-")) then
				// It's a value
				parsedArgs[flagName] = args[i+1]
				i = i + 1 // Skip the value as it's already processed
			else
				// It's a boolean flag (no explicit value)
				parsedArgs[flagName] = true
			end if
		else
			// This is a positional argument or an unflagged value
			// You might want to handle these differently, e.g., add to a list
			if not parsedArgs.hasIndex("positional") then
				parsedArgs.positional = []
			end if
			parsedArgs.positional.push(arg)
		end if
		i = i + 1
	end while
	return parsedArgs
end function