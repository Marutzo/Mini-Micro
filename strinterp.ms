// ---------------------------
// Helper: isNumericString
// ---------------------------
isNumericString = function(s)
	if s == "" then
		return false
	end if
	i = 0
	ch = s[i:i+1]
	if ch == "-" then
		i = i + 1
	end if
	dotCount = 0
	while i < len(s)
		ch = s[i:i+1]
		if ch == "." then
			dotCount = dotCount + 1
			if dotCount > 1 then
				return false
			end if
		else
			if "0123456789".contains(ch) == false then
				return false
			end if
		end if
		i = i + 1
	end while
	return true
end function

// ---------------------------
// Safe variable resolution
// ---------------------------
resolve = function(name, env)
	parts = name.split(".")
	v = env
	i = 0
	while i < len(parts)
		key = parts[i]
		if v isa map and v.hasIndex(key) then
			v = v[key]
		else
			return null
		end if
		i = i + 1
	end while
	return v
end function

resolveDefault = function(name, env)
	parts = name.split("|")
	varname = parts[0]
	if len(parts) > 1 then
		default = parts[1]
	else
		default = null
	end if
	
	v = resolve(varname, env)
	
	if v == null and default != null then
		// try to coerce default if numeric
		if default isa string and isNumericString(default) then
			v = default.val
		else
			v = default
		end if
	end if
	
	return v
end function

// ---------------------------
// Tokenizer
// ---------------------------
tokenize = function(expr)
	tokens = []
	i = 0
	while i < len(expr)
		c = expr[i:i+1]
		if " \t\n".contains(c) then
			i = i + 1
		else
			if "+-*/%^()<>!=".contains(c) then
				// Handle two-char operators
				if i+1 < len(expr) then
					two = expr[i:i+2]
					if two == "==" or two == "!=" or two == "<=" or two == ">=" then
						tokens.push(two)
						i = i + 2
					else
						tokens.push(c)
						i = i + 1
					end if
				else
					tokens.push(c)
					i = i + 1
				end if
			else
				if "0123456789".contains(c) then
					num = ""
					while i < len(expr) and ("0123456789.".contains(expr[i:i+1]))
						num = num + expr[i:i+1]
						i = i + 1
					end while
					tokens.push(num)
				else
					var = ""
					while i < len(expr) and ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.|".contains(expr[i:i+1]))
						var = var + expr[i:i+1]
						i = i + 1
					end while
					tokens.push(var)
				end if
			end if
		end if
	end while
	return tokens
end function

// ---------------------------
// Parser / Evaluator
// ---------------------------
parseExpr = function(tokens, env)
	state = {"pos":0}
	
	peek = function()
		if state.pos < len(tokens) then
			return tokens[state.pos]
		else
			return null
		end if
	end function
	
	nextToken = function()
		t = tokens[state.pos]
		state.pos = state.pos + 1
		return t
	end function
	
	base = function()
		t = nextToken()
		if t isa number then
			return t
		end if
		if t isa string and isNumericString(t) then
			return t.val
		end if
		if t == "(" then
			v = comparison()
			tmp = nextToken()
			if tmp != ")" then
				print "Expected )"
				exit()
			end if
			return v
		end if
		if t isa string then
			v = resolveDefault(t, env)
			if v isa string and isNumericString(v) then
				return v.val
			end if
			return v
		end if
		print "Unexpected token: " + str(t)
		exit()
	end function
	
	factor = function()
		if peek() == "-" then
			nextToken()
			return -factor()
		end if
		return base()
	end function
	
	power = function()
		v = factor()
		while peek() == "^"
			nextToken()
			v = v ^ power()
		end while
		return v
	end function
	
	term = function()
		v = power()
		while peek() == "*" or peek() == "/" or peek() == "%"
			op = nextToken()
			r = power()
			if op == "*" then
				v = v * r
			else
				if op == "/" then
					v = v / r
				else
					v = v % r
				end if
			end if
		end while
		return v
	end function
	
	expr = function()
		v = term()
		while peek() == "+" or peek() == "-"
			op = nextToken()
			r = term()
			if op == "+" then
				v = v + r
			else
				v = v - r
			end if
		end while
		return v
	end function
	
	comparison = function()
		v = expr()
		while peek() == "==" or peek() == "!=" or peek() == "<" or peek() == ">" or peek() == "<=" or peek() == ">="
			op = nextToken()
			r = expr()
			if op == "==" then
				v = (v == r)
			else
				if op == "!=" then
					v = (v != r)
				else
					if op == "<" then
						v = (v < r)
					else
						if op == "<=" then
							v = (v <= r)
						else
							if op == ">" then
								v = (v > r)
							else
								v = (v >= r)
							end if
						end if
					end if
				end if
			end if
		end while
		return v
	end function
	
	return comparison()
end function

// ---------------------------
// Find matching brace
// ---------------------------
findMatchingBrace = function(s, startPos)
	depth = 0
	i = startPos
	while i < len(s)
		c = s[i:i+1]
		if c == "{" then
			depth = depth + 1
		else
			if c == "}" then
				depth = depth - 1
				if depth == 0 then
					return i
				end if
			end if
		end if
		i = i + 1
	end while
	return -1
end function

// ---------------------------
// Recursive interpolation
// ---------------------------
interpNested = function(s, env)
	result = ""
	i = 0
	while i < len(s)
		if i+1 < len(s) and s[i:i+2] == "\{" then
			result = result + "{"
			i = i + 2
		else
			c = s[i:i+1]
			if c == "{" then
				endPos = findMatchingBrace(s, i)
				if endPos == -1 then
					result = result + c
					i = i + 1
				else
					inner = s[i+1:endPos]
					innerEvaluated = interpNested(inner, env)
					
					// Check for boolean suffix
					if inner.endsWith("b") then
						inner = inner[0:len(inner)-1]
						tokens = tokenize(inner)
						v = parseExpr(tokens, env)
						if v == 0 then
							result = result + "false"
						else
							result = result + "true"
						end if
					else
						tokens = tokenize(innerEvaluated)
						v = parseExpr(tokens, env)
						result = result + str(v)
					end if
					
					i = endPos + 1
				end if
			else
				result = result + c
				i = i + 1
			end if
		end if
	end while
	return result
end function

// ---------------------------
// Public API
// ---------------------------
interp = function(s, env)
	return interpNested(s, env)
end function

// ---------------------------
// Example usage
// ---------------------------
vars = {"w":{"inner":13, "nested": {"inner": 30}},"x":10,"y":5,"z":2}
print interp("Pure expression, 2 + 2: {2+2}", vars)
print interp("Variable support, x + y: {x + y}", vars)
print interp("Map support, w.nested.inner + 7: {w.nested.inner + 7}", vars)
print interp("Default, a or 42: {a|42}", vars)
print interp("Compare, x > y: {x > y}", vars)
print interp("Escaping, \\{: The total of \{x + y} is {x + y}", vars)
print interp("Unary minus, x+-(-x--y): {x+-(-x--y)}", vars)
print interp("PEMDAS, 3 + (4 - 2) ^ 2 * 5 % 4 / 2: {3 + (4 - 2) ^ 2 * 5 % 4 / 2}", vars)
print interp("Boolean as number, (x > y) + 1: {(x > y) + 1}", vars)
print interp("Boolean as string, (x * 2 > y + 10)b: {(x * 2 > y + 10)b}", vars)