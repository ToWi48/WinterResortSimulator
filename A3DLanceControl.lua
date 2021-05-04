-- @autor Tom Wießner
-- @date 19/06/20
--
-- BUILDVERSION: 221120
--              - Automatic
--              - GunLifter
--              - cannonRot
--              - visible
--              - Snowmaking Manager supported
--              - swivel funktion
--              - full remote control supported
--              - multiplayer supported
--
-- lastEdit: setPower (13/12/20 13:07)
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
--

SufagControlManager = SufagControlManager or {};
SufagControlManager.range = 2*2;
SufagControlManager.version = 11122020;

function SufagControlManager:load(dataTable)  
    SufagUI:load(self.bundleId);

    -- canvas
    self.updateUI   = VehicleManager:newFunction("updateUI");
    self.onEnter   = VehicleManager:newFunction("onEnter");
    self.onLeave   = VehicleManager:newFunction("onLeave");
    self.nonPlayerUpdate = VehicleManager:newFunction("nonPlayerUpdate");
    self.popupButtonText = SufagControlManager.popupButtonText;
    
    self.ui         = {};
    self.cannonSpec = {};
    self.ui.heat    = "Grey";
    self.ui.wind    = "Grey";
    self.ui.fan     = "Grey";
    self.ui.water   = "Grey";
    self.ui.snow    = "Grey";
    self.ui.swivel  = "Grey";
    
    -- general
    self.range                  = dataTable.SufagControlManager.controlRange or 2*2;
    self.lightId =                  getChild(self.id, dataTable.SufagControlManager.lightId);
    self.coverActiveId =            getChild(self.id, dataTable.SufagControlManager.coverActiveId);
    self.coverInactiveId =          getChild(self.id, dataTable.SufagControlManager.coverInactiveId);
    self.protectionId =             getChild(self.id, dataTable.SufagControlManager.protectionId);
    
    setActive(self.coverActiveId, false);
    setActive(self.coverInactiveId, true);
    
    -- remote
    self.snowCannonGroupId			 = 0;
    self.snowCannons                 = {};
    self.snowCannons[1]              = {};
        
    self.snowCannons[1].cameraId     = getChild(self.id, dataTable.remoteCameraIndex);
    self.snowCannons[1].isTurnedOn   = false;
    
    self.setIsCannonTurnedOn         = VehicleManager:newFunction("setIsCannonTurnedOn");
    self.setSnowCannonGroupId        = VehicleManager:newFunction("setSnowCannonGroupId");
    self.snowCannonRemoteCallback    = VehicleManager:newFunction("snowCannonRemoteCallback")
    self.snowCannonRemoteMove        = VehicleManager:newFunction("snowCannonRemoteMove")
    self.getSnowCannonRemoteButton   = SufagControlManager.getSnowCannonRemoteButton;
    
    -- movements
    self.setMovement                                                    = VehicleManager:newFunction("setMovement");
    
    self.cannonSpec.upId                                                = getChild(self.id, dataTable.SufagControlManager.cannonRot.upIndex);
    self.cannonSpec.leftId                                              = getChild(self.id, dataTable.SufagControlManager.cannonRot.leftIndex);
    self.cannonSpec.upTimer                                             = dataTable.SufagControlManager.cannonRot.upTimer;
    self.cannonSpec.leftTimer                                           = dataTable.SufagControlManager.cannonRot.leftTimer;
    self.isMobile                                                       = dataTable.SufagControlManager.isMobile or false;
    self.swivel                                                         = dataTable.SufagControlManager.swivel;
    self.swivelId                                                       = getChildAt(self.cannonSpec.leftId, 0);
    self.swivelX, self.swivelY, self.swivelZ                            = getRotation(self.swivelId);
    self.cannonRot                                                      = dataTable.SufagControlManager.cannonRot;
    self.cannonRot.difX, self.cannonRot.difY, self.cannonRot.difZ       = self.cannonRot.maxUp.x - self.cannonRot.minUp.x, self.cannonRot.maxUp.y - self.cannonRot.minUp.y, self.cannonRot.maxUp.z - self.cannonRot.minUp.z;
    self.cannonRot.difLX, self.cannonRot.difLY, self.cannonRot.difLZ    = self.cannonRot.maxLeft.x - self.cannonRot.minLeft.x, self.cannonRot.maxLeft.y - self.cannonRot.minLeft.y, self.cannonRot.maxLeft.z - self.cannonRot.minLeft.z;
    if not self.isMobile then
        self.gunLifter                                                  = dataTable.SufagControlManager.gunLifter;
        self.cannonSpec.id                                              = getChild(self.id, dataTable.SufagControlManager.gunLifter.index);
        local motorId                                                   = getChild(self.id, dataTable.SufagControlManager.gunLifter.motor);
        self.gunLifter.difX, self.gunLifter.difY, self.gunLifter.difZ   = self.gunLifter.endPos.x - self.gunLifter.startPos.x, self.gunLifter.endPos.y - self.gunLifter.startPos.y, self.gunLifter.endPos.z - self.gunLifter.startPos.z;
        self.cannonSpec.timer                                           = 0;
        self.cannonSpec.gunLifterSound                                  = Utils.loadBundleGameObject(self.bundleId, dataTable.SufagAutomatic.sounds.gunLifter);
        setParent(self.cannonSpec.gunLifterSound, motorId);
        setPosition(self.cannonSpec.gunLifterSound, 0,0,0);
        AudioSource.stop(self.cannonSpec.gunLifterSound);
    end;
    
    -- Automatic
    self.dur = {};
    self.sounds = {};
    self.particleSystems  = {};
    
    self.setKompressureSound    = VehicleManager:newFunction("setKompressureSound");
    self.setFanSound            = VehicleManager:newFunction("setFanSound");
    self.setWaterSound          = VehicleManager:newFunction("setWaterSound");
    self.setSnow                = VehicleManager:newFunction("setSnow");
    self.setCannonPowerState    = VehicleManager:newFunction("setCannonPowerState")
    self.setSwivelPeriodeAllowed = VehicleManager:newFunction("setSwivelPeriodeAllowed")
    self.setProtection          = VehicleManager:newFunction("setProtection")
    self.setCover               = VehicleManager:newFunction("setCover")
    self.setLight               = VehicleManager:newFunction("setLight")
    self.moveCannonLeft         = VehicleManager:newFunction("moveCannonLeft")
    self.moveCannonUp           = VehicleManager:newFunction("moveCannonUp")
    self.moveSwivelCannon       = VehicleManager:newFunction("moveSwivelCannon")
    self.moveGunLifter          = VehicleManager:newFunction("moveGunLifter")
    self.updateCurrentMode      = VehicleManager:newFunction("updateCurrentMode")

    self.demo                   = VehicleManager:newFunction("demo")


    self.convertToSyncro        = SufagControlManager.convertToSyncro;
    self.convertFromSyncro      = SufagControlManager.convertFromSyncro;

    self.dur.heating            = tonumber(dataTable.SufagAutomatic.dur.heating) * 1000;
    self.dur.startKompressure   = tonumber(dataTable.SufagAutomatic.dur.startKompressure) * 1000;
    self.dur.startFan           = tonumber(dataTable.SufagAutomatic.dur.startFan) * 1000;
    self.dur.startWater         = tonumber(dataTable.SufagAutomatic.dur.startWater) * 1000;
    self.dur.stopKompressure    = tonumber(dataTable.SufagAutomatic.dur.stopKompressure) * 1000;
    self.dur.stopFan            = tonumber(dataTable.SufagAutomatic.dur.stopFan) * 1000;
    self.dur.stopWater          = tonumber(dataTable.SufagAutomatic.dur.stopWater) * 1000;
    self.rayLength              = dataTable.SufagAutomatic.rayLength or 15;
    self.spreadFactor           = dataTable.SufagAutomatic.spreadFactor or 5;
    self.timeFactor             = dataTable.SufagAutomatic.timeFactor or 0.7;
    self.minSpreadRadius        = dataTable.SufagAutomatic.minSpreadRadius or 15;
    self.volumePerSecond        = (dataTable.SufagAutomatic.volumePerHour or 50)/3600; -- in m³ per hour
    self.pricePerCubic          = dataTable.SufagAutomatic.pricePerCubic or 1; -- should be a realistic value
    
    self.rotorId =                  getChild(self.id, dataTable.SufagAutomatic.rotorId);
    self.spawnId =                  getChild(self.id, dataTable.SufagAutomatic.spawnId);
    self.warnId =                   getChild(self.id, dataTable.SufagAutomatic.warnId);
    
    self.sounds.startKompressure  = Utils.loadBundleGameObject(self.bundleId, dataTable.SufagAutomatic.sounds.startKompressure);
    self.sounds.startFan          = Utils.loadBundleGameObject(self.bundleId, dataTable.SufagAutomatic.sounds.startFan);
    self.sounds.startWater        = Utils.loadBundleGameObject(self.bundleId, dataTable.SufagAutomatic.sounds.startWater);
    self.sounds.stopKompressure   = Utils.loadBundleGameObject(self.bundleId, dataTable.SufagAutomatic.sounds.stopKompressure);
    self.sounds.stopFan           = Utils.loadBundleGameObject(self.bundleId, dataTable.SufagAutomatic.sounds.stopFan);
    self.sounds.stopWater         = Utils.loadBundleGameObject(self.bundleId, dataTable.SufagAutomatic.sounds.stopWater);
    self.sounds.workKompressure   = Utils.loadBundleGameObject(self.bundleId, dataTable.SufagAutomatic.sounds.workKompressure);
    self.sounds.workFan           = Utils.loadBundleGameObject(self.bundleId, dataTable.SufagAutomatic.sounds.workFan);
    self.sounds.workWater         = Utils.loadBundleGameObject(self.bundleId, dataTable.SufagAutomatic.sounds.workWater);
    
    for _, str in pairs(dataTable.SufagAutomatic.particleSystems) do
        local particleId    = getChild(self.id, str);
        ParticleSystem.stop(particleId);
        table.insert(self.particleSystems, particleId);
    end;
    
    -- first settings
    
    setParent(self.sounds.startKompressure, self.cannonSpec.leftId);
    setParent(self.sounds.stopKompressure, self.cannonSpec.leftId);
    setParent(self.sounds.workKompressure, self.cannonSpec.leftId);
    setParent(self.sounds.startFan, self.rotorId);
    setParent(self.sounds.stopFan, self.rotorId);
    setParent(self.sounds.workFan, self.rotorId);
    setParent(self.sounds.startWater, self.spawnId);
    setParent(self.sounds.stopWater, self.spawnId);
    setParent(self.sounds.workWater, self.spawnId);
    
    setPosition(self.sounds.startKompressure, 0,0,0);
    setPosition(self.sounds.stopKompressure, 0,0,0);
    setPosition(self.sounds.workKompressure, 0,0,0);
    setPosition(self.sounds.startFan, 0,0,0);
    setPosition(self.sounds.stopFan, 0,0,0);
    setPosition(self.sounds.workFan, 0,0,0);
    setPosition(self.sounds.startWater, 0,0,0);
    setPosition(self.sounds.stopWater, 0,0,0);
    setPosition(self.sounds.workWater, 0,0,0);
    
    AudioSource.stop(self.sounds.startKompressure);
    AudioSource.stop(self.sounds.stopKompressure);
    AudioSource.stop(self.sounds.workKompressure);
    AudioSource.stop(self.sounds.startFan);
    AudioSource.stop(self.sounds.stopFan);
    AudioSource.stop(self.sounds.workFan);
    AudioSource.stop(self.sounds.startWater);
    AudioSource.stop(self.sounds.stopWater);
    AudioSource.stop(self.sounds.workWater);
    
    -- var
    self.getPower =                 true;
    self.swivelActive =             false;
    self.nextSwivelPeriodeAllowed = false;
    self.getIsPowerTurnOffAllowed = true;
    self.strobeFrequence =          1200;
    self.warnDur =                  100;
    self.sounds.kompressorMode =    0;
    self.sounds.fanMode =           0;
    self.sounds.waterMode =         0;
    self.currentMode =              "OFF";
    self.snowSpawning =             false;
    self.modeTimer =                0;
    self.strobeTimer =              0;
    self.swivelTimer   =            0;
    self.swivelStep        =        1;
    self.particleSystemsPlaying =   false;
    self.cumulatedVolume        =   0; -- cumulated volume of snow spawned already 
    self.isInRange        =         false;
    self.remoteMoveTower         =  false; 
    self.popUpIsOpen             =  false;
    self.lastGunLifterPosition   =  self.cannonSpec.timer;
    self.gunLifterRun            =  false;

    if self.getPower then SnowmakingManager:registerVehicle(self); SufagEnergy.currentItems = SufagEnergy.currentItems + 1; end;
