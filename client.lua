local isNearPed = false
local isPedLoaded = false
Citizen.CreateThread(function()

    while true do
Citizen.Wait(1)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
for k,v in pairs(Config.NPCS) do
       -- local distance = Vdist(playerCoords, Config.NPCPosition.x, Config.NPCPosition.y, Config.NPCPosition.z) VDIST IST ALT UND SHER UNPERFORMANT MACH ES LIEBER WIE ICH
       local distance = #(playerCoords, v.coords)
       local isNearPed = false

        if distance < 30.0 then
            local isNearPed = true
            if not isPedLoaded then
                RequestModel(GetHashKey(v.model))
                while not HasModelLoaded(GetHashKey(v.model)) do
                    Wait(10)
                end

                npc = CreatePed(4, GetHashKey(v.model), v.coords.x, v.coords.y, v.coords.z - 1.0, v.coords.w, false, false)
                FreezeEntityPosition(npc, true)
                SetEntityHeading(npc, v.coords.w)
                SetEntityInvincible(npc, true)
                SetBlockingOfNonTemporaryEvents(npc, true)

                local isPedLoaded = true
            end
        end

        if isPedLoaded and not isNearPed then
            DeleteEntity(npc)
            SetModelAsNoLongerNeeded(pedModel)
            local isPedLoaded = false
        end
end
        Citizen.Wait(500)
    end
end)
