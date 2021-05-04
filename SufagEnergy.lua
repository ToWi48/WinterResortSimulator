--
-- @autor Tom Wießner
-- @date 29/06/20
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
--

SufagEnergy = SufagEnergy or {};
SufagEnergy.currentItems = 0;
SufagEnergy.dailyCosts = 30;

local BaseEcoSystem_dailyUpdate = BaseEcoSystem.dailyUpdate;
BaseEcoSystem.dailyUpdate = function(...)
    BaseEcoSystem_dailyUpdate(...);
    g_scenario:addSnowmakingExpense(SufagEnergy.dailyCosts * SufagEnergy.currentItems);
end;