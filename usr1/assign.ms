op = {
"e" : "^=",
"m" : "*=",
"d" : "/=",
"a" : "+=",
"s" : "-="}

mathUtil = function(s, v, n = 1)
	v = globals.indexOf(v)
	if s == "^=" then
		globals[v] = globals[v] ^ n
	else if s == "*=" then
		globals[v] = globals[v] * n
	else if s == "/=" then
		globals[v] = globals[v] / n
	else if s == "+=" then
		globals[v] = globals[v] + n
	else if s == "-=" then
		globals[v] = globals[v] - n
	else
		return null
	end if
end function