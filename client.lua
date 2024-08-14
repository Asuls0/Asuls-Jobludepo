local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    while true do
        local sleep = 100
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local playerData = QBCore.Functions.GetPlayerData()

        for _, depo in pairs(Config.KisiselDepolar) do
            local dist = #(plyCoords - depo.coords)

            if dist < 2.0 then
                sleep = 5
                QBCore.Functions.DrawText3D(depo.coords.x, depo.coords.y, depo.coords.z, "[E] Kişisel Depo")

                if IsControlJustPressed(0, 38) and playerData.job.name == depo.job then
                    local stashName = "meslekdepo_" .. playerData.citizenid
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, {
                        maxweight = 1000000,
                        slots = 200,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", stashName)

                    TriggerServerEvent('log:openStash', playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname, stashName)
                end
            end
        end
        Wait(sleep)
    end
end)
