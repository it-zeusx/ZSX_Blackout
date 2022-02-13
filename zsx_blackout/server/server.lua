
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
----------------------------------------------------------------
------------ BLACKOUT ESX SERVER SIDE --------------------------
----------------------------------------------------------------


local triggered = 0

if Config.UseItem then
	ESX.RegisterUsableItem('blackout', function(source)
		local _source 	= source
		local value		= 0
		local xPlayer 	= ESX.GetPlayerFromId(_source)
		
		while xPlayer == nil do
			xPlayer = ESX.GetPlayerFromId(_source)
			Citizen.Wait(10)
		end

		if triggered == 0 then -- sprawdz czy zostal uzyty 
			triggered = 1
			MySQL.Sync.execute("UPDATE blackout SET enabled='1'")
			TriggerClientEvent("zs_blackout:swiatlaclient", source)
			xPlayer.removeInventoryItem('blackout', 1)
			Citizen.Wait(5000) 
			triggered = 1
			Citizen.Wait(Config.BlackoutResetTime * 1000)
			MySQL.Sync.execute("UPDATE blackout SET enabled='0'")
			triggered = 0
		else
			TriggerClientEvent('esx:showNotification', source, Config.BlackoutNotifyReset)
		end
	end)
end



if Config.UseCommand then
	RegisterServerEvent("zs_blackout:commandStart")
	AddEventHandler("zs_blackout:commandStart", function(source)
		local _source 	= source
		local value		= 0
		local xPlayer 	= ESX.GetPlayerFromId(_source)
		
		while xPlayer == nil do
			xPlayer = ESX.GetPlayerFromId(_source)
			Citizen.Wait(10)
		end

		if triggered == 0 then
			triggered = 1
			MySQL.Sync.execute("UPDATE blackout SET enabled='1'")
			TriggerClientEvent("zs_blackout:swiatlaclient", source)
			Citizen.Wait(5000)
			triggered = 1
			Citizen.Wait(Config.BlackoutTime * 1000)
			MySQL.Sync.execute("UPDATE blackout SET enabled='0'")
			Citizen.Wait(Config.BlackoutResetTime * 1000)
			triggered = 0
		else
			TriggerClientEvent('esx:showNotification', source, Config.BlackoutNotifyReset)
		end
	end)
end

AddEventHandler('onResourceStart', function(resourceName)
    if PerformHttpRequest() == false then
        print("[ZSX_BLACKOUT] License is not correct. Unloading...")
        resourceName = GetCurrentResourceName()
        AddEventHandler("playerConnecting", function(name, setReason)
			setReason("[ZSX_BLACKOUT] Server doesn't have license. Contact admin for more information.")
            print("[ZSX_BLACKOUT] Disabling player connect. Reason: server doesn't have license.")
            CancelEvent()
        end)
    else 
        local con = false
        local server_ip = nil
        PerformHttpRequest('https://www.myip.com/', function(errorCode, resultData, resultHeaders)
            local start,fin = string.find(tostring(resultData),'<span id="ip">')
            local startB,finB = string.find(tostring(resultData),'</span>')
            if not fin then 
                return
            end
            con = string.sub(tostring(resultData),fin+1,startB-1)
            PerformHttpRequest("https://dottbuff.eu/api/license/CHVAME/YtULUbfNf8SDyKHu2fO21dqotWHaFOBW", function (errorCode, resultData, resultHeaders)
                local api_result = json.decode(resultData)
                local ats = os.time(os.date("!*t"))
                local endts = json.decode(api_result.expiration)
                local server_ip = json.decode(api_result.ip)
                if string.find(tostring(resultData), con) and endts > ats then
                    print("[ZSX_BLACKOUT] License is okay. Loading...")
                else
                    print("[ZSX_BLACKOUT] License is not correct. Unloading...")
                    resourceName = GetCurrentResourceName()
                    AddEventHandler("playerConnecting", function(name, setReason)
                        setReason("[ZSX_BLACKOUT] Server doesn't have license. Contact admin for more information.")
                        print("[ZSX_BLACKOUT] Disabling player connect. Reason: server doesn't have license.")
                        CancelEvent()
                    end)
                end
            end)
        end)
    end
end)

RegisterNetEvent("zs_blackout:swiatlaserver")
AddEventHandler("zs_blackout:swiatlaserver", function()
 TriggerClientEvent("zs_blackout:swiatla", -1)
end)

