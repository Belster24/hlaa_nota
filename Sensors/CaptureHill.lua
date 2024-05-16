local sensorInfo = {
	name = "Capture Hill",
	desc = "Capture all hills on the map.",
	author = "Zivnustka",
	date = "2024-05-13",
	license = "none",
}

-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- @description return current wind statistics
return function()
	hills = { }

	local step = 16

	local hillsRadius = 128

	local _, maxHeight = Spring.GetGroundExtremes()


	for i = 0, Game.mapSizeX, step do
		for j = 0, Game.mapSizeZ, step do
			local h = Spring.GetGroundHeight (i, j)
			if h == maxHeight then
				local add = true
				for it = 1, #hills do
					if math.abs(hills[it].x - i) <= hillsRadius or math.abs(hills[it].z - j) <= hillsRadius then
						add = false
						break
					end
				end

				if add == true then
					hills[#hills + 1] = Vec3(i, h, j)
				end
			end
		end
	end

	return hills
end