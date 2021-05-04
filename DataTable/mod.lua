return {
	author		= "Alpin 3D Design & SRTD",
	version		= "1.1.6",
	title		= "A3D SNOW.Control",
	description	= "Alpin 3D design and SRTD present the original SNOW.Control mod with many original manufacturers for the winter resort simulator. Experience the highest level of detail in the field of snowmaking and grooming, now also available for free in Multiplayer.\nWe wish you much fun!",

	targetGame = 'WRS-S2',
	supportsMultiplayer = true,

	scripts		= {
		-- settings
		"inputDesc.lua",

		-- A3D Base System
		"A3DUtils.lua",
		"A3DBaseSystem.lua",

		-- ASC Clients
		"DeveloperRights.lua",
        "SufagUI.lua",
		"SufagEnergy.lua",
		"SufagControlManagerEvent.lua",
		"SufagControlManager.lua",
		"alignment.lua",
		"SufagUpdateInfo.lua",
		"swivelArm.lua",
		"visible.lua",
		"SnowSat.lua",

		-- vehicleDesc
		"Sufag-Peak.lua",
		"Sufag-Power.lua",
		"TA_TL6.lua",
		"TA_TR10.lua",
		"TA_TT10.lua",
--		"TA_T40.lua",
		"Prinoth_Bison.lua",
		"DemacLenkoFA.lua",
		"Transportbox.lua",
	},
};