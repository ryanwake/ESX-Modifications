local blipsEms = {}

------

-- Create blip for colleagues
function createBlip(id, job)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		if job == 'ambulance' then
			blip = AddBlipForEntity(ped)
			SetBlipSprite(blip, 61)
			ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
			SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
			SetBlipNameToPlayerName(blip, id) -- update blip name
			SetBlipScale(blip, 0.85) -- set scale
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, 38)

			table.insert(blipsEms, blip) -- add blip to array so we can remove it later
		elseif job == 'police' then
			blip = AddBlipForEntity(ped)
			SetBlipSprite(blip, 58)
			ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
			SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
			SetBlipNameToPlayerName(blip, id) -- update blip name
			SetBlipScale(blip, 0.85) -- set scale
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, 38)

			table.insert(blipsEms, blip) -- add blip to array so we can remove it later
		end
	end
end

RegisterNetEvent('esx_ambulancejob:updateBlip')
AddEventHandler('esx_ambulancejob:updateBlip', function()
	-- Refresh all blips
	for k, existingBlip in pairs(blipsEms) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	blipsEms = {}

	-- Is the player a EMS? In that case show all the blips for other EMS
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'ambulance' or players[i].job.name == 'police' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id, players[i].job.name)
					end
				end
			end
		end)
	end

end)