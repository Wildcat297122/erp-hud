local plyPed = PlayerPedId()
local plyVehicle = 0
local showingHud = false
local pausemenuactive = false
local disableHud = false

local alarmset, seatbelt = false, false

local function CarFuelAlarm()
    CreateThread(function()
        if not alarmset then
            alarmset = true
            local i = 4
            exports['mythic_notify']:SendAlert('error', 'Low fuel.', 3000)
            while i > 0 do
                PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
                i = i - 1
                Citizen.Wait(300)
            end
            Citizen.Wait(60000)
            alarmset = false
        end
        return
    end)
end

RegisterNetEvent("seatbelt")
AddEventHandler("seatbelt", function(new)
    seatbelt = new 
end)

--[[ Nitrous & Harness Stuff ]]--

local nos, nosEnabled = {}, {}

RegisterNetEvent("noshud")
AddEventHandler("noshud", function(_nos, _nosEnabled, vehicle)
    if _nos == nil then
        nos[vehicle] = 0
    else
        nos[vehicle] = 0
        nos[vehicle] = _nos
    end
    nosEnabled[vehicle] = _nosEnabled
end)

local HarnessVehicles = {}

RegisterNetEvent("harness")
AddEventHandler("harness", function(toggle)
    if plyVehicle ~= 0 and toggle then
        TriggerServerEvent('harness', VehToNet(plyVehicle))
    end
end)

RegisterNetEvent("newHarness")
AddEventHandler("newHarness", function(newData)
    HarnessVehicles = {}
    HarnessVehicles = newData
end)

function IsHarness(targetVeh)
    return HarnessVehicles[VehToNet(targetVeh)] or false
end

exports("IsHarness", IsHarness)

local KVPshowHealth, KVPshowArmor, KVPshowHunger, KVPshowThirst, KVPshowStress, KVPshowOxygen, KVPposition, KVPshowVoice = 0, 0, 0, 0, 0, 0, 0, 0
local KVPshowGear, KVPshowDirection, KVPshowLocation, KVPshowFuel, KVPshowSpeed, KVPvPosition, KVPvCircle, KVPshowSeatbelt = 0, 0, 0, 0, 0, 0, 0, 0


RegisterCommand("hudoptions", function(source, args, rawCommand)
    exports['mythic_notify']:SendAlert('error', 'Please use the Phone to change hud (Under Settings)')
end)

RegisterCommand("togglehud", function(source, args, rawCommand)
    disableHud = not disableHud
end)

-- RegisterCommand("hudoptions", function(source, args, rawCommand)
--     SendNUIMessage({
--         update = "hudOptions",
--         showHealth = GetResourceKvpInt('showHealth'),
--         showArmor = GetResourceKvpInt('showArmor'),
--         showHunger = GetResourceKvpInt('showHunger'),
--         showThirst = GetResourceKvpInt('showThirst'),
--         showStress = GetResourceKvpInt('showStress'),
--         showOxygen = GetResourceKvpInt('showOxygen'),
--         showVoice = GetResourceKvpInt('showVoice'),
--         position = GetResourceKvpInt('position'),
--         vPosition = GetResourceKvpInt('vPosition'),        
--         showGear = GetResourceKvpInt('showGear'),        
--         showDirection = GetResourceKvpInt('showDirection'),
--         showLocation = GetResourceKvpInt('showLocation'),
--         showFuel = GetResourceKvpInt('showFuel'),
--         showSpeed = GetResourceKvpInt('showSpeed'),
--         showSeatbelt = GetResourceKvpInt('showSeatbelt'),       
--         showvCircle = GetResourceKvpInt('showvCircle'),
--     })
--     SetNuiFocus(true, true)
-- end, false) -- set this to false to allow anyone.

