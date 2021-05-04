--
-- @author Tom Wiessner
-- @date 10/06/20
--
-- A3DBaseSystem
-- Modul MainArchitecture
-- 
-- using only with premission by Tom Wießner
-- only DLC Using allowed
--

A3DBaseSystem = A3DBaseSystem or {};
A3DBaseSystem.isLoaded = false;

A3DBaseSystem.extraSources = A3DBaseSystem.extraSources or {};

function A3DBaseSystem:addExtraSource(data)
    table.insert(A3DBaseSystem.extraSources, data);
    print("added extra source")
end;

function A3DBaseSystem:load()
    print("A3DSystems::loaded with " .. tostring(#A3DBaseSystem.extraSources) .. " extra sources");
end;

function A3DBaseSystem:update(dt)   
    if not A3DBaseSystem.isLoaded and g_scenario ~= nil then
        for k,v in pairs(A3DBaseSystem.extraSources) do
            v:load();
        end;
        A3DBaseSystem:load();
        A3DBaseSystem.isLoaded = true;
    end;
    if A3DBaseSystem.isLoaded and g_scenario ~= nil then
        for k,v in pairs(A3DBaseSystem.extraSources) do
            v:update(dt);
        end;
    end;
end;

function A3DBaseSystem:destroy()
end;

local BaseScenario_onCloseGameByUI = BaseScenario.onCloseGameByUI;
BaseScenario.onCloseGameByUI = function(...)
    for k,v in pairs(A3DBaseSystem.extraSources) do
        v:destroy();
    end;
    A3DBaseSystem:destroy();
    BaseScenario_onCloseGameByUI(...);
end;

addUpdateable(A3DBaseSystem);