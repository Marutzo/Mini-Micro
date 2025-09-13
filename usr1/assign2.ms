var = {
"op" : {"e" : "^", "m" : "*", "d" : "/", "a" : "+", "s" : "-"},
"test" : {"name" : "test", "value" : 1},
"toast" : {"name" : "toast", "value" : 3}}

mU = function(m, s, n = 1)
	if s == "^" then
		print m.name[0].upper() + m.name[1:] + " value is: " + m.value
		m.value = m.value ^ n
		print "Exponentiated value by " + n + " to: " + m.value
	else if s == "*" then
		print m.name[0].upper() + m.name[1:] + " value is: " + m.value
		m.value = m.value * n
		print "Multiplied value by " + n + " to: " + m.value
	else if s == "/" then
		print m.name[0].upper() + m.name[1:] + " value is: " + m.value
		m.value = m.value / n
		print "Divided value by " + n + " to: " + m.value
	else if s == "+" then
		print m.name[0].upper() + m.name[1:] + " value is: " + m.value
		m.value = m.value + n
		print "Additioned value by " + n + " to: " + m.value
	else if s == "-" then
		print m.name[0].upper() + m.name[1:] + " value is: " + m.value
		m.value = m.value - n
		print "Subtracted value by " + n + " to: " + m.value
	end if
	if str(m.value)[str(m.value).indexOf(".") + 1:].len > 2 then
		print "Rounding " + m.value + " to: " + round(m.value, 2)
		m.value = round(m.value, 2)
	end if
end function

print var.toast
print
mU(var.toast, var.op.d, 7)
print var.toast
print
mU(var.toast, var.op.m, 13)
print var.toast