--
-- @autor Tom Wießner
-- @date 25/06/20
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
--

alignment = alignment or {};
alignment.range = 3*3;
alignment.spiel = 0.07;

function alignment:load(dataTable)
    self.setAlignment        = VehicleManager:newFunction("setAlignment");
    
    self.sup1 = {};
    self.sup2 = {};
    self.sup3 = {};
    
    self.alignId        = getChild(self.id, "alignment");
    self.refPointHeight = dataTable.alignment.refPointHeight;
    
    self.sup1.id        = getChild(self.id, dataTable.alignment.support1.index);
    self.sup1.subId     = getChild(self.id, dataTable.alignment.support1.subIndex);
    self.sup1.refId     = getChild(self.id, dataTable.alignment.support1.refPointIndex);
    self.sup1.length    = dataTable.alignment.support1.length;
    self.sup1.subLength = dataTable.alignment.support1.subLength;
    self.sup1.maxLength = self.sup1.length + self.sup1.subLength;
    self.sup1.x, self.sup1.y, self.sup1.z = getPosition(self.sup1.id);
    
    self.sup2.id        = getChild(self.id, dataTable.alignment.support2.index);
    self.sup2.subId     = getChild(self.id, dataTable.alignment.support2.subIndex);
    self.sup2.refId     = getChild(self.id, dataTable.alignment.support2.refPointIndex);
    self.sup2.length    = dataTable.alignment.support2.length;
    self.sup2.subLength = dataTable.alignment.support2.subLength;
    self.sup2.maxLength = self.sup2.length + self.sup2.subLength;
    self.sup2.x, self.sup2.y, self.sup2.z = getPosition(self.sup2.id);
    
    self.sup3.id        = getChild(self.id, dataTable.alignment.support3.index);
    self.sup3.subId     = getChild(self.id, dataTable.alignment.support3.subIndex);
    self.sup3.refId     = getChild(self.id, dataTable.alignment.support3.refPointIndex);
    self.sup3.length    = dataTable.alignment.support3.length;
    self.sup3.subLength = dataTable.alignment.support3.subLength;
    self.sup3.maxLength = self.sup3.length + self.sup3.subLength;
    self.sup3.x, self.sup3.y, self.sup3.z = getPosition(self.sup3.id);
    
    self.state = false;
end;
 
function alignment:update(dt)
    if g_scenario == nil or g_scenario.player == nil or not g_scenario.player:getIsLocalPlayerEntered() then
		return nil;
    end;
    
    local player                    = g_scenario.player;
    local px,py,pz = getWorldPosition(self.id);
    local dx,dy,dz = px - player.x, py - player.y, pz - player.z;

    if player.isActive and self.attacherMasterVehicle == nil and (dx*dx + dy*dy + dz*dz) < alignment.range then
        g_GUI:addKeyHint(InputMapper.A3D_setCannonAlignState, l10n.get(self.state and "A3D_setCannonAlignFalse" or "A3D_setCannonAlignTrue"));
        
        if SufagDevRights:getKeyDown(InputMapper.A3D_setCannonAlignState) then          
            self:setAlignment(not self.state);
        end;
    end;
end;

