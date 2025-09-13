myFunction = function(argsString)
	defaultArgs = [["start",10],["stop",1],["mode","down"]]
	
	// Start with a copy of default arguments
	parsedArgs = defaultArgs.deepCopy // Use deepCopy to avoid modifying the original defaultArgs table
	
	// Handle no arguments case
	if not argsString or argsString.trim == "" then
		print "No arguments provided. Using default values."
		return parsedArgs
	end if
	
	// Split the arguments string into individual tokens
	// This simple split might not handle quoted strings with spaces well.
	// For more robust parsing, you might need a custom tokenizer.
	argTokens = argsString.split(" ") 
	
	i = 0
	while i < argTokens.len
		token = argTokens[i]
		
		// Check for flags
		if token.startsWith("--") then // Long flags, e.g., --verbose, --output=file.txt
			flagName = token[2:] // Remove "--"
			
			// Check for value attached with '='
			if flagName.contains("=") then
				parts = flagName.split("=")
				flagName = parts[0]
				value = parts[1]
				parsedArgs[flagName] = value
			else // Boolean flag or flag with value in next token
				// Check if it's a known boolean flag
				if defaultArgs.hasIndex(flagName) and typeof(defaultArgs[flagName]) == "boolean" then
					parsedArgs[flagName] = true
				else // Assume value is in the next token
					if i + 1 < argTokens.len and not argTokens[i+1].startsWith("-") then
						parsedArgs[flagName] = argTokens[i+1]
						i = i + 1 // Consume the next token
					else
						// Flag without an expected value, or value is another flag
						// You might want to set it to true or handle as an error
						parsedArgs[flagName] = true 
					end if
				end if
			end if
		else if token.startsWith("-") then // Short flags, e.g., -v, -o file.txt
			flagName = token[1:] // Remove "-"
			
			// For simplicity, assume short flags are either boolean or take next token as value
			if defaultArgs.hasIndex(flagName) and typeof(defaultArgs[flagName]) == "boolean" then
				parsedArgs[flagName] = true
			else // Assume value is in the next token
				if i + 1 < argTokens.len and not argTokens[i+1].startsWith("-") then
					parsedArgs[flagName] = argTokens[i+1]
					i = i + 1 // Consume the next token
				else
					// Handle short flag without expected value
					parsedArgs[flagName] = true 
				end if
			end if
		else // Positional argument (e.g., input file names)
			// Assuming 'inputFiles' is an array for positional arguments
			if parsedArgs.hasIndex("inputFiles") and typeof(parsedArgs.inputFiles) == "list" then
				parsedArgs.inputFiles.push(token)
			else
				print "Warning: Unrecognized positional argument: " + token
			end if
		end if
		
		i = i + 1
	end while
	
	// Add in any missing args that are necessary (already handled by starting with defaultArgs)
	// You might want to add validation here to ensure all *required* arguments are present.
	
	return parsedArgs
end function