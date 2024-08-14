local QBCore = exports['qb-core']:GetCoreObject()
local webhookURL = "https://discord.com/api/webhooks/1273366234095947826/8mqWwx29l6gVd0ztPzqH8raZ6Ph1UamQT75dJslRuy3s4PK0Of2HsFMkTFcwB6mvN8FO"

RegisterNetEvent('log:openStash')
AddEventHandler('log:openStash', function(playerName, stashName)
    local message = string.format("Oyuncu **%s** deponun **%s** açtı.", playerName, stashName)
    sendToDiscord("Depo Açma Logu", message, webhookURL)
end)

function sendToDiscord(title, message, url)
    local embed = {
        {
            ["color"] = 3447003, 
            ["title"] = title,
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Asuls Meslek Deposu",
            },
        }
    }
    
    PerformHttpRequest(url, function(err, text, headers)
        if err ~= 200 then
            print("Webhook gönderimi başarısız oldu. Hata kodu: " .. err)
        end
    end, 'POST', json.encode({username = "Stash Log", embeds = embed}), { ['Content-Type'] = 'application/json' })
end