RegisterNUICallback('saveOptions', function(data, cb)
    if data.showHealth then SetResourceKvpInt('showHealth', 2) elseif not data.showHealth then SetResourceKvpInt('showHealth', 1) end
    if data.showHunger then SetResourceKvpInt('showHunger', 2) elseif not data.showHunger then SetResourceKvpInt('showHunger', 1) end
    if data.showThirst then SetResourceKvpInt('showThirst', 2) elseif not data.showThirst then SetResourceKvpInt('showThirst', 1) end
    if data.showArmor then SetResourceKvpInt('showArmor', 2) elseif not data.showArmor then SetResourceKvpInt('showArmor', 1) end
    if data.showOxygen then SetResourceKvpInt('showOxygen', 2) elseif not data.showOxygen then SetResourceKvpInt('showOxygen', 1) end
    if data.showStress then SetResourceKvpInt('showStress', 2) elseif not data.showStress then SetResourceKvpInt('showStress', 1) end
    if data.showVoice then SetResourceKvpInt('showVoice', 2) elseif not data.showVoice then SetResourceKvpInt('showVoice', 1) end
    
    if data.showGear then SetResourceKvpInt('showGear', 2) elseif not data.showGear then SetResourceKvpInt('showGear', 1) end
    if data.showDirection then SetResourceKvpInt('showDirection', 2) elseif not data.showDirection then SetResourceKvpInt('showDirection', 1) end
    if data.showLocation then SetResourceKvpInt('showLocation', 2) elseif not data.showLocation then SetResourceKvpInt('showLocation', 1) end
    if data.showFuel then SetResourceKvpInt('showFuel', 2) elseif not data.showFuel then SetResourceKvpInt('showFuel', 1) end
    if data.showSpeed then SetResourceKvpInt('showSpeed', 2) elseif not data.showSpeed then SetResourceKvpInt('showSpeed', 1) end 
    if data.showSeatbelt then SetResourceKvpInt('showSeatbelt', 2) elseif not data.showSeatbelt then SetResourceKvpInt('showSeatbelt', 1) end   
    if data.showvCircle then SetResourceKvpInt('showvCircle', 2) elseif not data.showvCircle then SetResourceKvpInt('showvCircle', 1) end
    
    SetResourceKvpInt('position', data.position)
    SetResourceKvpInt('vPosition', data.vPosition)
    
    -- Hud Default Values if 0
    KVPshowHealth = GetResourceKvpInt('showHealth')
    if KVPshowHealth == 0 then SetResourceKvpInt('showHealth', 2) KVPshowHealth = 2 end;
    KVPshowArmor = GetResourceKvpInt('showArmor')
    if KVPshowArmor == 0 then SetResourceKvpInt('showArmor', 2) KVPshowArmor = 2 end;
    KVPshowHunger = GetResourceKvpInt('showHunger')
    if KVPshowHunger == 0 then SetResourceKvpInt('showHunger', 2) KVPshowHunger = 2 end;
    KVPshowThirst = GetResourceKvpInt('showThirst')
    if KVPshowThirst == 0 then SetResourceKvpInt('showThirst', 2) KVPshowThirst = 2 end;
    KVPshowStress = GetResourceKvpInt('showStress')
    if KVPshowStress == 0 then SetResourceKvpInt('showStress', 2) KVPshowStress = 2 end;
    KVPshowOxygen = GetResourceKvpInt('showOxygen')
    if KVPshowOxygen == 0 then SetResourceKvpInt('showOxygen', 2) KVPshowOxygen = 2 end;
    KVPshowVoice = GetResourceKvpInt('showVoice')
    if KVPshowVoice == 0 then SetResourceKvpInt('showVoice', 2) KVPshowVoice = 2 end;
    KVPposition = GetResourceKvpInt('position')
    if KVPposition == 0 then SetResourceKvpInt('position', 1) KVPposition = 1 end;

    -- Car HUD default values if 0
    KVPshowGear = GetResourceKvpInt('showGear')
    if KVPshowGear == 0 then SetResourceKvpInt('showGear', 2) KVPshowGear = 2 end;
    KVPshowDirection = GetResourceKvpInt('showDirection')
    if KVPshowDirection == 0 then SetResourceKvpInt('showDirection', 2) KVPshowDirection = 2 end;
    KVPshowLocation = GetResourceKvpInt('showLocation')
    if KVPshowLocation == 0 then SetResourceKvpInt('showLocation', 2) KVPshowLocation = 2 end;
    KVPshowFuel = GetResourceKvpInt('showFuel')
    if KVPshowFuel == 0 then SetResourceKvpInt('showFuel', 2) KVPshowFuel = 2 end;
    KVPshowSpeed = GetResourceKvpInt('showSpeed')
    if KVPshowSpeed == 0 then SetResourceKvpInt('showSpeed', 2) KVPshowSpeed = 2 end;
    KVPvCircle = GetResourceKvpInt('showvCircle')
    if KVPvCircle == 0 then SetResourceKvpInt('showvCircle', 2) KVPvCircle = 2 end;
    KVPshowSeatbelt = GetResourceKvpInt('showSeatbelt')
    if KVPshowSeatbelt == 0 then SetResourceKvpInt('showSeatbelt', 2) KVPshowSeatbelt = 2 end;
    KVPvPosition = GetResourceKvpInt('vPosition')
    if KVPvPosition == 0 then SetResourceKvpInt('vPosition', 2) KVPvPosition = 2 end;

    cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

local inVehicle = false

RegisterNetEvent('baseevents:leftVehicle')
AddEventHandler('baseevents:leftVehicle', function(veh, seat, class, netId)
    plyVehicle = 0
    inVehicle = false
    plyPed = PlayerPedId()
    Wait(50)
    showingHud = false
    SendNUIMessage({ show = showingHud })
    DisplayRadar(false)
end)

RegisterNetEvent('baseevents:enteredVehicle')
AddEventHandler('baseevents:enteredVehicle', function(veh, seat, class, netId)
    if inVehicle then return end;
    plyVehicle = veh
    inVehicle = true
    plyPed = PlayerPedId()

    DisplayRadar(true)

    CreateThread(function()
        while inVehicle do
            local waitTimer = 0
            if seatbelt then 
                DisableControlAction(0, 75, true) 
            else
                waitTimer = 500
            end
            Wait(waitTimer)
        end
        return
    end)

    CreateThread(function() -- Everything but location.
        while inVehicle do
            local waitTimer = 500
            if not pausemenuactive and GetIsVehicleEngineRunning(veh) then
                waitTimer = 100
                if not showingHud then
                    showingHud = true
                    SendNUIMessage({ show = showingHud })
                end
                local mph = math.ceil(GetEntitySpeed(plyVehicle) * 2.23694)
                local gear = GetVehicleCurrentGear(plyVehicle)
                local rpm = GetVehicleCurrentRpm(plyVehicle)
                SendNUIMessage({
                    show = showingHud,
                    speed = mph,
                    gear = gear,
                    rpm = rpm,
                    seatbelt = not seatbelt,
                    vPosition = KVPvPosition,                
                    showGear = KVPshowGear,                
                    showDirection = KVPshowDirection,                
                    showLocation = KVPshowLocation,               
                    showFuel = KVPshowFuel,
                    showSpeed = KVPshowSpeed,
                    showSeatbelt = KVPshowSeatbelt,
                    showvCircle = KVPvCircle
                })
            elseif showingHud then
                showingHud = false
                SendNUIMessage({ show = showingHud })
                waitTimer = 1000
            else
                waitTimer = 1000
            end
            Wait(waitTimer)
        end
        return
    end)

    CreateThread(function() -- Everything but location.
        while inVehicle do
            local waitTimer = 1000
            if not pausemenuactive and GetIsVehicleEngineRunning(veh) then
                local x, y, z = table.unpack(GetEntityCoords(plyPed))
                local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z)
                local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
                local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
                local zone = tostring(GetNameOfZone(x, y, z))
                local area = GetLabelText(zone)
                local playerStreetsLocation = area
    
                if not zone then zone = "UNKNOWN" end;
    
                if intersectStreetName ~= nil and intersectStreetName ~= "" then playerStreetsLocation = currentStreetName .. " | " .. intersectStreetName .. " | [ " .. area .. " ]"
                elseif currentStreetName ~= nil and currentStreetName ~= "" then playerStreetsLocation = currentStreetName .. " | [ " .. area .. " ]" end
    
                local direction = "N"
                local heading = GetEntityHeading(plyPed)
                if heading >= 315 or heading < 45 then direction = "N"
                elseif heading >= 45 and heading < 135 then direction = "W"
                elseif heading >=135 and heading < 225 then direction = "S"
                elseif heading >= 225 and heading < 315 then direction = "E" end
    
                local fuel = exports["erp-fuel"]:GetFuel(plyVehicle)
                if fuel < 15 then CarFuelAlarm() end
                
                local engineAlert = false
    
                if GetVehicleEngineHealth(plyVehicle) < 400 then engineAlert = true end
                SendNUIMessage({
                    show = showingHud,
                    location = playerStreetsLocation,
                    compass = direction,
                    engineAlert = engineAlert,
                    fuel = fuel,
                    showGear = KVPshowGear,                
                    showDirection = KVPshowDirection,                
                    showLocation = KVPshowLocation,               
                    showFuel = KVPshowFuel,
                    showSpeed = KVPshowSpeed,
                    showSeatbelt = KVPshowSeatbelt,
                    showvCircle = KVPvCircle
                })
            else
                waitTimer = 1500
            end
            Wait(waitTimer)
        end
        return
    end)
end)

