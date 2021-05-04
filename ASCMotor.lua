--
-- @autor Tom Wießner
-- @date 11/01/21
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
--

ASCSoundManager = ASCSoundManager or {};

function ASCSoundManager:load(tbl)
    self.registerSound      = VehicleManager:newFunction("registerSound");
    self.getSoundId         = VehicleManager:newFunction("getSoundId");
    self.setSoundMode       = VehicleManager:newFunction("setSoundMode");
    self.setSoundSettings   = VehicleManager:newFunction("setSoundSettings");
    self.getSoundActive     = VehicleManager:newFunction("getSoundActive");

    self.loadedSounds = {};
    self.sounds = {};
end;

function ASCSoundManager:registerSound(name, tbl)
    -- check if table include too much sounds
    if tbl["start"] ~= nil and tbl["stop"] ~= nil and tbl["work"] ~= nil and tbl["single"] == nil and tbl["loop"] == nil then
        -- start, stop, work
        local start = self.getSoundId(tbl["start"].source, A3D.debugLoad3D(tbl, "tbl.attachedId", self.id));
        local stop = self.getSoundId(tbl["stop"].source, A3D.debugLoad3D(tbl, "tbl.attachedId", self.id));
        local work = self.getSoundId(tbl["work"].source, A3D.debugLoad3D(tbl, "tbl.attachedId", self.id));

        self.sounds[name] = {};
        self.sounds[name].dur = 0;
        self.sounds[name].mode = 0;

        self.sounds[name].start = {}
        self.sounds[name].start.id = start;
        self:setSoundSettings(name, "start", tbl["start"].volume or 1, tbl["start"].pitch or 1);

        self.sounds[name].stop = {}
        self.sounds[name].stop.id = stop;
        self:setSoundSettings(name, "stop", tbl["stop"].volume or 1, tbl["stop"].pitch or 1);

        self.sounds[name].work = {}
        self.sounds[name].work.id = work;
        self:setSoundSettings(name, "work", tbl["work"].volume or 1, tbl["work"].pitch or 1);

    elseif tbl["start"] == nil and tbl["stop"] == nil and tbl["work"] == nil and tbl["single"] ~= nil and tbl["loop"] == nil then
        -- single
        local single = self.getSoundId(tbl["single"].source, A3D.debugLoad3D(tbl, "tbl.attachedId", self.id));

        self.sounds[name] = {};
        self.sounds[name].id = single;
        self:setSoundSettings(name, "work", tbl["single"].volume or 1, tbl["single"].pitch or 1);

    elseif tbl["start"] == nil and tbl["stop"] == nil and tbl["work"] == nil and tbl["single"] == nil and tbl["loop"] ~= nil then
        -- loop
        local loop = self.getSoundId(tbl["loop"].source, A3D.debugLoad3D(tbl, "tbl.attachedId", self.id));

        self.sounds[name] = {};
        self.sounds[name].dur = 0;
        self.sounds[name].mode = 0;
        self.sounds[name].id = loop;
        self.sounds[name].keyframes = tbl["loop"].keyFrames;
        self.sounds[name].keyframes.work = {volume = tbl["loop"].volume or 1, pitch = tbl["loop"].pitch or 1};

        self:setSoundSettings(name, "loop", tbl["loop"].volume or 1, tbl["loop"].pitch or 1);
    else
        print('ASC-SoundManager:: Sound module "' .. name .. '" does not fit into any pattern!')
    end;
end;

function ASCSoundManager:getSoundId(source, objectId)
    local id = self.loadedSounds[source];
    
    if id ~= nil then
        id = instantiate(id);
    else
        id = Utils.loadBundleGameObject(self.bundleId, source);
        self.loadedSounds[source] = id;
    end;

    setParent(id, objectId);
    setPosition(id, 0,0,0);
    setWorldPosition(id, getWorldPosition(objectId))
    AudioSource.stop(id);

    return id
end;

function ASCSoundManager:setSoundMode(name, mode)
    if self.sounds[name] == nil then
        print('ASC-SoundManager:: setSoundMode is called by an non registred name!');
        return;
    end;

    -- 3 mode call
    if mode == "START" and self.sounds[name].mode ~= nil then
        self.sounds[name].mode = 1;
    elseif mode == "STOP" and self.sounds[name].mode ~= nil then
        self.sounds[name].mode = 3;
    elseif mode == "WORK" and self.sounds[name].mode ~= nil then
        self.sounds[name].mode = 2;
    elseif mode == "OFF" and self.sounds[name].mode ~= nil then
        self.sounds[name].mode = 0;
    end;
    self.sounds[name].dur = 0;

    -- single
    if mode == "PLAY" then
        AudioSource.play(self.sounds[name].id);
    elseif mode == "STOP" then
        AudioSource.stop(self.sounds[name].id);
    end;
