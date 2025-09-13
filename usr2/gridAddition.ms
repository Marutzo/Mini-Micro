clear()

add_grids = function(grid_one, grid_two, position, wraparound = false)
	// Extract dimensions
	grid_one_rows = len(grid_one)
	if grid_one_rows > 0 then grid_one_cols = len(grid_one[0]) else grid_one_cols = 0
	grid_two_rows = len(grid_two)
	if grid_two_rows > 0 then grid_two_cols = len(grid_two[0]) else grid_two_cols = 0
	
	// Positioning
	start_row = position[0]
	start_col = position[1]
	
	for i in range(0,grid_two_rows - 1)
		for j in range(0,grid_two_cols - 1)
			target_row = start_row + i
			target_col = start_col + j
			
			if wraparound then
				// Wrap around using modulo
				target_row %= grid_one_rows
				target_col %= grid_one_cols
				grid_one[target_row][target_col] += grid_two[i][j]
			else
				// Only add if within bounds
				if (0 <= target_row < grid_one_rows) and (0 <= target_col < grid_one_cols) then
					grid_one[target_row][target_col] += grid_two[i][j]
				end if
			end if
		end for
	end for
	return grid_one
end function

// Example usage with wraparound

currentValues = [
[0,0,0],
[0,0,0],
[0,0,0]]
valuesToAdd = [
[1,1,1,1],
[1,1,1,1]]
fromLocation = [
2,1]

for row in currentValues
	print row
end for
print

for row in valuesToAdd
	print row
end for
print

result = add_grids(currentValues, valuesToAdd, fromLocation, true)

for row in result
	print row
end for