local Phonographs = {
	vector3(3352.95, -639.82, 45.08), -- Sisika
	vector3(-312.85, 798.83, 119.48), -- Valentine
	vector3(-1811.78, -372.80, 161.90), -- Strawberry
	vector3(-815.16, -1312.52, 44.19), -- Blackwater
	vector3(1346.93, -1370.52, 80.99), -- Rhodes
	vector3(2948.84, 518.82, 45.15), -- Van Horn
	vector3(2630.60, -1226.35, 53.17), -- Saint Denis
	vector3(-3706.02, -2588.31, -12.82), -- Armadillo
	vector3(-5516.50, -2914.97, -1.26), -- Tumbleweed
	vector3(2801.20, -1164.42, 48.43), -- Saint Denis 2
	vector3(2935.13, 1274.38, 43.65), -- Annesburg
}

CreateThread(function()
	while true do
		Wait(100)

		local cam = GetRenderingCam()
		local pos = cam == -1 and GetGameplayCamCoord() or GetCamCoord(cam)

		local minDistance = nil

		for _, phonograph in ipairs(Phonographs) do
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, phonograph.x, phonograph.y, phonograph.z, true)

			if not minDistance or distance < minDistance then
				minDistance = distance
			end
		end

		SendNUIMessage({
			type = 'updateDistance',
			distance = minDistance
		})
	end
end)
