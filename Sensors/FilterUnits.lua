local sensorInfo = {
	name = "Filter units in area",
	desc = "Filter units in ceratin area",
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

local SpringGetUnitPosition = Spring.GetUnitPosition
function GetPosition(uid) 
	local x,y,z = SpringGetUnitPosition(uid)

	if y >= 0 then
		return Vec3(x,y,z)
	end

	return nil
end

-- @description filters out unit ids that corresponds to units in certain area
return function(uids, areaCenter, areaRadius)

	local notFilteredUIds = {}
	local j = 1

	for i=1, #uids do

		local uid = uids[i]
		local unitLoc = GetPosition(uid)

		if unitLoc ~= nil then

			if areaCenter:Distance(unitLoc) > areaRadius then
				notFilteredUIds[j] = uid
				j = j + 1
			end
		end
	end

	return notFilteredUIds

end