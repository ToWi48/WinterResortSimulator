-- autor Tom Wiessner
-- date 20/01/21
--
-- change active state of a protection 
--
--InputMapper:addKey("SnowCannon", "Protection", "Y");

visible = visible or {};

function visible:load(tbl)
    -- wird gekauft
    self.swapVisible = VehicleManager:newFunction("swapVisible");

    if tbl.visible == nil then
        tbl.visible = {};
        print("missing id from protection");
    end;

    self.protectionId = getChild(self.id, tbl.visible.index or "");
    self.range = self.range or 2*2;
end;

function visible:update(dt)
    -- wurde gekauft
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
        --g_GUI:addKeyHint(InputMapper.Protection, "Matte ein/aus");
        g_GUI:addKeyHint(InputMapper.A3D_setCannonProtectionState,  l10n.get(getActive(self.protectionId) and "A3D_setCannonProtectionFalse" or "A3D_setCannonProtectionTrue"));
        if SufagDevRights:getKeyDown(InputMapper.A3D_setCannonProtectionState) then 
            self:swapVisible(not getActive(self.protectionId));
        end;
    end;
end;

function visible:destroy()
    -- wird verkauft
end;

function visible:swapVisible(state, noEventSend)
    setActive(self.protectionId, state or false);
    if not noEventSend then 
        visibleEvent:send(self, state);
    end;
end;

function visible:writeResync()
    local state = getActive(self.protectionId);
    streamWriteBool(state);
end;

function visible:readResync()
    local state = streamReadBool() or false;
    self:swapVisible(state, true);
end;

function visible:saveToTable(tbl)
    if tbl == nil then 
        return 
    end;

    tbl.protection = getActive(self.protectionId);
end;

function visible:loadFromTable(tbl)
    if tbl == nil then 
        return 
    end;

    self:swapVisible(tbl.protection or false);
end;

-- begin of visible Event
visibleEvent				= visibleEvent or ExtensionOf(BaseEvent);

InitModEvent(visibleEvent, "visibleEvent");

function visibleEvent:sendData(entity, state)
	streamWriteEntityId(entity);
	streamWriteBool(state);
end;

function visibleEvent:receiveData(connection)
	local entity				= streamReadEntityId();
	local value					= streamReadBool();

    entity:swapVisible(value, true);

	self:broadcastEvent(connection, entity, value);
end;

