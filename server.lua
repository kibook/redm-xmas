CreateThread(function()
	Wait(0)

	exports.weathersync:setWeatherPattern({
		['snowlight'] = {
			['snow'] = 20,
			['snowlight'] = 30,
			['clouds'] = 50
		},
		['snow'] = {
			['snow'] = 20,
			['snowlight'] = 70,
			['blizzard'] = 10
		},
		['blizzard'] = {
			['snow'] = 90,
			['blizzard'] = 10
		},
		['sunny'] = {
			['sunny'] = 60,
			['clouds'] = 40
		},
		['clouds'] = {
			['sunny'] = 30,
			['overcast'] = 70
		},
		['overcast'] = {
			['clouds'] = 30,
			['snowlight'] = 70
		}
	})

	exports.weathersync:setWeather('snowlight', 10.0, false, true)
end)

AddEventHandler('onResourceStop', function(resource)
	if GetCurrentResourceName() ~= resource then
		return
	end

	exports.weathersync:resetWeatherPattern()
	exports.weathersync:resetWeather()
end)

RegisterCommand("xmas_vol", function(source, args, raw)
	local volume = tonumber(args[1])

	if volume == nil then
		volume = 50
	elseif volume > 100 then
		volume = 100
	elseif volume < 0 then
		volume = 0
	end

	TriggerClientEvent("xmas:setMaxVolume", source, volume)
end, true)
