include("callable")

-- namespace sectorPreload

sectorPreload = {}

function sectorPreload.initialize()
	print("Sector Preload Init")
	
	if onClient() then
		print("Registering onSelectMapCoordinates callback")
		Player():registerCallback("onSelectMapCoordinates", "onSelectMapCoordinates")
	end
end

function sectorPreload.onSelectMapCoordinates(x, y)
	if onClient() then
		print("onSelectMapCoordinates " .. x .. "," .. y)
		invokeServerFunction("loadSector", x, y)
	end
end

function sectorPreload.loadSector(x, y)
	if onServer() then
		print("preloading sector " .. x .. "," .. y)
		local galaxy = Galaxy()
		galaxy.keepOrGetSector(galaxy, x, y, 120)
		printSectors(galaxy.getLoadedSectors(galaxy))
	end
end
callable(sectorPreload, "loadSector")


function printSectors(sectors)
	print("Loaded sectors:")
	local count = 0
	for index, sector in pairs(sectors) do
		count = count + 1
		print(sector.x .. "," .. sector.y)
	end
	print(count .. " loaded sectors")
end