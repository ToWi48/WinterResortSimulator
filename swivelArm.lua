-- autor Tom Wiessner
-- date 29/03/21
--
-- change active state of a protection 
--
--InputMapper:addKey("SnowCannon", "Protection", "Y");

swivelArm = swivelArm or {};

swivelArm.range = 2*2;

function swivelArm:load(dataTable)
    -- wird gekauft
    self.svamSetMovement = VehicleManager:newFunction("svamSetMovement");
    self.svamMove = VehicleManager:newFunction("svamMove");

    self.svamUpId = getChild(self.id, dataTable.swivelArm.upIndex);
    self.svamLeftId = getChild(self.id, dataTable.swivelArm.leftIndex);

    self.svamUpMinPos = dataTable.swivelArm.upMinPos --or {0,0,0};
    self.svamUpMaxPos = dataTable.swivelArm.upMaxPos --or {0,0,0};

    self.svamLeftMinPos = dataTable.swivelArm.leftMinPos --or {0,0,0};
    self.svamLeftMaxPos = dataTable.swivelArm.leftMaxPos --or {0,0,0};

    self.svamUpDur = dataTable.swivelArm.upDur --or 3;
    self.svamLeftDur = dataTable.swivelArm.leftDur --or 3;

    self.svamPlatformId = getChild(self.id, dataTable.swivelArm.platformIndex);
    self.svamPlatformAxis = dataTable.swivelArm.platformAxis -- or 1;

    self.svamUpTime = 0;
    self.svamLeftTime = 0;
    self.svamIsActive = false;
end;

function swivelArm:update(dt)
    -- ok, now we get the player input
    if g_scenario == nil or g_scenario.player == nil or not g_scenario.player:getIsLocalPlayerEntered() then
		return nil;
    end;
    
    local player                    = g_scenario.player;
    local px,py,pz = getWorldPosition(self.id);
    local dx,dy,dz = px - player.x, py - player.y, pz - player.z;

    if player.isActive and self.attacherMasterVehicle == nil and (dx*dx + dy*dy + dz*dz) < swivelArm.range then
        -- up
        g_GUI:addDoubleKeyHint(InputMapper.A3D_SwivelUp, InputMapper.A3D_SwivelDown, l10n.get("A3D_SwivelUpDown"));
            
        if SufagDevRights:getKey(InputMapper.A3D_SwivelUp) then 
            self:svamMove(1, clamp(self.svamUpTime + dt, 0, self.svamUpDur));
        end;

        if SufagDevRights:getKey(InputMapper.A3D_SwivelDown) then 
            self:svamMove(1, clamp(self.svamUpTime - dt, 0, self.svamUpDur));
        end;

        -- left
        g_GUI:addDoubleKeyHint(InputMapper.A3D_SwivelLeft, InputMapper.A3D_SwivelRight, l10n.get("A3D_SwivelLeftRight"));
            
        if SufagDevRights:getKey(InputMapper.A3D_SwivelLeft) then 
            self:svamMove(2, clamp(self.svamLeftTime + dt, 0, self.svamLeftDur));
        end;

        if SufagDevRights:getKey(InputMapper.A3D_SwivelRight) then 
            self:svamMove(2, clamp(self.svamLeftTime - dt, 0, self.svamLeftDur));
        end;
    end;
end;

function swivelArm:svamMove(index, time, noEventSend)
    self:svamSetMovement(index, time);

    if not noEventSend then
        swivelArmEvent:send(self, index, time);
    end;
end;

function swivelArm:svamSetMovement(index, time)
    if index == 1 then
        -- up 
        self.svamUpTime = time;
        local factor = time / self.svamUpDur;
        local dx = self.svamUpMaxPos[1] - self.svamUpMinPos[1];
        local dy = self.svamUpMaxPos[2] - self.svamUpMinPos[2];
        local dz = self.svamUpMaxPos[3] - self.svamUpMinPos[3];
        setRotation(self.svamUpId, self.svamUpMinPos[1] + factor * dx, self.svamUpMinPos[2] + factor * dy, self.svamUpMinPos[3] + factor * dz);
        -- platformIndex
        local x,y,z = getWorldRotation(self.svamPlatformId);

        if self.svamPlatformAxis == 1 then
            setWorldRotation(self.svamPlatformId, 0,y,z);
        elseif self.svamPlatformAxis == 2 then
            setWorldRotation(self.svamPlatformId, x,0,z);
        else
            setWorldRotation(self.svamPlatformId, x,y,0);
        end;
    else
        -- left 
        self.svamLeftTime = time;
        local factor = time / self.svamLeftDur;
        local dx = self.svamLeftMaxPos[1] - self.svamLeftMinPos[1];
        local dy = self.svamLeftMaxPos[2] - self.svamLeftMinPos[2];
        local dz = self.svamLeftMaxPos[3] - self.svamLeftMinPos[3];
        setRotation(self.svamLeftId, self.svamLeftMinPos[1] + factor * dx, self.svamLeftMinPos[2] + factor * dy, self.svamLeftMinPos[3] + factor * dz);
    end
end;

function swivelArm:destroy()
    -- wird verkauft
end;

function swivelArm:writeResync()
    streamWriteFloat(self.svamUpTime);
    streamWriteFloat(self.svamLeftTime);
end;

function swivelArm:readResync()
    local up = streamReadFloat();
    local left = streamReadFloat();
    self:svamMove(1, up, true);
    self:svamMove(2, left, true);
end;

function swivelArm:saveToTable(tbl)
    if tbl == nil then 
        return 
    end;

    tbl.svivelArm = {};
    tbl.svivelArm.up = self.svamUpTime;
    tbl.svivelArm.left = self.svamleftTime;
end;

function swivelArm:loadFromTable(tbl)
    if tbl == nil then 
        return 
    end;
    
    if tbl.svivelArm == nil then return end;
    local up = tbl.svivelArm.up;
    local left = tbl.svivelArm.left;
    self:svamMove(1, up, true);
    self:svamMove(2, left, true);
end;

-- begin of swivelArm Event
swivelArmEvent				= swivelArmEvent or ExtensionOf(BaseEvent);

InitModEvent(swivelArmEvent, "swivelArmEvent");

function swivelArmEvent:sendData(entity, index, time)
	streamWriteEntityId(entity);
    streamWriteUInt8(index);
	streamWriteFloat(time);
end;

function swivelArmEvent:receiveData(connection)
	local entity				= streamReadEntityId();
	local key					= streamReadUInt8();
    local value					= streamReadFloat();

    entity:swapswivelArm(key, value, true);

	self:broadcastEvent(connection, entity, key, value);
end;