end;

function SufagControlManager:demo(text)
    print(tostring(self.getPower) .. "/" .. text);
end;
 
function SufagControlManager:update(adt)
    local dt = tonumber(adt) * 1000;

    -- no matter what happens, first update the cannon! :)
    self:nonPlayerUpdate(dt, adt);

    -- ok, now we get the player input
    if g_scenario == nil or g_scenario.player == nil or not g_scenario.player:getIsLocalPlayerEntered() then
		return nil;
    end;

    local player = g_scenario.player;
    local px,py,pz = getWorldPosition(self.id);
    local dx,dy,dz = px - player.x, py - player.y, pz - player.z;

    -- render debug
    --SufagUI:setDebugValue(math.max(terrainDelta * self.spreadFactor, self.minSpreadRadius));
    
    if player.isActive and self.attacherMasterVehicle == nil and (dx*dx + dy*dy + dz*dz) < self.range then
        -- fixe UI Bug
        if SufagDevRights:getKeyDown(InputMapper.A3D_debugUI) then            
            SufagUI:debugUI();
        end;
        
        if not self.isInRange then self:onEnter(); self.isInRange = true end;

        
        g_GUI:addKeyHint(InputMapper.A3D_setCannonPowerState,    l10n.get(self.getPower and "A3D_setCannonPowerFalse" or "A3D_setCannonPowerTrue"));
        if SufagDevRights:getKeyDown(InputMapper.A3D_setCannonPowerState) then 
            self:setCannonPowerState(not self.getPower);
        end;
    
        if self.getPower then
			SufagUI:showCanvas(self.id, true, self.isMobile);
            if self.currentMode == "OFF" then
                g_GUI:addKeyHint(InputMapper.A3D_setCannonCoverState,       l10n.get(getActive(self.coverActiveId)  and "A3D_setCannonCoverFalse" or "A3D_setCannonCoverTrue"));
                if SufagDevRights:getKeyDown(InputMapper.A3D_setCannonCoverState) then 
                    self:setCover(not getActive(self.coverActiveId));
                end;
            end;
            
            if self.gunLifter ~= nil then
                if self.cannonSpec.timer == 0 then
                    g_GUI:addKeyHint(InputMapper.A3D_setCannonProtectionState,  l10n.get(getActive(self.protectionId)   and "A3D_setCannonProtectionFalse" or "A3D_setCannonProtectionTrue"));
                    if SufagDevRights:getKeyDown(InputMapper.A3D_setCannonProtectionState) then 
                        self:setProtection(not getActive(self.protectionId));
                    end;
                end;
            end;
            
            if not getActive(self.coverActiveId) then
                g_GUI:addKeyHint(InputMapper.A3D_setCannonLightState,       l10n.get(getActive(self.lightId)        and "A3D_setCannonLightFalse" or "A3D_setCannonLightTrue"));
                if SufagDevRights:getKeyDown(InputMapper.A3D_setCannonLightState) then 
                    self:setLight(not getActive(self.lightId));
                end;
            end;
            
            g_GUI:addKeyHint(InputMapper.A3D_setCannonSwivelState,       l10n.get(self.nextSwivelPeriodeAllowed        and "A3D_setCannonSwivelFalse" or "A3D_setCannonSwivelTrue"));
            if SufagDevRights:getKeyDown(InputMapper.A3D_setCannonSwivelState) then 
                self:setSwivelPeriodeAllowed(not self.nextSwivelPeriodeAllowed);
            end;
            
            -- Automatic
            if self.currentMode == "OFF" and not getActive(self.coverActiveId) then
                self.getIsPowerTurnOffAllowed = true;
                g_GUI:addKeyHint(InputMapper.A3D_setCannonAutomaticState,       l10n.get("A3D_setCannonAutomaticTrue"));
                if SufagDevRights:getKeyDown(InputMapper.A3D_setCannonAutomaticState) then 
                    self.getIsPowerTurnOffAllowed = false;
                    self:updateCurrentMode("HEATING");
                end;
            end;
            
            if self.currentMode == "ON" then
                g_GUI:addKeyHint(InputMapper.A3D_setCannonAutomaticState,       l10n.get("A3D_setCannonAutomaticFalse"));
                if SufagDevRights:getKeyDown(InputMapper.A3D_setCannonAutomaticState) then    
                    self:updateCurrentMode("STOP_WATER");
                end;
            end;
            
            -- GunLifter
            if not self.isMobile and not getActive(self.protectionId) then
                g_GUI:addDoubleKeyHint(InputMapper.A3D_moveGunLifterUp, InputMapper.A3D_moveGunLifterDown, l10n.get("A3D_moveGunLifterUpDown"));
                if SufagDevRights:getKey(InputMapper.A3D_moveGunLifterUp) then
                    self:moveGunLifter(clamp(self.cannonSpec.timer - dt, 0, self.gunLifter.duration));
                end;
                if SufagDevRights:getKey(InputMapper.A3D_moveGunLifterDown) then
                    self:moveGunLifter(clamp(self.cannonSpec.timer + dt, 0, self.gunLifter.duration));
                end;
            end;
            
            -- UpDown Cannon
            
            --g_GUI:addDoubleKeyHint(InputMapper.SnowCannon_RotateUp, InputMapper.SnowCannon_RotateDown, l10n.get("SnowCannon_RotateUpDown"));
            
            if SufagDevRights:getKey(InputMapper.SnowCannon_RotateUp) then            
                self:moveCannonUp(clamp(self.cannonSpec.upTimer + dt, 0, self.cannonRot.upDuration));
            end;
            
            if SufagDevRights:getKey(InputMapper.SnowCannon_RotateDown) then            
                self:moveCannonUp(clamp(self.cannonSpec.upTimer - dt, 0, self.cannonRot.upDuration));
            end;
            
            -- LeftRight Cannon
            
            --g_GUI:addDoubleKeyHint(InputMapper.SnowCannon_RotateLeft, InputMapper.SnowCannon_RotateRight, l10n.get("SnowCannon_RotateLeftRight"));
            
            if SufagDevRights:getKey(InputMapper.SnowCannon_RotateLeft) then            
                self:moveCannonLeft(clamp(self.cannonSpec.leftTimer + dt, 0, self.cannonRot.leftDuration));
            end;
            
            if SufagDevRights:getKey(InputMapper.SnowCannon_RotateRight) then            
                self:moveCannonLeft(clamp(self.cannonSpec.leftTimer - dt, 0, self.cannonRot.leftDuration));
            end;
        else
            SufagUI:showCanvas(self.id, false, self.isMobile);
        end;
    else
        if self.isInRange then self:onLeave(); self.isInRange = false end;
    end;
