ESX = nil
spelers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('cyclus-staffTag:server:requestSync', function(source, cb)
	cb(spelers)
end)

RegisterServerEvent('cyclus-staffTag:server:enable')
AddEventHandler('cyclus-staffTag:server:enable', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local name = GetPlayerName(src)
    for k,v in pairs(Cyclus.staffTagg) do
        if xPlayer.group == v.groupCheck then
            if spelers[src] == nil then
                spelers[src] = {
                    ['id'] = src,
                    ['naam'] = name
                }
                TriggerClientEvent('cyclus-staffTagg:client:syncTags', -1, spelers)
            else
                spelers[src] = nil
                TriggerClientEvent('cyclus-staffTagg:client:syncTags', -1, spelers)
            end
        else
            TriggerClientEvent('cyclus-staffTagg:function:notify', src) 
        end
    end
end)

AddEventHandler('esx:playerDropped', function(source)
    if spelers[source] ~= nil then
        spelers[source] = nil
    end
    TriggerClientEvent('cyclus-staffTagg:client:syncTags', -1, spelers)
end)