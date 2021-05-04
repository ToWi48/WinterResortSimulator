--
-- @autor Tom Wießner
-- @date 11/01/21
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
--

ASCMovementManager = ASCMovementManager or {};

-- movement = {
--     animation = false,
--     index = "",
--     mode = "rot",
--     speed = 5,
--     steps = {
--         min = {x=0, y=0, z=0},
--         max = {x=1, y=1, z=1},
--     }
-- }

-- movement = {
--     animation = true,
--     index = "",
--     mode = "rot",
--     steps = {
--         {speed=5, x=0, y=0, z=0},
--         {speed=5, x=1, y=1, z=1},
--     }
-- }

-- movement = {
--     permRotation = true,
--     index = "",
--     axis = 1,
--     speedUp = 1,
--     speed = 15,
-- }

function ASCMovementManager:load(tbl)
    self.registerMovement       = VehicleManager:newFunction("registerMovement");
    self.playAnimation          = VehicleManager:newFunction("playAnimation");
    self.setAnimation           = VehicleManager:newFunction("setAnimation");
    self.movements = {};
    self.currentJobsToMove = {};
end;

function ASCMovementManager:registerMovement(name, tbl)
    self.movements[name] = {};
    self.movements[name].id = A3D.debugLoad3D(tbl, "tbl.index", self.id);
    self.movements[name].animation = tbl.animation or false;
    self.movements[name].permRotation = tbl.permRotation or false;

    if not tbl.permRotation then
        if tbl.animation then
            self.movements[name].mode = tbl.mode or "rot";
            self.movements[name].currentStep = tbl.startStep or 1;
            self.movements[name].steps = tbl.steps;
        else
            self.movements[name].mode = tbl.mode or "rot";
            self.movements[name].steps = tbl.steps;
        end;
    else
        self.movements[name].speedUp = tbl.speedUp or 1;
        self.movements[name].maxSpeed = tbl.speed;
        self.movements[name].axis = tbl.axis;
        self.movements[name].speed = 0;
    end;
end;

function ASCMovementManager:playAnimation(name, dir)
    if self.movements[name] ~= nil then
        -- base table
        self.currentJobsToMove[name] = {};
        self.currentJobsToMove[name].id = self.movements[name].id;
        self.currentJobsToMove[name].permRotation = self.movements[name].permRotation;
        self.currentJobsToMove[name].animation = self.movements[name].animation;
        self.currentJobsToMove[name].dir = dir;

        if not self.movements[name].permRotation then
            if self.movements[name].animation and self.currentJobsToMove[name] == nil then
                self.currentJobsToMove[name].toStep = self.movements[name].steps[self.movements[name].currentStep + dir];
                self.currentJobsToMove[name].fromStep = self.movements[name].steps[self.movements[name].currentStep];
            end;

            if not self.movements[name].animation then
                self.currentJobsToMove[name].toStep = self.movements[name].steps[2];
                self.currentJobsToMove[name].fromStep = self.movements[name].steps[1];
            end;
        else
            self.currentJobsToMove[name].speedUp = self.movements[name].speedUp;
            self.currentJobsToMove[name].maxSpeed = self.movements[name].maxSpeed;
            self.currentJobsToMove[name].speed = self.movements[name].speed;
            self.currentJobsToMove[name].axis = self.movements[name].axis;
        end;
    end;
end;
 
function ASCMovementManager:update(dt)
    for k,v in pairs(self.currentJobsToMove) do
        if not v.permRotation then
            local x,y,z = getPosition(v.id);

            if v.mode == "rot" then
                x,y,z = getRotation(v.id);
            end;

            local x = clamp(x + dt * v.dir, v.from.x, v.to.x);
            local y = clamp(y + dt * v.dir, v.from.y, v.to.y);
            local z = clamp(z + dt * v.dir, v.from.z, v.to.z);

            self:setAnimation(k, v.mode, x,y,z);

            -- remove job, if is ready
            if x == v.to.x and y == v.to.y and z == v.to.z or not v.animation then
                v = nil;
            end;
        else
            v.speed = clamp(v.speed + dt * v.dir, 0, v.maxSpeed);

            if v.axis == 1 then
                rotate(v.id, v.speed, 0, 0);
            elseif v.axis == 2 then
                rotate(v.id, 0, v.speed, 0);
            elseif v.axis == 3 then
                rotate(v.id, 0, 0, v.speed);
            end;
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