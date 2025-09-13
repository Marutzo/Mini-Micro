s = "I never could get the hang of Thursdays."
result = ""
for i in range(0, s.len - 1)
	checked = 0
	for j in ["a", "e"]
		if s[i] == j then
			checked = 1
		end if
	end for
	if checked then
		i = i + 1
	else
		result = result + s[i]
	end if
end for
print(result)