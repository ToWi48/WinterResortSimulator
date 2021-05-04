--
-- @autor Tom Wießner
-- @date 15/01/21
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
--

ASCTimer = ASCTimer or {};

function ASCTimer:load(tbl)
    self.getTimer = VehicleManager:newFunction("getTimer");
    self.ASCTimers = {};
end;

function ASCTimer:getTimer(name, dur)
    if self.ASCTimers[name] == nil then
        self.ASCTimers[name] = {};
        self.ASCTimers[name].dur = dur or 0;
        self.ASCTimers[name].time = 0;
        self.ASCTimers[name].isReleased = false;
    end;

    if self.ASCTimers[name].isReleased then
        --self.ASCTimers[name] = nil;
        return true;
    end;

    return false;
end;

function ASCTimer:removeTimer(name)
    self.ASCTimers[name] = nil;
end;
 
function ASCTimer:update(dt)
    for k,v in pairs(self.ASCTimers) do
        if v.time < v.dur then
            v.time = v.time + dt;
        else
            v.isReleased = true;
        end;
    end;
end;
 
function ASCTimer:destroy()
end;