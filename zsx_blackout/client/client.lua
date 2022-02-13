--[[
=======================================================
/////////////////// World Blackout Server-Sided
////////// ZEUSX 2021
============================================
]]

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local triggered = 0

RegisterNetEvent("zs_blackout:swiatlaclientfail")
AddEventHandler("zs_blackout:swiatlaclientfail", function()
  if triggered == 0 then -- sprawdz czy zostal uzyty 
      TriggerEvent("zs_hackdependency:startfail")
      TriggerEvent("FeedM:showNotification", "ERR0R 403 BAD GATEWAY", 8350, success)
      Citizen.Wait(3350)
      triggered = 0
  end
end)


RegisterNetEvent("zs_blackout:swiatlaclient")
AddEventHandler("zs_blackout:swiatlaclient", function()
  if triggered == 0 then -- sprawdz czy zostal uzyty 
      TriggerEvent("zs_hackdependency:start")
      TriggerEvent("FeedM:showNotification", "Injecting MS-BR34K3Rv1.1.0", 8350, success)
      Citizen.Wait(7040)
      TriggerServerEvent("zs_blackout:swiatlaserver", -1)
      Citizen.Wait(5000)
      triggered = 0
  end
end)

RegisterCommand("swiatla", function(source)
SetArtificialLightsState(true)
end)

---- caly event od wywalenia miasta
RegisterNetEvent("zs_blackout:swiatla")
AddEventHandler("zs_blackout:swiatla",function ()
  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 300, "blackouton", 1.0)
  Citizen.Wait(1000)
  SetArtificialLightsState(true)
  if Config.UseWelcomeNotify then
    ESX.ShowNotification(Config.StartBlackoutNotify)
  end
  Citizen.Wait(Config.BlackoutTime * 1000)
  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 300, "blackoutoff", 1.0)
  Citizen.Wait(100)
  if Config.UseWelcomeNotify then
    ESX.ShowNotification(Config.EndBlackoutNotify)
  end
  SetArtificialLightsState(false)
end)

if Config.UseCommand then
  RegisterCommand(Config.CommandName, function()
    TriggerServerEvent("zs_blackout:commandStart")
  end)
end