parseCommand = function(commandString)
	// Initialize structures
	parsed = {}
	parsed.command = ""
	parsed.flags = []
	parsed.options = {}
	parsed.arguments = []
	
	// --- Tokenizer with quote handling (single quotes only) ---
	tokens = []
	current = ""
	inQuote = false
	
	for c in commandString
		if inQuote then
			if c == "'" then
				inQuote = false // close quote
			else
				current = current + c
			end if
		else
			if c == "'" then
				inQuote = true
			else if c == " " then
				if current != "" then
					tokens.push current
					current = ""
				end if
			else
				current = current + c
			end if
		end if
	end for
	if current != "" then tokens.push current
	
	if tokens.len == 0 then return parsed
	
	// --- Parse tokens ---
	parsed.command = tokens[0]
	i = 1
	while i < tokens.len
		token = tokens[i]
		
		if token.startsWith("--") then
			eqPos = token.indexOf("=")
			if eqPos != null then
				optionName = token[2:eqPos]
				optionValue = token[(eqPos+1):]
				parsed.options[optionName] = optionValue
			else
				parsed.flags.push(token[2:])
			end if
			
		else if token.startsWith("-") and token.len > 1 then
			// Short flags/options
			for j in range(1, token.len-1)
				flagOrOpt = token[j:j+1]
				if j == token.len-1 and i+1 < tokens.len and not tokens[i+1].startsWith("-") then
					parsed.options[flagOrOpt] = tokens[i+1]
					i = i + 1 // consume value
				else
					parsed.flags.push(flagOrOpt)
				end if
			end for
			
		else
			parsed.arguments.push(token)
		end if
		
		i = i + 1
	end while
	
	return parsed
end function

// --- Test Cases ---

result1 = parseCommand("ls -l -a my_dir another_dir")
print "Command: " + result1.command
print "Flags: " + result1.flags
print "Options: " + result1.options
print "Arguments: " + result1.arguments
print "---"

result2 = parseCommand("grep -i -r --exclude=.log 'error' /var/log")
print "Command: " + result2.command
print "Flags: " + result2.flags
print "Options: " + result2.options
print "Arguments: " + result2.arguments
print "---"

result3 = parseCommand("git commit --amend -m 'Initial commit'")
print "Command: " + result3.command
print "Flags: " + result3.flags
print "Options: " + result3.options
print "Arguments: " + result3.arguments
print "---"
