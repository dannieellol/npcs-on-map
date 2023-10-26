local isNearPed = false
local isPedLoaded = false
local pedModel = GetHashKey(Config.Model)
local npc

Citizen.CreateThread(function()

    while true do

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local distance = Vdist(playerCoords, Config.NPCPosition.x, Config.NPCPosition.y, Config.NPCPosition.z)
        isNearPed = false

        if distance < 30.0 then
            isNearPed = true
            if not isPedLoaded then
                RequestModel(pedModel)
                while not HasModelLoaded(pedModel) do
                    Wait(10)
                end

                npc = CreatePed(4, pedModel, Config.NPCPosition.x, Config.NPCPosition.y, Config.NPCPosition.z - 1.0, Config.NPCPosition.rot, false, false)
                FreezeEntityPosition(npc, true)
                SetEntityHeading(npc, Config.NPCPosition.rot)
                SetEntityInvincible(npc, true)
                SetBlockingOfNonTemporaryEvents(npc, true)

                isPedLoaded = true
            end
        end

        if isPedLoaded and not isNearPed then
            DeleteEntity(npc)
            SetModelAsNoLongerNeeded(pedModel)
            isPedLoaded = false
        end
        Citizen.Wait(500)
    end
end)