RegisterNUICallback("init", function(data, cb)
	cb(tonumber(GetResourceKvpString("maxVolume")) or 50)
end)

RegisterNetEvent("xmas:setMaxVolume", function(volume)
	SetResourceKvp("maxVolume", tostring(volume))

	SendNUIMessage {
		type = "setMaxVolume",
		volume = volume
	}
end)