end;

function SufagControlManager:nonPlayerUpdate(dt, adt)
    -- non player input
    -- update gun lifter sound
    if self.cannonSpec.gunLifterSound ~= nil then
        if self.lastGunLifterPosition ~= self.cannonSpec.timer then
            if (self.cannonSpec.timer > 0) and (self.cannonSpec.timer < self.gunLifter.duration) then
                AudioSource.play(self.cannonSpec.gunLifterSound);
                self.gunLifterRun = true;
            else
                AudioSource.stop(self.cannonSpec.gunLifterSound);
                self.gunLifterRun = false;
            end;
            
            self.lastGunLifterPosition = self.cannonSpec.timer;
        else
            if self.gunLifterRun then
                AudioSource.stop(self.cannonSpec.gunLifterSound);
                self.gunLifterRun = false;
            end;
        end;
    end;

    if self.swivelActive then
        if self.nextSwivelPeriodeAllowed then
            self.ui.swivel  = "Green";
            self:updateUI(self.ui);
        else
            self.ui.swivel  = "Yellow";
            self:updateUI(self.ui);
        end;
        
        -- rotateToBase
        self.getIsPowerTurnOffAllowed = false;
        if self.swivel[self.swivelStep][1] > self.swivelTimer then
            setRotationY(self.swivelId, (self.swivelTimer / self.swivel[self.swivelStep][1]) * self.swivel[self.swivelStep][2] + self.swivelY);
            self:moveSwivelCannon(self.swivelTimer + dt);
        else
            if self.swivelStep < #self.swivel then
                self.swivelStep = self.swivelStep + 1;
            else
                if self.nextSwivelPeriodeAllowed then
                    self.swivelStep = 1;
                else
                    self.swivelActive = false;
                    self.getIsPowerTurnOffAllowed = true;
                    self.ui.swivel  = "Grey";
                    self:updateUI(self.ui);
                end;
            end;
            self.swivelX, self.swivelY, self.swivelZ = getRotation(self.swivelId);
            self:moveSwivelCannon(0);
        end;
    end;
    
    -- Automatic
    if self.currentMode == "OFF" then   
        self.snowCannons[1].isTurnedOn   = false;
        self:setKompressureSound(0);
        self:setFanSound(0);
        self:setWaterSound(0);
        
        self.ui.heat = "Grey";
        self.ui.wind = "Grey";
        self.ui.fan = "Grey";
        self.ui.water = "Grey";
        self.ui.snow = "Grey";
        self:updateUI(self.ui);
        
        self:setSnow(false);
        rotate(self.rotorId,0 ,0 , 0);
        
    elseif self.currentMode == "HEATING" then
        self.snowCannons[1].isTurnedOn   = true;
        self:setFanSound(0);
        self:setKompressureSound(0);
        self:setWaterSound(0);
        self:setSnow(false);
        rotate(self.rotorId,0 ,0 , 0);
        
        self.ui.heat = "Yellow";
        self.ui.wind = "Grey";
        self.ui.fan = "Grey";
        self.ui.water = "Grey";
        self.ui.snow = "Grey";
        self:updateUI(self.ui);

        if self.modeTimer < self.dur.heating then
            self.modeTimer = self.modeTimer + dt;
        else
            self.modeTimer = 0;
            self:updateCurrentMode("START_KOMPRESSURE");
        end;
        
    elseif self.currentMode == "START_KOMPRESSURE" then
        self.snowCannons[1].isTurnedOn   = true;
        self:setFanSound(0);
        self:setWaterSound(0);
        self:setSnow(false);
        rotate(self.rotorId,0 ,0 ,0);
        
        self.ui.heat = "Green";
        self.ui.wind = "Yellow";
        self.ui.fan = "Grey";
        self.ui.water = "Grey";
        self.ui.snow = "Grey";
        self:updateUI(self.ui);
        
        if self.modeTimer < self.dur.startKompressure then
            self.modeTimer = self.modeTimer + dt;
        
            if self.modeTimer < (AudioSource.getLength(self.sounds.startKompressure) * 1000) then
                self:setKompressureSound(1);
            else
                self:setKompressureSound(2);
            end;
        
        else
            self.modeTimer = 0;
            self:updateCurrentMode("START_FAN");
        end;
        
    elseif self.currentMode == "START_FAN" then
        self.snowCannons[1].isTurnedOn   = true;
        self:setKompressureSound(2);
        self:setWaterSound(0);
        self:setSnow(false);
        
        self.ui.heat = "Green";
        self.ui.wind = "Green";
        self.ui.fan = "Yellow";
        self.ui.water = "Grey";
        self.ui.snow = "Grey";
        self:updateUI(self.ui);
        
        if self.modeTimer < self.dur.startFan then
            self.modeTimer = self.modeTimer + dt;
      
            if self.modeTimer < (AudioSource.getLength(self.sounds.startFan) * 1000) then
                self:setFanSound(1);
                local factor = self.modeTimer / (AudioSource.getLength(self.sounds.startFan) * 1000);
                rotate(self.rotorId,0 ,0 , factor * -15);
            else
                self:setFanSound(2);
                rotate(self.rotorId,0 ,0 , -15);
            end;
        
        else
            self.modeTimer = 0;
            self:updateCurrentMode("START_WATER");
        end;
        
    elseif self.currentMode == "START_WATER" then
        self.snowCannons[1].isTurnedOn   = true;
        self:setFanSound(2);
        self:setKompressureSound(2);
        self:setSnow(false);
        rotate(self.rotorId,0 ,0 , -15);
        
        self.ui.heat = "Green";
        self.ui.wind = "Green";
        self.ui.fan = "Green";
        self.ui.water = "Yellow";
        self.ui.snow = "Grey";
        self:updateUI(self.ui);
        
        if self.modeTimer < self.dur.startWater then
            self.modeTimer = self.modeTimer + dt;
      
            if self.modeTimer >= (self.dur.startWater - (AudioSource.getLength(self.sounds.startWater) * 1000)) then
                self:setWaterSound(1);
            end;
        
        else
            self.modeTimer = 0;
            self:updateCurrentMode("ON");
        end;
        
    elseif self.currentMode == "ON" then
        self.snowCannons[1].isTurnedOn   = true;
        self:setFanSound(2);
        self:setKompressureSound(2);
        self:setWaterSound(2);
        
        self.ui.heat = "Green";
        self.ui.wind = "Green";
        self.ui.fan = "Green";
        self.ui.water = "Green";
        self.ui.snow = "Green";
        self:updateUI(self.ui);
        
        self:setSnow(true);
        rotate(self.rotorId,0 ,0 , -15);
        
    elseif self.currentMode == "STOP_WATER" then
        self.snowCannons[1].isTurnedOn   = false;
        self:setFanSound(2);
        self:setKompressureSound(2);
        rotate(self.rotorId,0 ,0 , -15);
        
        self.ui.heat = "Green";
        self.ui.wind = "Green";
        self.ui.fan = "Green";
        self.ui.water = "Yellow";
        self.ui.snow = "Green";
        self:updateUI(self.ui);
        
        if self.modeTimer < self.dur.stopWater then
            self.modeTimer = self.modeTimer + dt;
      
            if self.modeTimer >= (self.dur.stopWater - (AudioSource.getLength(self.sounds.stopWater) * 1000)) then
                self:setWaterSound(3);
            end;
        
        else
            self.modeTimer = 0;
            self:updateCurrentMode("STOP_FAN");
            
        end;
        
    elseif self.currentMode == "STOP_FAN" then
        self.snowCannons[1].isTurnedOn   = false;
        self:setKompressureSound(2);
        self:setWaterSound(0);
        self:setSnow(false);
        
        self.ui.heat = "Green";
        self.ui.wind = "Green";
        self.ui.fan = "Yellow";
        self.ui.water = "Grey";
        self.ui.snow = "Grey";
        self:updateUI(self.ui);
        
        if self.modeTimer < self.dur.stopFan then
            self.modeTimer = self.modeTimer + dt;
      
            if self.modeTimer >= (self.dur.stopFan - (AudioSource.getLength(self.sounds.stopFan) * 1000)) then
                self:setFanSound(3);
                local factor = 1 - (self.modeTimer - (self.dur.stopFan - (AudioSource.getLength(self.sounds.stopFan) * 1000))) / (AudioSource.getLength(self.sounds.stopFan) * 1000);
                rotate(self.rotorId,0 ,0 , factor * -15);
            else
                rotate(self.rotorId,0 ,0 , -15);
            end;
        else
            self.modeTimer = 0;
            self:updateCurrentMode("STOP_KOMPRESSURE");
        end;
        
    elseif self.currentMode == "STOP_KOMPRESSURE" then
        self.snowCannons[1].isTurnedOn   = false;
        self:setFanSound(0);
        self:setWaterSound(0);
        self:setSnow(false);
        rotate(self.rotorId,0 ,0 , 0);
        
        self.ui.heat = "Green";
        self.ui.wind = "Yellow";
        self.ui.fan = "Grey";
        self.ui.water = "Grey";
        self.ui.snow = "Grey";
        self:updateUI(self.ui);
        
        if self.modeTimer < self.dur.stopKompressure then
            self.modeTimer = self.modeTimer + dt;
      
            if self.modeTimer >= (self.dur.stopKompressure - (AudioSource.getLength(self.sounds.stopKompressure) * 1000)) then
                self:setKompressureSound(3);
            end;
        else
            self.modeTimer = 0;
            self:updateCurrentMode("OFF");
        end;  
        
    end;
    
    if ((self.currentMode ~= "OFF") and (self.currentMode ~= "ON")) or not SufagDevRights.isFree then
        
        if self.strobeTimer < self.strobeFrequence then
            self.strobeTimer = self.strobeTimer + dt;
            if self.strobeTimer < self.warnDur then
                setActive(self.warnId, true);
            else
                setActive(self.warnId, false);
            end;
        else
            self.strobeTimer = 0;
        end;
    else
        setActive(self.warnId, false);
    end;
    
    if self.snowSpawning then
        -- start playing the particle systems
        if not self.particleSystemsPlaying then
            for _, id in pairs(self.particleSystems) do
                ParticleSystem.play(id);
            end;
        end;
        if g_isMaster then    
            local x,y,z         = getWorldPosition(self.spawnId);
            local dx,dy,dz      = Utils.transformDirection(self.spawnId, 0,0,1); -- yeet snow in +Z direction
                
            local rayLength     = self.rayLength;
            x,y,z               = x + rayLength*dx, y + rayLength*dy, z + rayLength*dz;
            local terrainDelta  = y - Utils.sampleTerrainHeight(x, z);
    
            self.cumulatedVolume  = self.cumulatedVolume + self.volumePerSecond * GameplaySettings.snowmakingSpeedCoeff * adt;
    
            local spreadRadius  = math.max(terrainDelta * self.spreadFactor, self.minSpreadRadius);
            --local deltaHeight   = 0.7 * self.cumulatedVolume / (spreadRadius^1.6);
            local deltaHeight   = self.timeFactor * self.cumulatedVolume / (spreadRadius^1.6);
    
            if deltaHeight >= 10 * SnowSystem.SNOW_HEIGHTSTEP then
                local price     = self.cumulatedVolume * self.pricePerCubic;
                        
                if g_scenario:canAffordExpense(price) then
                    
                    SnowSystem.addSnowCircular(x, deltaHeight, z, spreadRadius);
                    g_scenario:addSnowmakingExpense(price);

                    if g_isServer then
                        EventAddSnowCircular:send(x, deltaHeight, z, spreadRadius);
                    end;
                else
                    self:updateCurrentMode("OFF");

                end;
                self.cumulatedVolume  = 0;
    
            end;
        end;
    end;
