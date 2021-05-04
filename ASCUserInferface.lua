--
-- @autor Tom Wießner
-- @date 11/01/21
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
--

ASCMovementManager = ASCMovementManager or {};

movement = {
    animation = false,
    index = "",
    mode = "rot",
    speed = 5,
    steps = {
        min = {x=0, y=0, z=0},
        max = {x=1, y=1, z=1},
    }
}

movement = {
    animation = true,
    index = "",
    mode = "rot",
    steps = {
        {speed=5, x=0, y=0, z=0},
        {speed=5, x=1, y=1, z=1},
    }
}

function ASCMovementManager:load(tbl)
    self.registerMovement      = VehicleManager:newFunction("registerMovement");
    self.movements = {};
    self.currentJobsToMove = {};
    self.currentJobsToPressedMove = {};
end;

function ASCMovementManager:registerMovement(name, tbl)
    tbl.animation = tbl.animation or false;

    if tbl.animation then
        self.movements[name] = {};
        self.movements[name].id = A3D.debugLoad3D(tbl, "tbl.index", self.id);
        self.movements[name].animation = tbl.animation or false;
        self.movements[name].mode = tbl.mode or "rot";
        self.movements[name].currentStep = tbl.startStep or 1;
        self.movements[name].steps = tbl.steps;
    elseif not tbl.animation then
        self.movements[name] = {};
        self.movements[name].id = A3D.debugLoad3D(tbl, "tbl.index", self.id);
        self.movements[name].animation = tbl.animation or false;
        self.movements[name].mode = tbl.mode or "rot";
        self.movements[name].time = 0;
        self.movements[name].steps = tbl.steps;
    end;
end;

function ASCMovementManager:playAnimation(name, dir)
    if self.movements[name] ~= nil then
        if self.movements[name].animation and self.currentJobsToMove[name] == nil then
            self.currentJobsToMove[name].toStep = self.movements[name].steps[self.movements[name].currentStep + dir];
            self.currentJobsToMove[name].fromStep = self.movements[name].steps[self.movements[name].currentStep];
            self.currentJobsToMove[name].id = self.movements[name].id;
            self.currentJobsToMove[name].timer = 0;
        end;

        if not self.movements[name].animation then
            self.currentJobsToPressedMove[name] = self.movements[name];
            self.currentJobsToPressedMove[name].dir = dir or 1;
        end;
    end;
end;

function ASCMovementManager:moveAnimatedPart(name, time)
    local factor = self.movements[name].dur / time;
    local x,y,z = factor
    self:setAnimation(name, self.movements[name].mode, x, y, z)
end;
 
function ASCMovementManager:update(dt)
    for k,v in pairs(self.currentJobsToMove) do
        local x,y,z = getPosition(v.id);

        if v.mode == "rot" then
            x,y,z = getRotation(v.id);
        end;

        local x = clamp(x + dt * v.dir, v.from.x, v.to.x);
        local y = clamp(y + dt * v.dir, v.from.y, v.to.y);
        local z = clamp(z + dt * v.dir, v.from.z, v.to.z);

        self:setAnimation(k, v.mode, x,y,z);

        -- remove job, if is ready
        if x == v.to.x and y == v.to.y and z == v.to.z then
            v = nil;
        end;
    end;

    for k,v in pairs(self.currentJobsToPressedMove) then
        if v.dir ~= nil then
            self:moveAnimatedPart(k, clamp(v.time + v.dir * dt, 0, v.dur));
            v.dir = nil;
        else
            v = nil;
        end;
    end;
end;

function ASCMovementManager:setAnimation(name, mode, x, y, z)
    -- get type
    if mode == "rot" then
        setRotation(self.currentJobsToMove[name].id, x, y, z);
    end;

    if mode == "pos" then
        setPosition(self.currentJobsToMove[name].id, x, y, z);
    end;
end;
 
function ASCMovementManager:destroy()
end;