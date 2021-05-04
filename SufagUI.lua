--
-- @autor Tom Wießner
-- @date 19/06/20
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2020
--

SufagUI = SufagUI or {};
SufagUI.firstStart = true;
SufagUI.enabled = true; 

function SufagUI:load()
    if SufagUI.firstStart then
        local mod, bundleId				= ModLoader.getModByName("sufag");
        self.canvasId = Utils.loadBundleGameObject(bundleId, "SufagUI");
        --print(tostring(bundleId));
        --self.iconId = getChild(self.canvasId, "ICONS");
        self.currentId = nil;
        self.clients = {};
        SufagUI.firstStart = false;
        setActive(self.canvasId, true);
        setActive(self.canvasId, false);
    end;
end;

function SufagUI:getCanvasActive()
    return self.currentId;
end;

function SufagUI:showUpdateInfo(state)
    local screen = getChild(self.canvasId, "releaseInfo");

    setActive(self.canvasId, state);
    setActive(screen, state);

    return screen;
end;

function SufagUI:showCanvas(id, state, align)
    if self.currentId == id or (self.currentId == nil and state) and SufagUI.enabled then
        if state then
            self.currentId = id;
        else
            self.currentId = nil;
        end;
    
        setActive(self.canvasId, state);
        setActive(getChild(self.canvasId, "ICONS"), true);
        --setActive(getChild(self.iconId, "IMG_Alignment"), align);
    end;
end;
 
function SufagUI:setIconState(id, iconName, color)
    if self.currentId == id and SufagUI.enabled then
        local globalIcon = getChild(self.canvasId, "ICONS");
        local icon = getChild(globalIcon, iconName);
        for i=1, getNumOfChildren(icon) do
            setActive(getChildAt(icon, i-1), false);
        end;
        setActive(getChild(icon, color), true);
    end;
end;

function SufagUI:setDebugValue(value)
    --if self.currentId == id and SufagUI.enabled then
        local id = getChild(self.canvasId, "Debug");
        UI.setLabelText(id, tostring(value));
        UI.setLabelColor(id, 255,0,0,255); 
    --end;
end;

function SufagUI:debugUI()
    if self.currentId ~= nil then
        print("SUFAG_CONTROL_MANAGER:: non updateable canvas by " .. getName(self.currentId));
        self.currentId = nil;
    end;
    SufagUI.enabled = not SufagUI.enabled;
    setActive(self.canvasId, SufagUI.enabled);
end;