end;

function SufagControlManager:onEnter()
    if self.getPower then
        
        SufagUI:showCanvas(self.id, true, self.isMobile);
        self:updateUI(self.ui);
    end;
end;

function SufagControlManager:onLeave()
    SufagUI:showCanvas(self.id, false, self.isMobile);
    self:updateUI(self.ui);
end;

function SufagControlManager:setSnow(state)
    self.snowSpawning = state;
    if not state then
        for _, id in pairs(self.particleSystems) do
            ParticleSystem.stop(id);
        end;
        self.particleSystemsPlaying = false;
    end;
end;

function SufagControlManager:setKompressureSound(mode)
    if mode ~= self.sounds.kompressorMode then
        if mode == 1 then
            AudioSource.play(self.sounds.startKompressure);
            AudioSource.stop(self.sounds.stopKompressure);
            AudioSource.stop(self.sounds.workKompressure);
        elseif mode == 2 then
            AudioSource.play(self.sounds.workKompressure);
            AudioSource.stop(self.sounds.stopKompressure);
            AudioSource.stop(self.sounds.startKompressure);
        elseif mode == 3 then
            AudioSource.play(self.sounds.stopKompressure);
            AudioSource.stop(self.sounds.startKompressure);
            AudioSource.stop(self.sounds.workKompressure);
        elseif mode == 0 then
            AudioSource.stop(self.sounds.stopKompressure);
            AudioSource.stop(self.sounds.startKompressure);
            AudioSource.stop(self.sounds.workKompressure);
        end;
        self.sounds.kompressorMode = mode;
    end;
