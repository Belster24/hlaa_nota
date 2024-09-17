local sensorInfo = {
	name = "Units to Uids",
	desc = "Convert units to uids",
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

local function isPickableUnit(unitID)


    if (UnitDefs[Spring.GetUnitDefID(unitID)].name == "armatlas") then return false end
    if (UnitDefs[Spring.GetUnitDefID(unitID)].name == "armwin") then return false end
    if (UnitDefs[Spring.GetUnitDefID(unitID)].name == "armpeep") then return false end
    if (UnitDefs[Spring.GetUnitDefID(unitID)].name == "armrad") then return false end

    return true
end



local SpringGetGroundHeight = Spring.GetGroundHeight 
local myTeam = Spring.GetMyTeamID()



-- @description divides units into a number of groups
return function()

	local myTeamUnits = Spring.GetTeamUnits(myTeam)

	local  someID = {}
	local hm = true
	local counter = 1

	for i, unitID in ipairs(myTeamUnits) do
		hm = true
		if(UnitDefs[Spring.GetUnitDefID(unitID)].name == "armwin")  then
			 
			hm = false
		end
		if(UnitDefs[Spring.GetUnitDefID(unitID)].name == "armatlas")  then
			
		   hm = false
		end
		if(UnitDefs[Spring.GetUnitDefID(unitID)].name == "armpeep")  then
			
			hm = false
		end
		if(UnitDefs[Spring.GetUnitDefID(unitID)].name == "armrad")  then
			
			hm = false
		end

		if hm == true then
			someID[counter] = unitID
			counter = counter + 1
		end
		
	end

	return someID

end