end;

function ASCSoundManager:setSoundSettings(name, subName, volume, pitch)
    if self.sounds[name] == nil then
        print('ASC-SoundManager:: setSoundSettings is called by an non registred name!');
        return false;
    end;

    local item = self.sounds[name];

    if self.sounds[name][subName] ~= nil then
        -- start stop work
        item = item[subName];
    end;

    if volume ~= nil then
        item.volume = volume;
        AudioSource.setVolume(item.id, volume);
    end;
    if pitch ~= nil then
        item.pitch = pitch;
        AudioSource.setPitch(item.id, pitch);
    end;
end;

function ASCSoundManager:getSoundActive(name, subName)
    if self.sounds[name] == nil then
        print('ASC-SoundManager:: getSoundActive is called by an non registred name!');
        return false;
    end;

    if self.sounds[name][subName] ~= nil then
        return AudioSource.getIsPlaying(self.sounds[name][subName].id);
    else
        return AudioSource.getIsPlaying(self.sounds[name].id);
    end;
end;
 
function ASCSoundManager:update(dt)
    for name,v in pairs(self.sounds) do
        if v.start ~= nil then
            -- is mode sound

            -- change mode
            if v.mode == 1 then
                if v.dur > AudioSource.getLength(v.start.id) then
                    v.mode = 2;
                    v.dur = 0;
                else
                    v.dur = v.dur + dt;
                end;
            elseif v.mode == 3 then
                if v.dur > AudioSource.getLength(v.stop.id) then
                    v.mode = 0;
                    v.dur = 0;
                else
                    v.dur = v.dur + dt;
                end;
            end;
        
            -- mode sound
            if v.mode == 1 then
                AudioSource.play(v.start.id);

                -- make sure that all other sounds stoped
                AudioSource.stop(v.stop.id);
                AudioSource.stop(v.work.id);
            elseif v.mode == 2 then
                AudioSource.play(v.work.id);

                -- make sure that all other sounds stoped
                AudioSource.stop(v.start.id);
                AudioSource.stop(v.stop.id);
            elseif v.mode == 3 then
                AudioSource.play(v.stop.id);

                -- make sure that all other sounds stoped
                AudioSource.stop(v.start.id);
                AudioSource.stop(v.work.id);
            elseif v.mode == 0 then
                -- make sure that all other sounds stoped
                AudioSource.stop(v.start.id);
                AudioSource.stop(v.work.id); 
                AudioSource.stop(v.stop.id);
            end;
        elseif v.dur ~= nil then
            -- is loop sound
            if v.mode == 1 then
                if v.dur >= v.keyframes.start.dur then
                    v.mode = 2;
                    v.dur = 0;
                else
                    AudioSource.play(v.id);

                    -- new volume = startVolume + deltaVolume * timefactor (0-1)
                    local newVol = v.keyframes.start.volume + (v.volume - v.keyframes.start.volume) * (v.dur / v.keyframes.start.dur); 
                    local newPitch = v.keyframes.start.pitch + (v.pitch - v.keyframes.start.pitch) * (v.dur / v.keyframes.start.dur); 

                    self:setSoundSettings(name, "loop", newVol, newPitch);

                    v.dur = v.dur + dt;
                end;
            elseif v.mode == 2 then
                if v.volume ~= v.keyframes.work.volume or v.pitch ~= v.keyframes.work.pitch then
                    self:setSoundSettings(name, "loop", v.keyframes.work.volume, v.keyframes.work.pitch);
                end;
            elseif v.mode == 3 then
                if v.dur >= v.keyframes.stop.dur then
                    AudioSource.stop(v.id);
                    v.dur = 0;
                else
                    -- new volume = normalVolume - deltaVolume * timefactor (0-1)
                    local newVol = v.volume - (v.volume - v.keyframes.stop.volume) * (v.dur / v.keyframes.stop.dur); 
                    local newPitch = v.pitch - (v.pitch - v.keyframes.stop.pitch) * (v.dur / v.keyframes.stop.dur); 

                    self:setSoundSettings(name, "loop", newVol, newPitch);

                    v.dur = v.dur + dt;
                end;
            end;

        end;
    end;
end;
 
function ASCSoundManager:destroy()
end;