end;

function SufagControlManager:setFanSound(mode)
    if mode ~= self.sounds.fanMode then
        if mode == 1 then
            AudioSource.play(self.sounds.startFan);
            AudioSource.stop(self.sounds.stopFan);
            AudioSource.stop(self.sounds.workFan);
        elseif mode == 2 then
            AudioSource.play(self.sounds.workFan);
            AudioSource.stop(self.sounds.stopFan);
            AudioSource.stop(self.sounds.startFan);
        elseif mode == 3 then
            AudioSource.play(self.sounds.stopFan);
            AudioSource.stop(self.sounds.startFan);
            AudioSource.stop(self.sounds.workFan);
        elseif mode == 0 then
            AudioSource.stop(self.sounds.stopFan);
            AudioSource.stop(self.sounds.startFan);
            AudioSource.stop(self.sounds.workFan);
        end;
        self.sounds.fanMode = mode;
    end;
end;

function SufagControlManager:setWaterSound(mode)
    if mode ~= self.sounds.waterMode then
        if mode == 1 then
            AudioSource.play(self.sounds.startWater);
            AudioSource.stop(self.sounds.stopWater);
            AudioSource.stop(self.sounds.workWater);
        elseif mode == 2 then
            AudioSource.play(self.sounds.workWater);
            AudioSource.stop(self.sounds.stopWater);
            AudioSource.stop(self.sounds.startWater);
        elseif mode == 3 then
            AudioSource.play(self.sounds.stopWater);
            AudioSource.stop(self.sounds.startWater);
            AudioSource.stop(self.sounds.workWater);
        elseif mode == 0 then
            AudioSource.stop(self.sounds.stopWater);
            AudioSource.stop(self.sounds.startWater);
            AudioSource.stop(self.sounds.workWater);
        end;
        self.sounds.waterMode = mode;
    end;
