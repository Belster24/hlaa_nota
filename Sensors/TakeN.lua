local sensorInfo = {
	name = "Take N",
	desc = "Create a map with N elements from input of the map",
	author = "Zivnustka", 
	date = "2024-08-26",
	license = "none",
}

local EVAL_PERIOD_DEFAULT = -1 -- actual, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT
	}
end

-- speedups
local SpringGetUnitPosition = Spring.GetUnitPosition

-- @description takes at most first N elements from a map and returns new map
return function(input, numberOfElements)

	local takeN = math.min(numberOfElements, #input)
	local output = {}
	for i=1, takeN do
		output[i] = input[i]
	end
	return output
end