ESX = nil
local stafftable = {}
local staffTag = false

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    ESX.TriggerServerCallback('cyclus-staffTag:server:requestSync', function(request)
        stafftable = request
    end)
end)

RegisterNetEvent('cyclus-staffTagg:client:syncTags')
AddEventHandler('cyclus-staffTagg:client:syncTags', function(sync)
    stafftable = sync
end)

RegisterCommand(Cyclus.commandName, function(source, args)
    TriggerServerEvent("cyclus-staffTag:server:enable")
end)


CreateThread(function()
    while true do
        Wait(0)
        for k,v in pairs(stafftable) do
            local player = GetPlayerPed(GetPlayerFromServerId(v.id))
            local spelerNaam = v.naam
            for k,v in pairs(Cyclus.staffTagg) do
                local text = ' '..v.nameTagg..' '..spelerNaam..' '
                local ped = PlayerPedId()
                local pos = GetEntityCoords(player)
                local coords = GetEntityCoords(ped)
                local dist = #(pos - coords)
                if dist <= v.afstand then
                    if player ~= PlayerPedId() then
                        DrawScriptText(pos.x, pos.y, pos.z + 1.1, text)
                    else
                        DrawScriptText(pos.x, pos.y, pos.z + 1.1, text)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    RegisterKeyMapping(Cyclus.commandName, 'Staff Tagg', 'keyboard', Cyclus.commandKey)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == 'cyclus-staffTagg' then
        return
    end
    if not resourceName == 'cyclus-staffTagg' then
        print('Resource renamen is niet toegestaan')
        print('T.O.S overtreding opgemerkt en verzonden naar development.')
    end
end)