end;

function SufagControlManager:setMovement(object)
    if object == "GunLifter" then
        local x = self.gunLifter.startPos.x + (self.cannonSpec.timer / self.gunLifter.duration) * self.gunLifter.difX;
        local y = self.gunLifter.startPos.y + (self.cannonSpec.timer / self.gunLifter.duration) * self.gunLifter.difY;
        local z = self.gunLifter.startPos.z + (self.cannonSpec.timer / self.gunLifter.duration) * self.gunLifter.difZ;
                
        setPosition(self.cannonSpec.id, x, y, z);
    end;
    
    if object == "cannonUp" then
        local x = self.cannonRot.minUp.x + (self.cannonSpec.upTimer / self.cannonRot.upDuration) * self.cannonRot.difX;
        local y = self.cannonRot.minUp.y + (self.cannonSpec.upTimer / self.cannonRot.upDuration) * self.cannonRot.difY;
        local z = self.cannonRot.minUp.z + (self.cannonSpec.upTimer / self.cannonRot.upDuration) * self.cannonRot.difZ;

        setRotation(self.cannonSpec.upId, x, y, z);
    end;
    
    if object == "cannonLeft" then
        local x = self.cannonRot.minLeft.x + (self.cannonSpec.leftTimer / self.cannonRot.leftDuration) * self.cannonRot.difLX;
        local y = self.cannonRot.minLeft.y + (self.cannonSpec.leftTimer / self.cannonRot.leftDuration) * self.cannonRot.difLY;
        local z = self.cannonRot.minLeft.z + (self.cannonSpec.leftTimer / self.cannonRot.leftDuration) * self.cannonRot.difLZ;
        
        setRotation(self.cannonSpec.leftId, x, y, z);
    end;
end;

function SufagControlManager:saveToTable(tbl)
    if tbl == nil then 
		return 
	end;
    
    tbl.A3D = tbl.A3D or {};
    tbl.A3D.SufagControlManager = tbl.A3D.SufagControlManager or {};
    tbl.A3D.SufagControlManager.getPower = self.getPower;
    tbl.A3D.SufagControlManager.automaticMode = self.currentMode;
    tbl.A3D.SufagControlManager.automaticTimer = self.modeTimer;
    
    tbl.A3D.SufagControlManager.nextSwivelPeriodeAllowed = self.nextSwivelPeriodeAllowed;
    tbl.A3D.SufagControlManager.protection = getActive(self.protectionId);
    tbl.A3D.SufagControlManager.coverActive = getActive(self.coverActiveId);
    tbl.A3D.SufagControlManager.coverInactive = getActive(self.coverInactiveId);
    tbl.A3D.SufagControlManager.light = getActive(self.lightId);
    
    if not self.isMobile then tbl.A3D.SufagControlManager.gunLifterTimer = self.cannonSpec.timer; end;
    tbl.A3D.SufagControlManager.cannonRotLeftTimer = self.cannonSpec.leftTimer;
    tbl.A3D.SufagControlManager.cannonRotUpTimer = self.cannonSpec.upTimer;
    tbl.A3D.SufagControlManager.snowCannonGroupId = self.snowCannonGroupId;
end;

function SufagControlManager:updateUI(ui)
    SufagUI:setIconState(self.id, "IMG_Heat", ui.heat);
    SufagUI:setIconState(self.id, "IMG_Wind", ui.wind);
    SufagUI:setIconState(self.id, "IMG_Fan", ui.fan);
    SufagUI:setIconState(self.id, "IMG_Water", ui.water);
    SufagUI:setIconState(self.id, "IMG_Snow", ui.snow);
    SufagUI:setIconState(self.id, "IMG_Swivel", ui.swivel);

    --if self.popUpIsOpen then self:snowCannonRemoteCallback() end;
end;

-- global menu
function SufagControlManager:getSnowCannonRemoteButton()
    return l10n.get("A3D_remote_cannon_info")
end;

function SufagControlManager:setIsCannonTurnedOn(index, state)
    if state then
        if self.currentMode == "OFF" then
            self.modeTimer = 0;
            self:updateCurrentMode("HEATING");
        end;
    else
        if self.currentMode == "ON" then
            self.modeTimer = 0;
            self:updateCurrentMode("STOP_WATER");
        end;
    end;
end;

function SufagControlManager:snowCannonRemoteCallback()
    if SufagDevRights.isFree then
        g_GUI:showPopup(l10n.get("A3D_remote_cannon_info_headline"), l10n.get("A3D_remote_cannon_info_desc"),
            {
                self:popupButtonText("mode"),
                self:popupButtonText("snow"),
                self:popupButtonText("swivel"),
                self:popupButtonText("light"),
                self:popupButtonText("protection"),
                self:popupButtonText("cover"),
                l10n.get("A3D_back"),
            },
            {
                -- mode
                function() 
                    if not self.isMobile then
                        self.remoteMoveTower = not self.remoteMoveTower;
                        self:snowCannonRemoteCallback();
                    end;
                end,
                -- snow
                function() 
                    if self.currentMode == "HEATING" and self.snowCannons[1].isTurnedOn then
                        self.modeTimer = 0;
                        self:updateCurrentMode("OFF");
                        self.snowCannons[1].isTurnedOn = false;
                    end;
                    
                    if self.currentMode == "ON" and self.snowCannons[1].isTurnedOn then
                        self.modeTimer = 0;
                        self:updateCurrentMode("STOP_WATER");
                        self.snowCannons[1].isTurnedOn = false;
                    end;
                    
                    if self.currentMode == "OFF" and not self.snowCannons[1].isTurnedOn then
                        self.modeTimer = 0;
                        self:updateCurrentMode("HEATING");
                        self.snowCannons[1].isTurnedOn = true;
                    end;
                    self:snowCannonRemoteCallback();
                end,
                -- swivel
                function() 
                    self:setSwivelPeriodeAllowed(not self.nextSwivelPeriodeAllowed);
                    self:snowCannonRemoteCallback();
                end,
                -- light
                function() 
                    if not getActive(self.coverActiveId) then
                        self:setLight(not getActive(self.lightId))
                        self:snowCannonRemoteCallback();
                    end;
                end,
                -- protection
                function() 
                    if self.gunLifter ~= nil then
                        if self.cannonSpec.timer == 0 then
                            self:setProtection(not getActive(self.protectionId));
                            self:snowCannonRemoteCallback();
                        end;
                    end;
                end,
                -- cover
                function() 
                    if self.currentMode == "OFF" then
                        self:setCover(not getActive(self.coverActiveId));
                        self:snowCannonRemoteCallback();
                    end;
                end,
                -- back
                function() 
                    --self.popUpIsOpen = false;
                    g_GUI:closeAllPopups(); 
                end,
            }
        );
    end;
    --self.popUpIsOpen = true;