function IsNos(veh)
    local nosValue = exports['erp-vehmods']:GetNosStatus(veh)
    if nosValue == nil or nosValue <= 0 then return {status = false, value = nosValue} end
    return {status = true, value = nosValue}
end

function GetRealVal(val)
    if json.encode(nos[val]) == nil then return 0 end
    return nos[val]
end

-- Water shit

RegisterNetEvent("erp-purge")
AddEventHandler("erp-purge", function(targetVeh)
    if NetworkDoesEntityExistWithNetworkId(targetVeh) then
        local veh = NetToVeh(targetVeh)
        if DoesEntityExist(veh) then
            SetVehicleNitroPurgeEnabled(NetToVeh(targetVeh), true)
        end
    end
end)

function CreateVehiclePurgeSpray(vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('ent_amb_steam', vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, false, false, false)
  end

function SetVehicleNitroPurgeEnabled(vehicle, enabled)
    if enabled then
      local bone = GetEntityBoneIndexByName(vehicle, 'bonnet')
      local pos = GetWorldPositionOfEntityBone(vehicle, bone)
      local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)  
      --for i=0,math.random(4,7) do
        local leftPurge = CreateVehiclePurgeSpray(vehicle, off.x - 0.5, off.y + 0.05, off.z, 40.0, -20.0, 0.0, 0.65)
        local rightPurge = CreateVehiclePurgeSpray(vehicle, off.x + 0.5, off.y + 0.05, off.z, 40.0, 20.0, 0.0, 0.65)
        Wait(300)
        StopParticleFxLooped(leftPurge)
        StopParticleFxLooped(rightPurge)
      --end
    end
