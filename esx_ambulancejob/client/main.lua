RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerData = ESX.GetPlayerData()
	PlayerLoaded = true
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		TriggerEvent('esx_ambulancejob:updateBlip')
	end
end)

--------

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('esx_ambulancejob:forceBlip')
end)