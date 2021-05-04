--
-- @autor Tom Wießner
-- @date 10.02.2021
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2021
--

-- overwrite loading screen

-- local ready = false;

-- local MainMenuLoadingScreen_load = MainMenuLoadingScreen.onLoadingFinished;
-- MainMenuLoadingScreen.onLoadingFinished = function(...)
-- 	ready = true;
-- end;

SufagUpdateInfoCaller = SufagUpdateInfoCaller or {};

function SufagUpdateInfoCaller:load()
	SufagUI:load();

	self.firstStart = true;
end;

function SufagUpdateInfoCaller:update(dt)
	if self.firstStart then
		if g_GUI:getCurrentScreen() == nil and (not self:getIsCurrentVersion()) then
			g_GUI:showScreen(SufagUpdateInfo);
			self.firstStart = false;
		end;
	end;
end;

function SufagUpdateInfoCaller:destroy()
end;

function SufagUpdateInfoCaller:getIsCurrentVersion()
    local getVersion = File.loadSettings("modUpdateInfo");
    return (getVersion ~= nil and (getVersion.sufagVersion == SufagControlManager.version));
end;

function SufagUpdateInfoCaller:setCurrentVersion()
    local firstLine = "-- This file stores the UpdateInfo of the A3D Sufag temporarily and enables the display of an intro with the first start. If you want to implement this system as well, please contact ToWi48, so that we can install a system that saves everything into one file. We do not need a separate file for each modification."
    File.saveSettings("modUpdateInfo", firstLine .. '\n' .. "return { sufagVersion = " .. tostring(SufagControlManager.version) .. " };");
end;

A3DBaseSystem:addExtraSource(SufagUpdateInfoCaller);

----

SufagUpdateInfo								= SufagUpdateInfo or {};
local SufagUpdateInfoClaas					= Class(SufagUpdateInfo, BasePopup);

function SufagUpdateInfo:load()
    local id = SufagUI:showUpdateInfo(true);
	UI.setOnClickCallback(id, function() self:onButtonBack(); end);
end;

function SufagUpdateInfo:update(dt)
	g_GUI:addKeyHint(InputMapper.A3D_closeUpdateInfo,  l10n.get("A3D_closeUpdateInfo"));
	if InputMapper:getKeyDown(InputMapper.Hotkey_DashboardMenu) or InputMapper:getKeyDown(InputMapper.Hotkey_IngameMenu) or InputMapper:getKeyDown(InputMapper.A3D_closeUpdateInfo) then
		self:onButtonBack();
	end;
end;

function SufagUpdateInfo:destroy()
end;

function SufagUpdateInfo:onButtonBack()
	local id = SufagUI:showUpdateInfo(false);
	SufagUpdateInfoCaller:setCurrentVersion();
	g_GUI:closeCurrentScreen();
end;