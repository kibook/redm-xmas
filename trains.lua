local Trains = {}

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

function EnumerateEntities(firstFunc, nextFunc, endFunc)
	return coroutine.wrap(function()
		local iter, id = firstFunc()

		if not id or id == 0 then
			endFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = endFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = nextFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		endFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local TrainModels = {
	'northsteamer01x'
}

function IsTrain(vehicle)
	local model = GetEntityModel(vehicle)

	for _, trainModel in ipairs(TrainModels) do
		if model == GetHashKey(trainModel) then
			return true
		end
	end

	return false
end

function DecorateTrain(vehicle)
	local object = CreateObjectNoOffset(GetHashKey('mp006_p_veh_xmasnsteamer01x'), 0, 0, 0, false, false, false, false)
	AttachEntityToEntity(object, vehicle, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true, false, false)
	return object
end

CreateThread(function()
	while true do
		Wait(100)

		for vehicle in EnumerateVehicles() do
			if IsTrain(vehicle) and not Trains[vehicle] then
				Trains[vehicle] = DecorateTrain(vehicle)
			end
		end

		for train, object in pairs(Trains) do
			if not DoesEntityExist(train) then
				DeleteEntity(object)
				Trains[train] = nil
			end
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if GetCurrentResourceName() == resource then
		for train, object in pairs(Trains) do
			DeleteEntity(object)
		end
	end
end)
