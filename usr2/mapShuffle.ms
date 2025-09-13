m = {"A":1, "B":2, "C":3}
x = m.indexes
x.shuffle // x now has ["A", "B", "C"] but shuffled

for i in range(0, x.len - 1)
	print x[i] + " : " + m[x[i]]
end for