RegisterNetEvent("cyclus-staffTagg:function:notify")
AddEventHandler("cyclus-staffTagg:function:notify", function()
    exports['zero-notify']:notification("Systeem", "Enkel staff leden kunnen deze command uitvoeren!", "error", 5000)
end)

DrawScriptText = function(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 500
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 85)
    ClearDrawOrigin()
end