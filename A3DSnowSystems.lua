--
-- @autor Tom Wießner
-- @date 17/01/21
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
--

A3DSnowSystems = A3DSnowSystems or {};

function A3DSnowSystems:load(tbl)
    local scripts = A3D.saveNav(tbl, "tbl.snow.modules", true);
    for k,v in pairs(scripts) do
        self:addVehicleScript(scripts);
        print('A3DSnowSystems:: added module "' .. k .. '"');
    end;
end;
 
function A3DSnowSystems:update(dt)
end;
 
function A3DSnowSystems:destroy()
end;