end;

function SufagControlManager:popupButtonText(text)
    local back = "";

    if SufagDevRights.isFree then
        if text == "mode" then
            if self.isMobile then
                back = l10n.get("A3D_remote_cannon_info_btn_mobileOn");
            else
                back = l10n.get(self.remoteMoveTower and "A3D_remote_cannon_info_btn_mobileOff" or "A3D_remote_cannon_info_btn_mobileOn");
            end;
        elseif text == "snow" then
            back = l10n.get("A3D_remote_prepareStart");
            if self.currentMode == "HEATING" or self.currentMode == "ON" then 
                back = l10n.get("A3D_remote_stop");
            end;
            if self.currentMode == "STOP_WATER" or self.currentMode == "STOP_FAN" or self.currentMode == "STOP_KOMPRESSURE" then
                back = l10n.get("A3D_remote_prepareStop");
            end;
            if self.currentMode == "OFF" then
                back = l10n.get("A3D_remote_start");
            end;
        elseif text == "light" then
            back = l10n.get(getActive(self.lightId) and "A3D_remote_cannon_info_btn_lightOn" or "A3D_remote_cannon_info_btn_lightOff");
        elseif text == "protection" then
            back = l10n.get(getActive(self.protectionId) and "A3D_remote_cannon_info_btn_protectionOn" or "A3D_remote_cannon_info_btn_protectionOff");
        elseif text == "cover" then
            back = l10n.get(getActive(self.coverActiveId) and "A3D_remote_cannon_info_btn_coverOn" or "A3D_remote_cannon_info_btn_coverOff");
        elseif text == "swivel" then
            back = l10n.get(self.nextSwivelPeriodeAllowed and "A3D_remote_cannon_info_btn_swivelOn" or "A3D_remote_cannon_info_btn_swivelOff");
        end;
    else
        back = "locked";
    end;

    return back
end;

function SufagControlManager:onAttach()
    self:updateCurrentMode("OFF");
    self:setCannonPowerState(false);
end;

function SufagControlManager:setSnowCannonGroupId(groupId, noEventSend)
    if SufagDevRights.isFree then
        self.snowCannonGroupId			= math.max(groupId or 0, 0);
    end;

    if not noEventSend then
        SufagControlManagerIntEvent:send(self, 1, self.snowCannonGroupId);
    end;
end;

 function SufagControlManager:snowCannonRemoteMove(deltaX, deltaY)
    local dt						= 1/30 * 1000;
    
    if SufagDevRights.isFree then
        if not self.remoteMoveTower then
            self:moveCannonLeft(clamp(self.cannonSpec.leftTimer - (dt * deltaX), 0, self.cannonRot.leftDuration));
            
            self:moveCannonUp(clamp(self.cannonSpec.upTimer + (dt * deltaY), 0, self.cannonRot.upDuration));
        else
            if not getActive(self.protectionId) then
                self:moveGunLifter(clamp(self.cannonSpec.timer - (dt * deltaY * 2), 0, self.gunLifter.duration));
            end;
        end;
    end;
 end;
 
function SufagControlManager:loadFromTable(tbl)
    if tbl == nil then 
		return 
	end;

    if tbl.A3D == nil then return end;
    if tbl.A3D.SufagControlManager == nil then return end;
    
    self.getPower = getNoNil(tbl.A3D.SufagControlManager.getPower, self.getPower);
    
    if self.getPower then 
        SnowmakingManager:registerVehicle(self); 
        SufagEnergy.currentItems = SufagEnergy.currentItems + 1; 
    else
        SnowmakingManager:unregisterVehicle(self); 
        SufagEnergy.currentItems = SufagEnergy.currentItems - 1; 
    end;
    
    self:updateCurrentMode(getNoNil(tbl.A3D.SufagControlManager.automaticMode, self.currentMode));
    self.modeTimer = getNoNil(tbl.A3D.SufagControlManager.automaticTimer, self.modeTimer);
    
    setActive(self.protectionId, getNoNil(tbl.A3D.SufagControlManager.protection, true));
    setActive(self.coverActiveId, getNoNil(tbl.A3D.SufagControlManager.coverActive, false));
    setActive(self.coverInactiveId, getNoNil(tbl.A3D.SufagControlManager.coverInactive, true));
    setActive(self.lightId, getNoNil(tbl.A3D.SufagControlManager.light, false));
    
    self.nextSwivelPeriodeAllowed = getNoNil(tbl.A3D.SufagControlManager.nextSwivelPeriodeAllowed, self.nextSwivelPeriodeAllowed);
    if self.nextSwivelPeriodeAllowed then self.swivelActive = true end;
    
    if not self.isMobile then self.cannonSpec.timer = getNoNil(tbl.A3D.SufagControlManager.gunLifterTimer, self.cannonSpec.timer); self:setMovement("GunLifter"); end;
    self.cannonSpec.leftTimer = getNoNil(tbl.A3D.SufagControlManager.cannonRotLeftTimer, self.cannonSpec.leftTimer);
    self.cannonSpec.upTimer = getNoNil(tbl.A3D.SufagControlManager.cannonRotUpTimer, self.cannonSpec.upTimer);
    self.snowCannonGroupId = getNoNil(tbl.A3D.SufagControlManager.snowCannonGroupId, self.snowCannonGroupId);
    
    self:setMovement("cannonUp");
    self:setMovement("cannonLeft");
end;
 
function SufagControlManager:destroy()
    SufagUI:showCanvas(self.id, false, self.isMobile);
    SnowmakingManager:unregisterVehicle(self);
end;

function SufagControlManager:writeResync()
    streamWriteBool(self.getPower);
    streamWriteUInt8(self:convertToSyncro(self.currentMode));
    streamWriteFloat(self.modeTimer);

    streamWriteBool(self.nextSwivelPeriodeAllowed);
    streamWriteBool(getActive(self.protectionId));
    streamWriteBool(getActive(self.coverActiveId));
    streamWriteBool(getActive(self.coverInactiveId));
    streamWriteBool(getActive(self.lightId));

    if not self.isMobile then streamWriteFloat(self.cannonSpec.timer); end;

    streamWriteFloat(self.cannonSpec.leftTimer);
    streamWriteFloat(self.cannonSpec.upTimer);
    streamWriteUInt8(self.snowCannonGroupId);