function alignment:setAlignment(state, noEventSend)
    self.state = state;
    
    if state then
        local x1,y1,z1 = getWorldPosition(self.sup1.refId);
        local x2,y2,z2 = getWorldPosition(self.sup2.refId);
        local x3,y3,z3 = getWorldPosition(self.sup3.refId);
        
        local maxDist = math.max(y1,y2,y3) - math.min(y1,y2,y3);

        -- be sure that max support length is higher than the max distance between the 3 ref points
        if maxDist < self.sup1.maxLength then
            
            -- set cannon rotation to 0
            local rx, ry, rz = getWorldRotation(self.alignId);
            setWorldRotation(self.alignId, 0, ry, 0);
            
            -- update ref point position
            x1,y1,z1 = getWorldPosition(self.sup1.refId);
            x2,y2,z3 = getWorldPosition(self.sup2.refId);
            x3,y3,z3 = getWorldPosition(self.sup3.refId);
            
            -- lets set the cannon with one support to our heightest terrain height
            local h1 = Utils.sampleTerrainHeight(x1, z1);
            local h2 = Utils.sampleTerrainHeight(x2, z2);
            local h3 = Utils.sampleTerrainHeight(x3, z3);
            
            local tx, ty, tz = getWorldPosition(self.alignId);
            
            setWorldPosition(self.alignId, tx, math.max(h1, h2, h3) + (ty-y1), tz);
            
            -- now we´re moving the supports
            
            x1,y1,z1 = getWorldPosition(self.sup1.refId);
            x2,y2,z3 = getWorldPosition(self.sup2.refId);
            x3,y3,z3 = getWorldPosition(self.sup3.refId);
            
            local dif1, dif2, dif3 = y1 - h1 + alignment.spiel, y2 - h2 + alignment.spiel, y3 - h3 + alignment.spiel;
            if dif1 < 0 then dif1 = 0 end;
            if dif2 < 0 then dif2 = 0 end;
            if dif3 < 0 then dif3 = 0 end;
            
            if dif1 < math.abs(self.sup1.subLength) then
                setPositionY(self.sup1.id, 0);
                setPositionY(self.sup1.subId, 0);
                translate(self.sup1.subId, 0, -dif1, 0);
            else
                local newDif = dif1 - math.abs(self.sup1.subLength)
                setPositionY(self.sup1.id, 0);
                setPositionY(self.sup1.subId, 0);
                translate(self.sup1.subId, 0, -self.sup1.subLength, 0);
                translate(self.sup1.id, 0, -newDif, 0);
            end;
            
            
            
            if dif2 < math.abs(self.sup2.subLength) then
                setPositionY(self.sup2.id, 0);
                setPositionY(self.sup2.subId, 0);
                translate(self.sup2.subId, 0, -dif2, 0);
            else
                local newDif = dif2 - math.abs(self.sup2.subLength)
                setPositionY(self.sup2.id, 0);
                setPositionY(self.sup2.subId, 0);
                translate(self.sup2.subId, 0, -self.sup2.subLength, 0);
                translate(self.sup2.id, 0, -newDif, 0);
            end;
            
            if dif3 < math.abs(self.sup3.subLength) then
                setPositionY(self.sup3.id, 0);
                setPositionY(self.sup3.subId, 0);
                translate(self.sup3.subId, 0, -dif3, 0);
            else
                local newDif = dif3 - math.abs(self.sup3.subLength)
                setPositionY(self.sup3.id, 0);
                setPositionY(self.sup3.subId, 0);
                translate(self.sup3.subId, 0, -self.sup3.subLength, 0);
                translate(self.sup3.id, 0, -newDif, 0);
            end;
        else
            if not noEventSend then
                g_GUI:showPopup(l10n.get("A3D_Align_PopUp_Header"), l10n.get("A3D_Align_PopUp_Desc"),{	l10n.get("A3D_Align_PopUp_Button") },{	function() g_GUI:closeAllPopups(); end});
                self:setAlignment(false);
            end;
        end;
    else
        setRotation(self.alignId, 0, 0, 0);
        setPositionY(self.alignId, 0);
        setPositionY(self.sup1.subId, 0);
        setPositionY(self.sup2.subId, 0);
        setPositionY(self.sup3.subId, 0);
        setPosition(self.sup1.id, self.sup1.x, self.sup1.y, self.sup1.z);
        setPosition(self.sup2.id, self.sup2.x, self.sup2.y, self.sup2.z);
        setPosition(self.sup3.id, self.sup3.x, self.sup3.y, self.sup3.z);
    end;

    if not noEventSend then 
        SufagControlManagerBoolEvent:send(self, 5, state);
    end;
end;

function alignment:writeResync()
    streamWriteBool(self.state);
end;

function alignment:readResync()
    local state = streamReadBool() or false;
    self:setAlignment(state, true);
end;

function alignment:saveToTable(tbl)
    if tbl == nil then 
		return 
	end;
    tbl.A3D = tbl.A3D or {};
    tbl.A3D.alignState = self.state;
end;
 
function alignment:loadFromTable(tbl)
    if tbl == nil then 
		return 
	end;
    tbl.A3D = tbl.A3D or {};
    self:setAlignment(getNoNil(tbl.A3D.alignState, false));
end;
 
function alignment:destroy()
end;