end


RegisterKeyMapping("seatbelt", "Toggle Seatbelt", "keyboard", "B")
RegisterCommand("-seatbelt", function() end, false) -- Disables chat from opening.

RegisterCommand("seatbelt", function(source, args, rawCommand)
    if exports["erp-characterui"]:InCharacterUI() then return end if exports["erp_clothing"]:inMenu() then return end 
    if plyVehicle ~= 0 then
        if not seatbelt then
            if not IsHarness(plyVehicle) then
                TriggerEvent('seatbelt', true)
                TriggerEvent("erp-sounds:PlayOnOne","seatbelt",0.2)
                exports['mythic_notify']:SendAlert('inform', 'Seat Belt Enabled')
            else
                exports['mythic_notify']:SendAlert('inform', 'You\'re sat in a vehicle with harness, seatbelt ignored.', 4000)
            end
        else
            if not IsHarness(plyVehicle) then
                TriggerEvent('seatbelt', false)
                TriggerEvent("erp-sounds:PlayOnOne","seatbeltoff",0.7)
                exports['mythic_notify']:SendAlert('inform', 'Seat Belt Disabled')
            else
                exports['mythic_notify']:SendAlert('inform', 'You\'re sat in a vehicle with harness, seatbelt ignored.', 4000)
            end
        end
    end
end, false)

