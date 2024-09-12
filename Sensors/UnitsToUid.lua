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

local SpringGetGroundHeight = Spring.GetGroundHeight 

-- @description divides units into a number of groups
return function()

    local uids = {}
    for x=1, units.length do
        uids[x] = units[x]
    end

	return uids

end