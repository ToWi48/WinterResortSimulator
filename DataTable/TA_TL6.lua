--
-- DataTable
--
-- Modell: Techno Alpin TL6
-- Customizations: 6m, 10m
-- Dev: Alpin 3D Design
-- Version: 1.5
--
-- www.alpin3d-design.com
-- (c) 2012 - 2021 by Alpin 3D Design - all rights reserved!
--

ModLoader.addContent("vehicle", {
	contentName				= "TechnoAlpin TL6",
	title					= "TechnoAlpin TL6",
	fullDesc				= l10n.get("A3D_CannonDesc_TA_TL6"),
	techSpecs				= "Full featured A3D SNOW.Control",
	previewFilename			= "Store_TL6",
	logoFilename			= "Logo_TechnoAlpin",
	
	author					= "Alpin 3D Design",
	shopCategory			= "snowmaking",
	price					= 7000,
	depreciationPeriod		= 80,
	
	class					= Vehicle,

	massCenter				= Vector3:new(0.0, 0.07349849, 0.0),

	axles					= { },
	
	isPlaceable				= true,
	isCustomizable			= true,

	customizations			= {

-------------------------------------------------- TechnoAlpin TL6 - 6m --------------------------------------------------

        {
            customizationName		= "TL6 - 6m",
            title					= "TechnoAlpin TL6 - 6m",
            fullDesc				= l10n.get("A3D_CannonDesc_TA_TL6_6m"),
            prefab					= "TL6_6m",
            previewFilename			= "Store_TL6",
            price					= 7000,
            isKinematic				= false,
            remoteCameraIndex       = "Hauptsaeule/Cam",
            vehicleScripts			= {
				visible,
				SnowCannon,
				CylinderAnimator,
            },

			cylinders				= {
			{
				cylinder		= "Hauptsaeule/Zylinder_stat",
				piston			= "Hauptsaeule/Zylinder_stat/Zylinder_dyn",
				target			= "Hauptsaeule/Lanzenarm/Zylinder_target",
				},
			},

			visible = {
				index = "Hauptsaeule/Schutzmatte",
			},

            snowCannons				= {
				{
					snowSpawnIndex	= "Hauptsaeule/Lanzenarm/ParticleSystem",
					rayLength		= 7,
					volumePerSecond = 2000, -- in m³ per hour
					spreadFactor	= 1,
					minSpreadRadius	= 4,
					controlIndex	= "Hauptsaeule",
					cameraIndex		= "Hauptsaeule/Cam",
					idleSound		= "snowlances",
					rotX			= {
						index		= "Hauptsaeule/Lanzenarm",
						min			= -25,
						max			= 9,
					},
					rotY			= {
						index		= "Hauptsaeule",
						min			= -10e8,
						max			= 10e8,
						attachValue	= 180,
					},
					particleSystems	= { "Hauptsaeule/Lanzenarm/ParticleSystem/Snow_Particles_Main", "Hauptsaeule/Lanzenarm/ParticleSystem/Snow_Particles_Near" },
				},
			},
        },

-------------------------------------------------- TechnoAlpin TL6 - 10m--------------------------------------------------

		{
            customizationName		= "TL6 - 10m",
            title					= "TechnoAlpin TL6 - 10m",
            fullDesc				= l10n.get("A3D_CannonDesc_TA_TL6_10m"),
            prefab					= "TL6_10m",
            previewFilename			= "Store_TL6",
            price					= 8000,
            isKinematic				= false,
            remoteCameraIndex       = "Hauptsaeule/Cam",
            vehicleScripts			= {
				visible,
				SnowCannon,
				CylinderAnimator,            
			},

			cylinders				= {
			{
				cylinder		= "Hauptsaeule/Zylinder_stat",
				piston			= "Hauptsaeule/Zylinder_stat/Zylinder_dyn",
				target			= "Hauptsaeule/Lanzenarm/Zylinder_target",
				},
			},

			visible = {
				index = "Hauptsaeule/Schutzmatte",
			},

            snowCannons				= {
				{
					snowSpawnIndex	= "Hauptsaeule/Lanzenarm/ParticleSystem",
					rayLength		= 8,
					volumePerSecond = 2500, -- in m³ per hour
					spreadFactor	= 1.5,
					minSpreadRadius	= 1,
					controlIndex	= "Hauptsaeule",
					cameraIndex		= "Hauptsaeule/Cam",
					idleSound		= "snowlances",
					rotX			= {
						index		= "Hauptsaeule/Lanzenarm",
						min			= -25,
						max			= 9,
					},
					rotY			= {
						index		= "Hauptsaeule",
						min			= -10e8,
						max			= 10e8,
						attachValue	= 180,
					},
					particleSystems	= { "Hauptsaeule/Lanzenarm/ParticleSystem/Snow_Particles_Main", "Hauptsaeule/Lanzenarm/ParticleSystem/Snow_Particles_Near" },
				},
			},
		},
    },
});