end;

function SufagControlManager:readResync()
    self.getPower = streamReadBool(self.getPower);

    if self.getPower then 
        SnowmakingManager:registerVehicle(self); 
        SufagEnergy.currentItems = SufagEnergy.currentItems + 1; 
    else
        SnowmakingManager:unregisterVehicle(self); 
        SufagEnergy.currentItems = SufagEnergy.currentItems - 1; 
    end;

    self.currentMode = self:convertFromSyncro(streamReadUInt8(self.currentMode));
    self.modeTimer = streamReadFloat(self.modeTimer);

    self.nextSwivelPeriodeAllowed = streamReadBool(self.nextSwivelPeriodeAllowed);
    if self.nextSwivelPeriodeAllowed then self.swivelActive = true end;

    setActive(self.protectionId, streamReadBool(getActive(self.protectionId)));
    setActive(self.coverActiveId, streamReadBool(getActive(self.coverActiveId)));
    setActive(self.coverInactiveId, streamReadBool(getActive(self.coverInactiveId)));
    setActive(self.lightId, streamReadBool(getActive(self.lightId)));

    if not self.isMobile then self.cannonSpec.timer = streamReadFloat(self.cannonSpec.timer); end;

    self.cannonSpec.leftTimer = streamReadFloat(self.cannonSpec.leftTimer);
    self.cannonSpec.upTimer = streamReadFloat(self.cannonSpec.upTimer);
    self.snowCannonGroupId = streamReadUInt8(self.snowCannonGroupId);

    self:setMovement("cannonUp");
    self:setMovement("cannonLeft");
end;


function SufagControlManager:convertFromSyncro(mode)
    local back = "OFF";
    if mode == 0 then
      back = "OFF";
    elseif mode == 1 then
      back = "HEATING";
    elseif mode == 2 then
      back = "START_KOMPRESSURE";
    elseif mode == 3 then
      back = "START_FAN";
    elseif mode == 4 then
      back = "START_WATER";
    elseif mode == 5 then
      back = "ON";
    elseif mode == 6 then
      back = "STOP_WATER";
    elseif mode == 7 then
      back = "STOP_FAN";
    elseif mode == 8 then
      back = "STOP_KOMPRESSURE";
    end;
    return back
  end;
  
  function SufagControlManager:convertToSyncro(get)
    local mode = 0;
    if get == "OFF" then
      mode = 0;
    elseif get == "HEATING" then
      mode = 1;
    elseif get == "START_KOMPRESSURE" then
      mode = 2;
    elseif get == "START_FAN" then
      mode = 3;
    elseif get == "START_WATER" then
      mode = 4;
    elseif get == "ON" then
      mode = 5;
    elseif get == "STOP_WATER" then
      mode = 6;
    elseif get == "STOP_FAN" then
      mode = 7;
    elseif get == "STOP_KOMPRESSURE" then
      mode = 8;
    end;
    return mode
  end;

  -- sync all booleans
  function SufagControlManager:setCannonPowerState(state, noEventSend)
    self.getPower = state;
    if self.getPower then
        SnowmakingManager:registerVehicle(self);
        SufagEnergy.currentItems = SufagEnergy.currentItems + 1;
    else
        self.currentMode = "OFF";
        self.nextSwivelPeriodeAllowed = false;
        self.swivelActive = false;
        self.swivelTimer = 0;
        self.swivelStep = 1;
        self.ui.swivel  = "Grey";
        self:updateUI(self.ui);

        setActive(self.lightId, false);

        SnowmakingManager:unregisterVehicle(self);
        SufagEnergy.currentItems = SufagEnergy.currentItems - 1;
    end;

    if not noEventSend then 
        SufagControlManagerBoolEvent:send(self, 0, state);
    end;
  end;

  function SufagControlManager:setSwivelPeriodeAllowed(state, noEventSend)
    self.nextSwivelPeriodeAllowed = state;
    if not self.swivelActive then self.swivelActive = true end;

    if not noEventSend then 
        SufagControlManagerBoolEvent:send(self, 1, state);
    end;
  end;

  function SufagControlManager:setProtection(state, noEventSend)
    setActive(self.protectionId, state);

    if not noEventSend then 
        SufagControlManagerBoolEvent:send(self, 2, state);
    end;
  end;

  function SufagControlManager:setCover(state, noEventSend)
    setActive(self.coverActiveId, state);
    setActive(self.coverInactiveId, not state);
    setActive(self.lightId, false);

    if not noEventSend then 
        SufagControlManagerBoolEvent:send(self, 3, state);
    end;
  end;

  function SufagControlManager:setLight(state, noEventSend)
    setActive(self.lightId, state);

    if not noEventSend then 
        SufagControlManagerBoolEvent:send(self, 4, state);
    end;
  end;

  -- sync all timers
function SufagControlManager:moveCannonLeft(time, noEventSend)
    self.cannonSpec.leftTimer = time;
    self:setMovement("cannonLeft");

    if not noEventSend then
        SufagControlManagerTimerEvent:send(self, 0, self.cannonSpec.leftTimer);
    end;
end;

function SufagControlManager:moveCannonUp(time, noEventSend)
    self.cannonSpec.upTimer = time;
    self:setMovement("cannonUp");

    if not noEventSend then
        SufagControlManagerTimerEvent:send(self, 1, self.cannonSpec.upTimer);
    end;
end;

function SufagControlManager:moveSwivelCannon(time, noEventSend)
    self.swivelTimer = time;

    if not noEventSend then
        --SufagControlManagerTimerEvent:send(self, 2, self.swivelTimer);
    end;
end;

function SufagControlManager:moveGunLifter(time, noEventSend)
    self.cannonSpec.timer = time;
    self:setMovement("GunLifter");

    if not noEventSend then
        SufagControlManagerTimerEvent:send(self, 3, self.cannonSpec.timer);
    end;
end;

-- sync int values
function SufagControlManager:updateCurrentMode(mode, noEventSend)
    -- if type(newMode) == "number" then
    --     self.currentMode = self:convertFromSyncro(newMode);
    -- else
    --     self.currentMode = newMode;
    -- end;

    local setMode = "OFF";
	if type(mode) == "number" then
		setMode = self:convertFromSyncro(mode);
	elseif type(mode) == "string" then
		setMode = tostring(mode);
	else
		print("SUFAGControl::changeMode - mode argument is unassignable");
	end;
    
    if self.currentMode ~= setMode then
        self.modeTimer = 0;
    end;
    
    self.currentMode = setMode;  

    if not noEventSend then
        SufagControlManagerIntEvent:send(self, 0, self:convertToSyncro(setMode)); 
    end;
end;