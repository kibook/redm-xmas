CreateThread(function()
	Wait(0)

	exports.weathersync:SetWeatherPattern({
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

	exports.weathersync:SetWeather('snowlight', 10.0, false, true)
end)

AddEventHandler('onResourceStop', function(resource)
	if GetCurrentResourceName() ~= resource then
		return
	end

	exports.weathersync:ResetWeatherPattern()
	exports.weathersync:ResetWeather()
end)
