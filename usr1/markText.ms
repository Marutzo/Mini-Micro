mark = function(string, myColor)
	text.delimiter = ""; text.color = color[myColor]; print string;
	text.color = color.orange; print " marked"; text.delimiter = char(13)
end function