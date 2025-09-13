if list.contains == null then
	list.contains = function(item)
		return self.indexOf(@item) != null
	end function
end if

list.containsAll = function(requirement)
	if requirement isa list then
		result = {
		  "found":[],
		  "missing":[]}
		
		for req in requirement
			if self.contains(req) then
				result.found.push req
			else
				result.missing.push req
			end if
		end for
	else
		print("Function needs a list.")
		return null
	end if
	
	if result.found.len == requirement.len then
		result["log"] = "Found all of: " + requirement
	else
		result["log"] = "Tried to find: " + requirement + char(13) + "Found: " + result.found + char(13) + "Missing: " + result.missing
	end if
	result["bool"] = result.missing.len == 0
	return result
end function