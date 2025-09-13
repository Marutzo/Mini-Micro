myFunction = function(args)
	parsedArgs = {"help": false, "printText": "", "verbose": false} // Default values
	
	if args == null or args.len == 0 then
		return parsedArgs // Return defaults if no args provided
	end if
	// ... rest of the parsing logic ...
	
	
	
	
	
	// Assuming args is a single string like "-h -p \"hello world\""
	parts = args.split(" ")
	i = 0
	while i < parts.len
		part = parts[i]
		if part == "-h" or part == "--help" then
			parsedArgs.help = true
		else if part == "-v" or part == "--verbose" then
			parsedArgs.verbose = true
		else if part == "-p" then
			i = i + 1 // Move to the next part, which should be the value
			if i < parts.len then
				value = parts[i]
				// Handle quoted strings: remove leading/trailing quotes
				if value.startsWith("\") and value.endsWith("\") then
					value = value.substring(1, value.len - 2)
				end if
				parsedArgs.printText = value
			end if
		end if
		i = i + 1
	end while
	return parsedArgs
end function