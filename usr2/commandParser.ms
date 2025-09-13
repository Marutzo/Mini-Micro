parseCommand = function(commandString)
	// Initialize structures
	parsed = {}
	parsed.command = ""
	parsed.flags = []
	parsed.options = {}
	parsed.arguments = []
	
	// --- Tokenizer with single-quote handling ---
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
	
	// --- Parse command + optional subcommand ---
	parsed.command = tokens[0]
	startIndex = 1
	if tokens.len > 1 and not tokens[1].startsWith("-") then
		// treat as subcommand
		parsed.command = parsed.command + " " + tokens[1]
		startIndex = 2
	end if
	
	// --- Parse tokens ---
	i = startIndex
	while i < tokens.len
		token = tokens[i]
		
		if token.startsWith("--") then
			eqPos = token.indexOf("=")
			if eqPos != null then
				optionName = token[2:eqPos]
				optionValue = token[(eqPos+1):]
				parsed.options[optionName] = optionValue
			else if i+1 < tokens.len and not tokens[i+1].startsWith("-") then
				// handle --opt value
				optionName = token[2:]
				parsed.options[optionName] = tokens[i+1]
				i = i + 1 // consume value
			else
				// plain long flag
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

// Simple command
r1 = parseCommand("ls -l -a my_dir another_dir")
print "Command: " + r1.command
print "Flags: " + r1.flags
print "Options: " + r1.options
print "Arguments: " + r1.arguments
print "---"

// With --opt=value
r2 = parseCommand("grep -i --exclude=.log 'error' /var/log")
print "Command: " + r2.command
print "Flags: " + r2.flags
print "Options: " + r2.options
print "Arguments: " + r2.arguments
print "---"

// With --opt value
r3 = parseCommand("grep --exclude .log 'error'")
print "Command: " + r3.command
print "Flags: " + r3.flags
print "Options: " + r3.options
print "Arguments: " + r3.arguments
print "---"

// Subcommand handling
r4 = parseCommand("git commit --amend -m 'Initial commit'")
print "Command: " + r4.command
print "Flags: " + r4.flags
print "Options: " + r4.options
print "Arguments: " + r4.arguments
print "---"

// Another subcommand
r5 = parseCommand("docker run -it ubuntu bash")
print "Command: " + r5.command
print "Flags: " + r5.flags
print "Options: " + r5.options
print "Arguments: " + r5.arguments
print "---"