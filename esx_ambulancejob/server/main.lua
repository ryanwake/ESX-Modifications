RegisterServerEvent('esx_ambulancejob:forceBlip')
AddEventHandler('esx_ambulancejob:forceBlip', function()
	TriggerClientEvent('esx_policejob:updateBlip', -1)
end)