RegisterKeyMapping("nitrouspurge", "Nitrous Purge", "keyboard", "LCONTROL")
RegisterCommand("-nitrouspurge", function() end, false) -- Disables chat from opening.

RegisterCommand("nitrouspurge", function(source, args, rawCommand)
    if exports["erp-characterui"]:InCharacterUI() then return end if exports["erp_clothing"]:inMenu() then return end 
    if plyVehicle ~= 0 then
        if IsNos(plyVehicle) then
            local amount = exports['erp-vehmods']:GetNosStatus(plyVehicle)
            if amount then
                TriggerServerEvent('SetVehicleNitroPurgeEnabled', VehToNet(plyVehicle), GetVehicleNumberPlateText(plyVehicle), amount)
            end
        end
    end
end, false)

local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end



CreateThread(function()
    DisplayRadar(false)
    Wait(2500)
    KVPshowHealth = GetResourceKvpInt('showHealth')
    if KVPshowHealth == 0 then SetResourceKvpInt('showHealth', 2) KVPshowHealth = 2 end;
    KVPshowArmor = GetResourceKvpInt('showArmor')
    if KVPshowArmor == 0 then SetResourceKvpInt('showArmor', 2) KVPshowArmor = 2 end;
    KVPshowHunger = GetResourceKvpInt('showHunger')
    if KVPshowHunger == 0 then SetResourceKvpInt('showHunger', 2) KVPshowHunger = 2 end;
    KVPshowThirst = GetResourceKvpInt('showThirst')
    if KVPshowThirst == 0 then SetResourceKvpInt('showThirst', 2) KVPshowThirst = 2 end;
    KVPshowStress = GetResourceKvpInt('showStress')
    if KVPshowStress == 0 then SetResourceKvpInt('showStress', 2) KVPshowStress = 2 end;
    KVPshowOxygen = GetResourceKvpInt('showOxygen')
    if KVPshowOxygen == 0 then SetResourceKvpInt('showOxygen', 2) KVPshowOxygen = 2 end;
    KVPshowVoice = GetResourceKvpInt('showVoice')
    if KVPshowVoice == 0 then SetResourceKvpInt('showVoice', 2) KVPshowVoice = 2 end;
    KVPposition = GetResourceKvpInt('position')
    if KVPposition == 0 then SetResourceKvpInt('position', 1) KVPposition = 1 end;
    KVPshowGear = GetResourceKvpInt('showGear')
    if KVPshowGear == 0 then SetResourceKvpInt('showGear', 2) KVPshowGear = 2 end;
    KVPshowDirection = GetResourceKvpInt('showDirection')
    if KVPshowDirection == 0 then SetResourceKvpInt('showDirection', 2) KVPshowDirection = 2 end;
    KVPshowLocation = GetResourceKvpInt('showLocation')
    if KVPshowLocation == 0 then SetResourceKvpInt('showLocation', 2) KVPshowLocation = 2 end;
    KVPshowFuel = GetResourceKvpInt('showFuel')
    if KVPshowFuel == 0 then SetResourceKvpInt('showFuel', 2) KVPshowFuel = 2 end;
    KVPshowSpeed = GetResourceKvpInt('showSpeed')
    if KVPshowSpeed == 0 then SetResourceKvpInt('showSpeed', 2) KVPshowSpeed = 2 end;
    KVPshowSeatbelt = GetResourceKvpInt('showSeatbelt')
    if KVPshowSeatbelt == 0 then SetResourceKvpInt('showSeatbelt', 2) KVPshowSeatbelt = 2 end;
    KVPvCircle = GetResourceKvpInt('showvCircle')
    if KVPvCircle == 0 then SetResourceKvpInt('showvCircle', 2) KVPvCircle = 2 end;
    KVPvPosition = GetResourceKvpInt('vPosition')
    if KVPvPosition == 0 then SetResourceKvpInt('vPosition', 2) KVPvPosition = 2 end;   

    DisplayRadar(false)

    local plyId = PlayerId()

    while true do
        Wait(250)
        
        local s, h, t = LocalPlayer.state.stressLevel, LocalPlayer.state.hungerLevel, LocalPlayer.state.thirstLevel
        
        if s ~= nil and h ~= nil and t ~= nil then
            plyPed = PlayerPedId()
            local health = GetEntityHealth(plyPed) - 100
            local armor = GetPedArmour(plyPed)
            local stress = s / 100
            local oxy = GetPlayerUnderwaterTimeRemaining(plyId) * 10
            local hunger = round(h / 100, 0)
            local thirst = round(t / 100, 0)
            if stress > 100 then stress = 100 elseif stress < 0 then stress = 0 end
            if oxy > 100 then oxy = 100 elseif oxy < 0 then oxy = 0 end

            local showHealth, showArmor, showHunger, showThirst, showStress, showOxygen = true, true, true, true, true, true

            if stress < 10 then showStress = false end
            if oxy > 75 then showOxygen = false end

            pausemenuactive = IsPauseMenuActive()

            if disableHud then pausemenuactive = true end

            SendNUIMessage({
                update = "playerHud",
                showhud = not pausemenuactive,
                health = health,
                armor = armor,
                hunger = hunger,
                thirst = thirst,
                stress = stress,
                oxygen = oxy,
                showHealth = showHealth,
                showArmor = showArmor,
                showHunger = showHunger,
                showThirst = showThirst,
                showStress = showStress,
                showOxygen = showOxygen,
                showVoice = showVoice,
                KVPshowHealth = KVPshowHealth,
                KVPshowArmor = KVPshowArmor,
                KVPshowHunger = KVPshowHunger,
                KVPshowThirst = KVPshowThirst,
                KVPshowStress = KVPshowStress,
                KVPshowOxygen = KVPshowOxygen,
                KVPshowVoice = KVPshowVoice,            
                inVehicle = plyVehicle ~= 0,
                talking = NetworkIsPlayerTalking(plyId),
                radio = LocalPlayer.state.radioPressed
            })
        end
    end
end)

