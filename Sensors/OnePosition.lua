local sensorInfo = {
	name = "One Position",
	desc = "Select only one position out of near neighbours",
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


-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

local SpringGetGroundHeight = Spring.GetGroundHeight 

-- @description from each close neighborhood return exactly one location / {location, [location keys]} if richData == true
-- fast implementation of one pass of k-means that expects no overlap between neighborhoods
return function(locations, neighborhoodTreshold, richData)
	neighborhoodTreshold = neighborhoodTreshold or 512
	richData = richData or false

	oneLocs = {}
	oneLocId = 1 --number of locations seen in specific neighborhoods, needed for average position calculation

	for key, loc in pairs(locations) do

		local isCloseToAlreadySelected = false
		for selectedNeighbKey, selectedNeighb in pairs(oneLocs) do
			-- current location is within an already seen neighborhood
			if loc:Distance(selectedNeighb[1]) < neighborhoodTreshold then
				
				-- newNeighborhoodCentre = (oldCentre * numberOfLocationsInNeighbSofar + newLocation) / (numberOfLocationsInNeighbSofar + 1)
				local currCoef = oneLocs[selectedNeighbKey][3]
				local newSelectedLoc = (selectedNeighb[1] * currCoef + loc) / (currCoef + 1) 

				currCoef = currCoef + 1

				oneLocs[selectedNeighbKey][1] = newSelectedLoc
				oneLocs[selectedNeighbKey][2][currCoef] = key
				oneLocs[selectedNeighbKey][3] = currCoef

				isCloseToAlreadySelected = true
			end
		end 

		-- location from a completely new neighborhood
		if isCloseToAlreadySelected == false then
			oneLocs[oneLocId] = {loc, {key}, 1}
			oneLocId = oneLocId + 1
		end
		
	end

	if not richData then
		for i=1, #oneLocs do
			oneLocs[i] = oneLocs[i][1]
		end 
	end

	return oneLocs
end