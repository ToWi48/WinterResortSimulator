--
-- @autor Tom Wießner
-- @date 23/11/20
--
-- BUILDVERSION: 231120
--              - multiplayer supported
--
-- lastEdit: saveable (23/11/20 02:32)
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
-- 

-- sync booleans
--print("A3D::LoadNetworkEvents");
--print("A3D::Note: First functional test of Sufag multiplayer support. This could not be tested before and may cause deeper errors in the gameplay. In case of obvious errors please send a short message to Tom Wießner (ToWi48). We all want a stable game, even with mods.");
SufagControlManagerBoolEvent				= SufagControlManagerBoolEvent or ExtensionOf(BaseEvent);

InitModEvent(SufagControlManagerBoolEvent, "SufagControlManagerBoolEvent");

function SufagControlManagerBoolEvent:sendData(entity, key, value)
	streamWriteEntityId(entity);

	--streamBeginWriteBitwise();
	streamWriteUInt8(key);
	--streamEndWriteBitwise();

	streamWriteBool(value);
end;

function SufagControlManagerBoolEvent:receiveData(connection)
	local entity					= streamReadEntityId();

	--streamBeginReadBitwise();
	local key						= streamReadUInt8();
	--streamEndReadBitwise();

	local value					= streamReadBool();
	if entity ~= nil then
		if key == 0 then
			entity:setCannonPowerState(value, true);
		elseif key == 1 then
			entity:setSwivelPeriodeAllowed(value, true);
		elseif key == 2 then
			entity:setProtection(value, true);
		elseif key == 3 then
			entity:setCover(value, true);
		elseif key == 4 then
			entity:setLight(value, true);
		elseif key == 5 then
			entity:setAlignment(value, true);
		end;
	end;

	self:broadcastEvent(connection, entity, key, value);
end;

-- sync int
SufagControlManagerIntEvent				= SufagControlManagerIntEvent or ExtensionOf(BaseEvent);
InitModEvent(SufagControlManagerIntEvent, "SufagControlManagerIntEvent");

function SufagControlManagerIntEvent:sendData(entity, key, value)
	streamWriteEntityId(entity);

	--streamBeginWriteBitwise();
	streamWriteUInt8(key);
	--streamEndWriteBitwise();

	streamWriteUInt8(value);
end;

function SufagControlManagerIntEvent:receiveData(connection)
	local entity					= streamReadEntityId();

	--streamBeginReadBitwise();
	local key						= streamReadUInt8();
	--streamEndReadBitwise();

	local value					= streamReadUInt8();
	if entity ~= nil then
		if key == 0 then
			entity:updateCurrentMode(value, true);
		elseif key == 1 then
			entity:setSnowCannonGroupId(value, true);
		end;
	end;

	self:broadcastEvent(connection, entity, key, value);
end;

-- sync timer
SufagControlManagerTimerEvent				= SufagControlManagerTimerEvent or ExtensionOf(BaseEvent);
InitModEvent(SufagControlManagerTimerEvent, "SufagControlManagerTimerEvent");

function SufagControlManagerTimerEvent:sendData(entity, key, value)
	streamWriteEntityId(entity);

	--streamBeginWriteBitwise();
	streamWriteUInt8(key);
	--streamEndWriteBitwise();

	streamWriteFloat(value);
end;

function SufagControlManagerTimerEvent:receiveData(connection)
	local entity					= streamReadEntityId();

	--streamBeginReadBitwise();
	local key						= streamReadUInt8();
	--streamEndReadBitwise();

	local value					= streamReadFloat();
	if entity ~= nil then
		if key == 0 then
			entity:moveCannonLeft(value, true);
		elseif key == 1 then
			entity:moveCannonUp(value, true);
		elseif key == 2 then
			entity:moveSwivelCannon(value, true);
		elseif key == 3 then
			entity:moveGunLifter(value, true);
		end;
	end;

	self:broadcastEvent(connection, entity, key, value);
end;