AddEventHandler("zs_hackdependency:start", function()
    SendNUIMessage({
        type = 'intro'
    })
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'hacksound', 0.8)
   Citizen.Wait(3350)
end)

AddEventHandler("zs_hackdependency:startfail", function(source)
    local _source = source
    SendNUIMessage({
        type = 'fail'
    })
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'hackfail', 0.8)
   Citizen.Wait(3350)
end)