CreateThread(function()
    while true do
        Wait(15000)
        InvalidateIdleCam()
		InvalidateVehicleIdleCam()
    end
end)

function GetHud()
    data = {
        showHealth = GetResourceKvpInt('showHealth'),
        showArmor = GetResourceKvpInt('showArmor'),
        showHunger = GetResourceKvpInt('showHunger'),
        showThirst = GetResourceKvpInt('showThirst'),
        showStress = GetResourceKvpInt('showStress'),
        showOxygen = GetResourceKvpInt('showOxygen'),
        showVoice = GetResourceKvpInt('showVoice'),
        position = GetResourceKvpInt('position'),
        vPosition = GetResourceKvpInt('vPosition'),        
        showGear = GetResourceKvpInt('showGear'),        
        showDirection = GetResourceKvpInt('showDirection'),
        showLocation = GetResourceKvpInt('showLocation'),
        showFuel = GetResourceKvpInt('showFuel'),
        showSpeed = GetResourceKvpInt('showSpeed'),
        showSeatbelt = GetResourceKvpInt('showSeatbelt'),      
        showvCircle = GetResourceKvpInt('showvCircle'),
    }
    return data
end

RegisterNetEvent('togglehud')
AddEventHandler('togglehud', function(toggle)
    if (toggle == true or toggle ==  false) then
        disableHud = toggle
    else
        disableHud = not disableHud
    end
end)


exports('GetHud', GetHud) -- exports['erp_hud']:GetHud()

RegisterNetEvent('erp-voice:setTalkingMode')
AddEventHandler('erp-voice:setTalkingMode', function(mode)
    SendNUIMessage({
        update = "voiceMode",
        mode = mode
    })
end)

RegisterNetEvent('erp-voice:radioActive')
AddEventHandler('erp-voice:radioActive', function(talking)
    SendNUIMessage({
        update = "voiceMode",
        radio = talking
    })
end)
