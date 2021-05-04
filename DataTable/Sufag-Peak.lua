--
-- DataTable
--
-- Modell: Sufag Compact Power
-- Customizations: Mobile, 3m Turm, 5m Turm, 4m GunLifter, 6m GunLifter
-- Dev: Alpin 3D Design & SRTD 
-- Version: 1.6
--
-- www.alpin3d-design.com
-- (c) 2012 - 2021 by Alpin 3D Design - all rights reserved!
--

-- check if ASC is enabled
-- A3DBaseSystem == nil or a3dsnowcontrol == nil
--if a3dsnowcontrol.A3DBaseSystem == nil then 
  --  print("Missing A3D SnowControl. Please activate it or make sure that steam downloaded it");
  --  return nil 
--end;

ModLoader.addContent("vehicle", {
	contentName				= "Sufag Peak",
	title					= "Sufag Peak",
	fullDesc				= l10n.get("A3D_CannonDesc_Peak"),
	techSpecs				= "Full featured A3D SNOW.Control",
	previewFilename			= "Store_PeakTower",
	logoFilename			= "Logo_Sufag",
	
	author					= "Alpin 3D Design & SRTD",
	shopCategory			= "snowmaking",
	price					= 20000,
	depreciationPeriod		= 80,
	
	class					= Vehicle,
	prefab					= "sufag_peak_cannon",
	


	massCenter				= Vector3:new(0.0, 0.07349849, 0.0),

	axles					= { },
	
	isPlaceable				= true,
	isKinematic				= false,
	isCustomizable			= true;

	customizations			= {

-------------------------------------------------- Sufag Peak Mobil --------------------------------------------------

			{
				customizationName		= "Sufag-Peak Mobil",
				title					= "Sufag Peak Mobil",
				fullDesc				= l10n.get("A3D_CannonDesc_Peak_Mobile"),
				prefab					= "sufag_peak_cannon",
				previewFilename			= "Store_PeakMobil",
                price					= 20000,
				isKinematic				= false,
                remoteCameraIndex       = "alignment/cannon/swivel/base1/Cam",
                vehicleScripts			= {
                    alignment,
                    SufagControlManager,
                    Attachable,
					CylinderAnimator,
                },
				slaveAttachers			= {
					{
						index			= "alignment/cannon/swivel/base1/Attacher",
						type			= "SnowCannon",
					},
				},
				cylinders				= {
				{
					cylinder		= "alignment/cannon/swivel/base1/Sufag_Hubzylinder",
					piston			= "alignment/cannon/swivel/base1/Sufag_Hubzylinder/Zylinder_piston",
					target			= "alignment/cannon/swivel/base1/cannon_peak1/Zylinder_target",
					},
				},
                alignment = {
                    refPointHeight = -0.393,
                    support1 = {
                        index = "alignment/rahmen/supports/ST01",
                        subIndex = "alignment/rahmen/supports/ST01/sup",
                        length = 0.37,
                        subLength = 0.621,
                        refPointIndex = "alignment/rahmen/supports/ref1",
                    },
                    support2 = {
                        index = "alignment/rahmen/supports/ST02",
                        subIndex = "alignment/rahmen/supports/ST02/sup",
                        length = 0.37,
                        subLength = 0.621,
                        refPointIndex = "alignment/rahmen/supports/ref2",
                    },
                    support3 = {
                        index = "alignment/rahmen/supports/ST03",
                        subIndex = "alignment/rahmen/supports/ST03/sup",
                        length = 0.37,
                        subLength = 0.621,
                        refPointIndex = "alignment/rahmen/supports/ref3",
                    },
                },
				SufagControlManager = {
                    controlRange = 2*2,
                    isMobile = true,
                    lightId = "alignment/cannon/swivel/base1/cannon_peak1/steuerung1/light_on",
                    coverActiveId = "alignment/cannon/swivel/base1/abdeckung",
                    coverInactiveId = "alignment/cannon/swivel/base1/cannon_peak1",
                    --protectionId = "alignment/rahmen/Schutzmatte",
					
					cannonRot = {
                        upDuration = 5 * 1000,
                        upTimer = 0,
                        upIndex = "alignment/cannon/swivel/base1/cannon_peak1",
                        leftDuration = 30 * 1000,
                        leftTimer = 15000,
                        leftIndex = "alignment/cannon",
                        
                        minUp = {
                            x = 0,
                            y = 0,
                            z = 0,
                        },
                        
                        maxUp = {
                            x = 30,
                            y = 0,
                            z = 0,
                        },
                        
                        minLeft = {
                            x = 0,
                            y = 360,
                            z = 0,
                        },
                        
                        maxLeft = {
                            x = 0,
                            y = -360,
                            z = 0,
                        },
                    },
                    swivel = {
                        -- dur / x / y / z
                        {15000, -30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, -30},
                        {10000, 0},
                    },
                },
                SufagAutomatic = {
					rayLength = 15,
					spreadFactor = 1,
                    rotorId = "alignment/cannon/swivel/base1/cannon_peak1/cannon_inside1/rotor",
                    spawnId = "alignment/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem",
                    baseId = "alignment/cannon/swivel/base1",
                    topId = "alignment/cannon/swivel/base1/cannon_peak1",
                    warnId = "alignment/cannon/swivel/base1/cannon_peak1/steuerung1/rulLight",
                    
                    particleSystems	= { "alignment/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Main", "alignment/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Near" },
                    
                    dur = {
                        heating = 50,
                        startKompressure = 30,
                        startFan = 30,
                        startWater = 50,
                        stopWater = 50,
                        stopFan = 30,
                        stopKompressure = 30,
                    },
                    sounds = {
                        startKompressure = "kompressorStart",
                        stopKompressure = "kompressorStop",
                        workKompressure = "kompressorWork",
                        startFan = "fanStart",
                        stopFan = "fanStop",
                        workFan = "fanWork",
                        startWater = "waterStart",
                        stopWater = "waterStop",
                        workWater = "waterWork",
                    },
                },
			},

-------------------------------------------------- Sufag Peak 8m Schwenkarm --------------------------------------------------
--[[
			{
				customizationName		= "Sufag-Peak 8m Schwenkarm",
				title					= "Sufag Peak 8m Schwenkarm",
				fullDesc				= l10n.get("A3D_CannonDesc_Peak_Tower4m"),
				prefab					= "schwenkarm_peak",
				previewFilename			= "Store_PeakSchwenkarm",
				isKinematic				= true,
                remoteCameraIndex       = "Halterung/Arm/Traeger/peak/cannon/swivel/base1/Cam",
                vehicleScripts			= {
                    SufagControlManager,
                    Attachable,
					swivelArm,
					CylinderAnimator,
                },
				cylinders				= {
					{
						cylinder		= "Halterung/Hydraulikzylinder",
						piston			= "Halterung/Hydraulikzylinder/Zylinder",
						target			= "Halterung/Arm/Zylinder_target",
					},
				}, 
				swivelArm				= {
					{
						upIndex		= "Halterung/Arm",
						leftIndex	= "Halterung",
						upMinPos	= {-2,0,0},
						upMaxPos	= {20,0,0},
						leftMinPos	= {0,90,0},
						leftMaxPos	= {0,-90,0},
						upDur		= 3,
						leftDur		= 4,

						platformIndex = "Halterung/Arm/Traeger",
						platformAxis = 1,

						UpTime		= 40,
						LeftTime	= 30,
					},
				},
				SufagControlManager = {
                    controlRange = 2*2,
                    isMobile = false,
					isFixedTower = true,
                    price				= 25000,
                    lightId = "Halterung/Arm/Traeger/peak/cannon/swivel/base1/cannon_peak1/steuerung1/light_on",
                    coverActiveId = "Halterung/Arm/Traeger/peak/cannon/swivel/base1/cannon_peak1/abdeckung",
                    coverInactiveId = "Halterung/Arm/Traeger/peak/cannon/swivel/base1/abdeckung_on",
                    protectionId = "Halterung/Matte",
				cannonRot = {
                        upDuration = 5 * 1000,
                        upTimer = 0,
                        upIndex = "Halterung/Arm/Traeger/peak/cannon/swivel/base1/cannon_peak1",
                        leftDuration = 30 * 1000,
                        leftTimer = 15000,
                        leftIndex = "Halterung/Arm/Traeger/peak/cannon",
                        
                        minUp = {
                            x = 0,
                            y = 0,
                            z = 0,
                        },
                        
                        maxUp = {
                            x = 30,
                            y = 0,
                            z = 0,
                        },
                        
                        minLeft = {
                            x = 0,
                            y = 90,
                            z = 0,
                        },
                        
                        maxLeft = {
                            x = 0,
                            y = -270,
                            z = 0,
                        },
                    },
                    swivel = {
                        -- dur / x / y / z
                        {15000, -30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, -30},
                        {10000, 0},
                    },
				},
                SufagAutomatic = {
                    rotorId = "Halterung/Arm/Traeger/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/rotor",
                    spawnId = "Halterung/Arm/Traeger/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem",
                    baseId = "Halterung/Arm/Traeger/peak/cannon/swivel/base1",
                    topId = "Halterung/Arm/Traeger/peak/cannon/swivel/base1/cannon_peak1",
                    warnId = "Halterung/Arm/Traeger/peak/cannon/swivel/base1/cannon_peak1/steuerung1/rulLight",
                    
                    particleSystems	= { "Halterung/Arm/Traeger/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Main", "Halterung/Arm/Traeger/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Near" },
                    
                    dur = {
                        heating = 50,
                        startKompressure = 30,
                        startFan = 30,
                        startWater = 50,
                        stopWater = 50,
                        stopFan = 30,
                        stopKompressure = 30,
                    },
                    sounds = {
                        startKompressure = "kompressorStart",
                        stopKompressure = "kompressorStop",
                        workKompressure = "kompressorWork",
                        startFan = "fanStart",
                        stopFan = "fanStop",
                        workFan = "fanWork",
                        startWater = "waterStart",
                        stopWater = "waterStop",
                        workWater = "waterWork",
                        gunLifter = "GunLifter",
                    },
                },
			},
]]
-------------------------------------------------- Sufag Peak 3m Turm --------------------------------------------------

			{
				customizationName		= "Sufag-PeakTower3m",
				title					= "Sufag Peak 3 m Turm",
				fullDesc				= l10n.get("A3D_CannonDesc_Peak_3mTower"),
				prefab					= "3mturm_peak",
				previewFilename			= "Store_Peak_Tower",
				price					= 16000,
				isKinematic				= true,
                remoteCameraIndex       = "peak/cannon/swivel/base1/Cam",
                vehicleScripts			= {
                    SufagControlManager,
                    Attachable,
					CylinderAnimator,
                },
				cylinders				= {
				{
					cylinder		= "peak/cannon/swivel/base1/Sufag_Hubzylinder",
					piston			= "peak/cannon/swivel/base1/Sufag_Hubzylinder/Zylinder_piston",
					target			= "peak/cannon/swivel/base1/cannon_peak1/Zylinder_target",
					},
				},
				SufagControlManager = {
                    controlRange = 2*2,
					isMobile = true,
					isFixedTower = true,
                    lightId = "peak/cannon/swivel/base1/cannon_peak1/steuerung1/light_on",
                    coverActiveId = "peak/cannon/swivel/base1/abdeckung",
                    coverInactiveId = "peak/cannon/swivel/base1/cannon_peak1",
                    protectionId = "Schutzmatte",
					gunLifter = {
                        duration = 0, -- 5s = 5000ms
                        index = "Index",
                        motor = "Index",
                        
                        startPos = {
                            x = 0,
                            y = 0,
                            z = 0,
                        },
                        
                        endPos = {
                            x = 0,
                            y = 0,
                            z = 0,
                        },
                    },
				cannonRot = {
                        upDuration = 5 * 1000,
                        upTimer = 0,
                        upIndex = "peak/cannon/swivel/base1/cannon_peak1",
                        leftDuration = 30 * 1000,
                        leftTimer = 15000,
                        leftIndex = "peak/cannon",
                        
                        minUp = {
                            x = 0,
                            y = 0,
                            z = 0,
                        },
                        
                        maxUp = {
                            x = 30,
                            y = 0,
                            z = 0,
                        },
                        
                        minLeft = {
                            x = 0,
                            y = 270,
                            z = 0,
                        },
                        
                        maxLeft = {
                            x = 0,
                            y = -450,
                            z = 0,
                        },
                    },
                    swivel = {
                        -- dur / x / y / z
                         {15000, -30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, -30},
                        {10000, 0},
                    },
				},
                SufagAutomatic = {
					rayLength = 15,
					spreadFactor = 1,
                    rotorId = "peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/rotor",
                    spawnId = "peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem",
                    baseId = "peak/cannon/swivel/base1",
                    topId = "peak/cannon/swivel/base1/cannon_peak1",
                    warnId = "peak/cannon/swivel/base1/cannon_peak1/steuerung1/rulLight",
                    
                    particleSystems	= { "peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Main", "peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Near" },
                    
                    dur = {
                        heating = 50,
                        startKompressure = 30,
                        startFan = 30,
                        startWater = 50,
                        stopWater = 50,
                        stopFan = 30,
                        stopKompressure = 30,
                    },
                    sounds = {
                        startKompressure = "kompressorStart",
                        stopKompressure = "kompressorStop",
                        workKompressure = "kompressorWork",
                        startFan = "fanStart",
                        stopFan = "fanStop",
                        workFan = "fanWork",
                        startWater = "waterStart",
                        stopWater = "waterStop",
                        workWater = "waterWork",
                        gunLifter = "GunLifter",
                    },
                },
			},
			
-------------------------------------------------- Sufag Peak 5m Turm --------------------------------------------------

			{
				customizationName		= "Sufag-PeakTower7m",
				title					= "Sufag Peak 5 m Turm",
				fullDesc				= l10n.get("A3D_CannonDesc_Peak_5mTower"),
				prefab					= "5mturm_peak",
				previewFilename			= "Store_Peak_Tower",
                price					= 18500,
				isKinematic				= true,
                remoteCameraIndex       = "peak/cannon/swivel/base1/Cam",
                vehicleScripts			= {
                    SufagControlManager,
                    Attachable,
					CylinderAnimator,
                },
				cylinders				= {
				{
					cylinder		= "peak/cannon/swivel/base1/Sufag_Hubzylinder",
					piston			= "peak/cannon/swivel/base1/Sufag_Hubzylinder/Zylinder_piston",
					target			= "peak/cannon/swivel/base1/cannon_peak1/Zylinder_target",
					},
				},
				SufagControlManager = {
                    controlRange = 2*2,
					isMobile = true,
					isFixedTower = true,
                    lightId = "peak/cannon/swivel/base1/cannon_peak1/steuerung1/light_on",
                    coverActiveId = "peak/cannon/swivel/base1/abdeckung",
                    coverInactiveId = "peak/cannon/swivel/base1/cannon_peak1",
                    protectionId = "Schutzmatte",
					gunLifter = {
                        duration = 0, -- 5s = 5000ms
                        index = "Index",
                        motor = "Index",
                        
                        startPos = {
                            x = 0,
                            y = 0,
                            z = 0,
                        },
                        
                        endPos = {
                            x = 0,
                            y = 0,
                            z = 0,
                        },
                    },
				cannonRot = {
                        upDuration = 5 * 1000,
                        upTimer = 0,
                        upIndex = "peak/cannon/swivel/base1/cannon_peak1",
                        leftDuration = 30 * 1000,
                        leftTimer = 15000,
                        leftIndex = "peak/cannon",
                        
                        minUp = {
                            x = 0,
                            y = 0,
                            z = 0,
                        },
                        
                        maxUp = {
                            x = 30,
                            y = 0,
                            z = 0,
                        },
                        
                        minLeft = {
                            x = 0,
                            y = 270,
                            z = 0,
                        },
                        
                        maxLeft = {
                            x = 0,
                            y = -450,
                            z = 0,
                        },
                    },
                    swivel = {
                        -- dur / x / y / z
                         {15000, -30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, -30},
                        {10000, 0},
                    },
				},
                SufagAutomatic = {
					rayLength = 22,
					spreadFactor = 1.1,
                    rotorId = "peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/rotor",
                    spawnId = "peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem",
                    baseId = "peak/cannon/swivel/base1",
                    topId = "peak/cannon/swivel/base1/cannon_peak1",
                    warnId = "peak/cannon/swivel/base1/cannon_peak1/steuerung1/rulLight",
                    
                    particleSystems	= { "peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Main", "peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Near" },
                    
                    dur = {
                        heating = 50,
                        startKompressure = 30,
                        startFan = 30,
                        startWater = 50,
                        stopWater = 50,
                        stopFan = 30,
                        stopKompressure = 30,
                    },
                    sounds = {
                        startKompressure = "kompressorStart",
                        stopKompressure = "kompressorStop",
                        workKompressure = "kompressorWork",
                        startFan = "fanStart",
                        stopFan = "fanStop",
                        workFan = "fanWork",
                        startWater = "waterStart",
                        stopWater = "waterStop",
                        workWater = "waterWork",
                        gunLifter = "GunLifter",
                    },
                },
			},

-------------------------------------------------- Sufag Peak GunLifter 4m --------------------------------------------------

			{
				customizationName		= "Sufag-Peak Turm 4m",
				title					= "Sufag Peak 4 m GunLifter",
				fullDesc				= l10n.get("A3D_CannonDesc_Peak_Tower4m"),
				prefab					= "4mturm_peak",
				previewFilename			= "Store_PeakTower",
                price					= 22500,
				isKinematic				= true,
                remoteCameraIndex       = "podest/peak/cannon/swivel/base1/Cam",
                vehicleScripts			= {
                    SufagControlManager,
                    Attachable,
					CylinderAnimator,
                },
				cylinders				= {
				{
					cylinder		= "podest/peak/cannon/swivel/base1/Sufag_Hubzylinder",
					piston			= "podest/peak/cannon/swivel/base1/Sufag_Hubzylinder/Zylinder_piston",
					target			= "podest/peak/cannon/swivel/base1/cannon_peak1/Zylinder_target",
					},
				},
				SufagControlManager = {
                    controlRange = 2*2,
                    isMobile = false,
                    lightId = "podest/peak/cannon/swivel/base1/cannon_peak1/steuerung1/light_on",
                    coverActiveId = "podest/peak/cannon/swivel/base1/abdeckung",
                    coverInactiveId = "podest/peak/cannon/swivel/base1/abdeckung_on",
                    protectionId = "Schutzmatte",
					gunLifter = {
                        duration = 20000, -- 5s = 5000ms
                        index = "podest",
                        motor = "motor",
                        
                        startPos = {
                            x = 0.242,
                            y = 0.512,
                            z = -0.19,
                        },
                        
                        endPos = {
                            x = 0.4728,
                            y = -0.791,
                            z = -0.19,
                        },
                    },
				cannonRot = {
                        upDuration = 5 * 1000,
                        upTimer = 0,
                        upIndex = "podest/peak/cannon/swivel/base1/cannon_peak1",
                        leftDuration = 30 * 1000,
                        leftTimer = 15000,
                        leftIndex = "podest/peak/cannon",
                        
                        minUp = {
                            x = 0,
                            y = 0,
                            z = 0,
                        },
                        
                        maxUp = {
                            x = 30,
                            y = 0,
                            z = 0,
                        },
                        
                        minLeft = {
                            x = 0,
                            y = 50,
                            z = 0,
                        },
                        
                        maxLeft = {
                            x = 0,
                            y = -230,
                            z = 0,
                        },
                    },
                    swivel = {
                        -- dur / x / y / z
                         {15000, -30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, -30},
                        {10000, 0},
                    },
				},
                SufagAutomatic = {
					rayLength = 22,
					spreadFactor = 1.2,
                    rotorId = "podest/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/rotor",
                    spawnId = "podest/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem",
                    baseId = "podest/peak/cannon/swivel/base1",
                    topId = "podest/peak/cannon/swivel/base1/cannon_peak1",
                    warnId = "podest/peak/cannon/swivel/base1/cannon_peak1/steuerung1/rulLight",
                    
                    particleSystems	= { "podest/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Main", "podest/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Near" },
                    
                    dur = {
                        heating = 50,
                        startKompressure = 30,
                        startFan = 30,
                        startWater = 50,
                        stopWater = 50,
                        stopFan = 30,
                        stopKompressure = 30,
                    },
                    sounds = {
                        startKompressure = "kompressorStart",
                        stopKompressure = "kompressorStop",
                        workKompressure = "kompressorWork",
                        startFan = "fanStart",
                        stopFan = "fanStop",
                        workFan = "fanWork",
                        startWater = "waterStart",
                        stopWater = "waterStop",
                        workWater = "waterWork",
                        gunLifter = "GunLifter",
                    },
                },
			},

-------------------------------------------------- Sufag Peak GunLifter 6m --------------------------------------------------

			{
				customizationName		= "Sufag-Peak Turm 6m",
				title					= "Sufag Peak 6 m GunLifter",
				fullDesc				= l10n.get("A3D_CannonDesc_Peak_Tower6m"),
				prefab					= "6mturm_peak",
				previewFilename			= "Store_PeakTower",
                price					= 25000,
				isKinematic				= true,
                remoteCameraIndex       = "podest/peak/cannon/swivel/base1/Cam",
                vehicleScripts			= {
                    SufagControlManager,
                    Attachable,
					CylinderAnimator,
                },
                cylinders				= {
				{
					cylinder		= "podest/peak/cannon/swivel/base1/Sufag_Hubzylinder",
					piston			= "podest/peak/cannon/swivel/base1/Sufag_Hubzylinder/Zylinder_piston",
					target			= "podest/peak/cannon/swivel/base1/cannon_peak1/Zylinder_target",
					},
				},
				SufagControlManager = {
                    controlRange = 2*2,
                    isMobile = false,
                    lightId = "podest/peak/cannon/swivel/base1/cannon_peak1/steuerung1/light_on",
                    coverActiveId = "podest/peak/cannon/swivel/base1/abdeckung",
                    coverInactiveId = "podest/peak/cannon/swivel/base1/abdeckung_on",
                    protectionId = "Schutzmatte",
                
			        gunLifter = {
                        duration = 20000, -- 5s = 5000ms
                        index = "podest",
                        motor = "motor",
                        
                        startPos = {
                            x = 0.082,
                            y = 1.226,
                            z = -0.19,
                        },
                        
                        endPos = {
                            x = 0.421,
                            y = -0.698,
                            z = -0.19,
                        },
                    },
				    cannonRot = {
                        upDuration = 5 * 1000,
                        upTimer = 0,
                        upIndex = "podest/peak/cannon/swivel/base1/cannon_peak1",
                        leftDuration = 30 * 1000,
                        leftTimer = 15000,
                        leftIndex = "podest/peak/cannon",
                        
                        minUp = {
                            x = 0,
                            y = 0,
                            z = 0,
                        },
                        
                        maxUp = {
                            x = 30,
                            y = 0,
                            z = 0,
                        },
                        
                        minLeft = {
                            x = 0,
                            y = 50,
                            z = 0,
                        },
                        
                        maxLeft = {
                            x = 0,
                            y = -230,
                            z = 0,
                        },
                    },
                    swivel = {
                        -- dur / x / y / z
                        {15000, -30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, 30},
                        {10000, 0},
                        {15000, -30},
                        {10000, 0},
                    },
				},
                SufagAutomatic = {
					rayLength = 25,
					spreadFactor = 1.3,
                    rotorId = "podest/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/rotor",
                    spawnId = "podest/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem",
                    baseId = "podest/peak/cannon/swivel/base1",
                    topId = "podest/peak/cannon/swivel/base1/cannon_peak1",
                    warnId = "podest/peak/cannon/swivel/base1/cannon_peak1/steuerung1/rulLight",
                    
                    particleSystems	= { "podest/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Main", "podest/peak/cannon/swivel/base1/cannon_peak1/cannon_inside1/SnowCannonParticles/ParticleSystem/Snow_Particles_Near" },
                    
                    dur = {
                        heating = 50,
                        startKompressure = 30,
                        startFan = 30,
                        startWater = 50,
                        stopWater = 50,
                        stopFan = 30,
                        stopKompressure = 30,
                    },
                    sounds = {
                        startKompressure = "kompressorStart",
                        stopKompressure = "kompressorStop",
                        workKompressure = "kompressorWork",
                        startFan = "fanStart",
                        stopFan = "fanStop",
                        workFan = "fanWork",
                        startWater = "waterStart",
                        stopWater = "waterStop",
                        workWater = "waterWork",
                        gunLifter = "GunLifter",
                    },
                },
                },	
			},

});