--
-- @autor Tom Wießner / Georg Buchacher 
-- @date 19/06/20 (last edit: 30/04/21)
--
-- DataTable InputDesc SNOW.Control 
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2021
--

function addInputKeys()
    -- states
    InputMapper:addKey("A3D_Snow.Control", "A3D_closeUpdateInfo",                   "KeypadEnter");
    InputMapper:addKey("A3D_Snow.Control", "A3D_setCannonPowerState",               "KeypadEnter");
    InputMapper:addKey("A3D_Snow.Control", "A3D_setCannonAutomaticState",           "B");
    InputMapper:addKey("A3D_Snow.Control", "A3D_setCannonCoverState",               "I");
    InputMapper:addKey("A3D_Snow.Control", "A3D_setCannonProtectionState",          "K");
    InputMapper:addKey("A3D_Snow.Control", "A3D_setCannonLightState",               "Keypad4");
    InputMapper:addKey("A3D_Snow.Control", "A3D_setCannonAlignState",               "X");
    InputMapper:addKey("A3D_Snow.Control", "A3D_moveGunLifterUp",                   "H");
    InputMapper:addKey("A3D_Snow.Control", "A3D_moveGunLifterDown",                 "N");
    InputMapper:addKey("A3D_Snow.Control", "A3D_debugUI",                           "LeftShift B");
    InputMapper:addKey("A3D_Snow.Control", "A3D_setCannonSwivelState",              "Y");
--	InputMapper:addKey("A3D_Snow.Control", "A3D_SwivelUp",					        "T");
--	InputMapper:addKey("A3D_Snow.Control", "A3D_SwivelDown",					    "G");
--	InputMapper:addKey("A3D_Snow.Control", "A3D_SwivelLeft",					    "H");
--	InputMapper:addKey("A3D_Snow.Control", "A3D_SwivelRight",					    "J");
	InputMapper:addKey("A3D_Snow.Control", "A3D_Remove_Groomer",           	        "F");
    InputMapper:addKey("A3D_Snow.Control", "A3D_Remove_Crawlers",           	    "Z");
    InputMapper:addKey("A3D_Snow.Control", "A3D_Remove_Grommer_middle",           	"R");
	InputMapper:addKey("A3D_Snow.Control", "A3D_Add_Chain",           		        "H");
	InputMapper:addKey("A3D_Snow.Control", "A3D_Turn_On_Wipers",           	        "G");                   
	InputMapper:addKey("A3D_Snow.Control", "A3D_Change_Winch_To_Standart",          "U");
    InputMapper:addKey("A3D_Snow.Control", "A3D_Beacons_Lights",           	        "Home");          
	InputMapper:addKey("A3D_Snow.Control", "A3D_Winch_Light",        		        "Keypad7");
    InputMapper:addKey("A3D_Snow.Control", "A3D_Remove_Blade",           	        "Alpha5");
    InputMapper:addKey("A3D_Snow.Control", "A3D_Add_Transportbox",                  "Alpha6");
    InputMapper:addKey("A3D_Snow.Control", "A3D_Turn_On_Mirrors",                   "Alpha7"); 
    InputMapper:addKey("A3D_Snow.Control", "A3D_Change_BisonX_To_Bison",            "Alpha8");
    InputMapper:addKey("A3D_Snow.Control", "A3D_Remove_Snowsat",                    "Alpha9");
    InputMapper:addKey("A3D_Snow.Control", "A3D_Remove_Shape_Academy",              "Alpha0"); 
 
        
          
end;

function addI18nKeysDE()
    l10n.add("de", "A3D_closeUpdateInfo",                               "Updateinfo schließen");
    l10n.add("de", "A3D_setCannonPowerTrue",                            "Stromversorgung aktivieren");
    l10n.add("de", "A3D_setCannonPowerFalse",                           "Stromversorgung deaktivieren");
    l10n.add("de", "A3D_setCannonAutomaticTrue",                        "Schneeerzeuger starten");
    l10n.add("de", "A3D_setCannonAutomaticFalse",                       "Schneeerzeuger stoppen");
    l10n.add("de", "A3D_setCannonCoverTrue",                            "Schneeerzeuger abdecken");
    l10n.add("de", "A3D_setCannonCoverFalse",                           "Schneeerzeuger aufdecken");
    l10n.add("de", "A3D_setCannonProtectionTrue",                       "Schutzmatte anbringen");
    l10n.add("de", "A3D_setCannonProtectionFalse",                      "Schutzmatte abnehmen");
    l10n.add("de", "A3D_setCannonLightTrue",                            "Beleuchtung anschalten");
    l10n.add("de", "A3D_setCannonLightFalse",                           "Beleuchtung ausschalten");
    l10n.add("de", "A3D_setCannonAlignTrue",                            "Schneeerzeuger ausrichten");
    l10n.add("de", "A3D_setCannonAlignFalse",                           "Schneeerzeuger transportfertig machen");
    l10n.add("de", "A3D_moveGunLifterUpDown",                           "GunLifter Hoch / Runter");
--	l10n.add("de", "A3D_SwivelUpDown",									"Schwenkarm Hoch / Runter");
--	l10n.add("de", "A3D_SwivelLeftRight",								"Schwenkarm nach Links / Rechts drehen");
    l10n.add("de", "A3D_Align_PopUp_Header",                            "Chef, wir haben ein Problem");
    l10n.add("de", "A3D_Align_PopUp_Desc",                              "Dieses Gerät ist vermutlich dezent schräg positioniert. Versuchen Sie es noch einmal an einem weniger steilen Hang");
    l10n.add("de", "A3D_Align_PopUp_Button",                            "Wenn´s sein muss...");

    l10n.add("de", "A3D_remote_cannon_info",                            "Erweitert");
    l10n.add("de", "A3D_remote_cannon_info_headline",                   "A3D Remote Management");
    l10n.add("de", "A3D_remote_cannon_info_desc",                       "In dieser Übersicht können Sie weitere Funktionen des Schneeerzeugers fernsteuern");

    l10n.add("de", "A3D_remote_cannon_info_btn_mobileOn",               "Mode:Kanone");
    l10n.add("de", "A3D_remote_cannon_info_btn_mobileOff",              "Mode:Turm");
    l10n.add("de", "A3D_remote_cannon_info_btn_lightOn",                "Licht:An");
    l10n.add("de", "A3D_remote_cannon_info_btn_lightOff",               "Licht:Aus");
    l10n.add("de", "A3D_remote_cannon_info_btn_swivelOn",               "Schwenkung:An");
    l10n.add("de", "A3D_remote_cannon_info_btn_swivelOff",              "Schwenkung:Aus");
    l10n.add("de", "A3D_remote_cannon_info_btn_protectionOn",           "Matte:An");
    l10n.add("de", "A3D_remote_cannon_info_btn_protectionOff",          "Matte:Aus");
    l10n.add("de", "A3D_remote_cannon_info_btn_coverOn",                "Abdekung:An");
    l10n.add("de", "A3D_remote_cannon_info_btn_coverOff",               "Abdeckung:Aus");
    l10n.add("de", "A3D_back",                                          "Zurück");

    l10n.add("de", "A3D_remote_start",                                  "Kanone:Aus");
    l10n.add("de", "A3D_remote_stop",                                   "Kanone:An");
    l10n.add("de", "A3D_remote_prepareStart",                           "Kanone:startet...");
    l10n.add("de", "A3D_remote_prepareStop",                            "Kanone:stoppt...");
    l10n.add("de", "A3D_setCannonSwivelFalse",                          "Schwenkwiederholung deaktivieren");
    l10n.add("de", "A3D_setCannonSwivelTrue",                           "Schwenkwiederholung aktivieren");
    
    l10n.add("de", "InputCategory_A3D_Snow.Control",                    "A3D SNOW.Control");
    l10n.add("de", "InputCategoryDesc_A3D_Snow.Control",                "Diese Kategorie beinhaltet die Tastenbelegung der Schneeerzeuger und Pistenfahrzeuge von Alpin 3D Design");
    l10n.add("de", "Input_A3D_closeUpdateInfo",                         "Updateinfo schließen");
    l10n.add("de", "Input_A3D_setCannonPowerState",                     "Stromversorgung");
    l10n.add("de", "Input_A3D_setCannonAutomaticState",                 "Schneeerzeuger steuern");
    l10n.add("de", "Input_A3D_setCannonCoverState",                     "Abdeckung");
    l10n.add("de", "Input_A3D_setCannonProtectionState",                "Schutzmatte");
    l10n.add("de", "Input_A3D_setCannonLightState",                     "Arbeitslicht");
    l10n.add("de", "Input_A3D_setCannonAlignState",                     "Ausrichten");
    l10n.add("de", "Input_A3D_moveGunLifterUp",                         "GunLifter hochfahren");
    l10n.add("de", "Input_A3D_moveGunLifterDown",                       "GunLifter runterfahren");
    l10n.add("de", "Input_A3D_debugUI",                                 "SUFAG UI Reset");
    l10n.add("de", "Input_A3D_setCannonSwivelState",                    "Schwenkfunktion");
--	l10n.add("de", "Input_A3D_SwivelUp",								"Schwenkarm hochfahren");
--    l10n.add("de", "Input_A3D_SwivelDown",								"Schwenkarm runterfahren");
--	l10n.add("de", "Input_A3D_SwivelLeft",								"Schwenkarm nach Links drehen");
--    l10n.add("de", "Input_A3D_SwivelRight",								"Schwenkarm nach Rechts drehen");
    
    l10n.add("de", "InputDesc_A3D_closeUpdateInfo",                     "Updateinfo schließen");
    l10n.add("de", "InputDesc_A3D_setCannonPowerState",                 "Stromversorgung anschalten / ausschalten");
    l10n.add("de", "InputDesc_A3D_setCannonAutomaticState",             "Schneeerzeuger starten / stoppen");
    l10n.add("de", "InputDesc_A3D_setCannonCoverState",                 "Abdeckung aktivieren / deaktivieren");
    l10n.add("de", "InputDesc_A3D_setCannonProtectionState",            "Schutzmatte aktivieren / deaktivieren");
    l10n.add("de", "InputDesc_A3D_setCannonLightState",                 "Arbeitslicht aktivieren / deaktivieren");
    l10n.add("de", "InputDesc_A3D_setCannonAlignState",                 "Schneeerzeuger waagerecht zum Boden ausrichten (in aktueller Version nicht implementiert!)");
    l10n.add("de", "InputDesc_A3D_moveGunLifterUp",                     "GunLifter hochfahren");
    l10n.add("de", "InputDesc_A3D_moveGunLifterDown",                   "GunLifter runterfahren");
    l10n.add("de", "InputDesc_A3D_debugUI",                             "Resetet das UI der Sufag. Bitte kontaktieren Sie in jedem Fall den Support von Alpin 3D Design, sollte eine benutzung dieser Funktion erforderlich werden!");
    l10n.add("de", "InputDesc_A3D_setCannonSwivelState",                "Automatische Schwenkfunktion steuern");

    l10n.add("de", "Input_A3D_Winch_Light",                             "Windenlicht");
    l10n.add("de", "Input_A3D_Remove_Groomer",                          "Fräse entfernen");
    l10n.add("de", "Input_A3D_Remove_Crawlers",                         "Ketten entfernen");
    l10n.add("de", "Input_A3D_Remove_Blade",                            "Schild entfernen");
    l10n.add("de", "Input_A3D_Remove_Grommer_middle",                   "Fräsenhydraulik entfernen");
    l10n.add("de", "Input_A3D_Add_Chain",                               "Windenanker");
    l10n.add("de", "Input_A3D_Turn_On_Wipers",                          "Scheibenwischer");
    l10n.add("de", "Input_A3D_Turn_On_Mirrors",                         "Spiegel");
    l10n.add("de", "Input_A3D_Beacons_Lights",                          "Rundumleuchten");
    l10n.add("de", "Input_A3D_Change_Winch_To_Standart",                "Winde entfernen");
    l10n.add("de", "Input_A3D_Change_BisonX_To_Bison",                  "Bison X entfernen");
    l10n.add("de", "Input_A3D_Add_Transportbox",                        "Transportbox entfernen");
    l10n.add("de", "Input_A3D_Winch_off",                               "Winde hochklappen");    
    l10n.add("de", "Input_A3D_Winch_on",                                "Winde herunterklappen");
    l10n.add("de", "Input_A3D_Winch_back_off",                          "Winde nach Hinten klappen");    
    l10n.add("de", "Input_A3D_Winch_back_on",                           "Winde nach Vorne klappen");
    l10n.add("de", "Input_A3D_open_Window",                             "Dachluke öffnen");    
    l10n.add("de", "Input_A3D_close_Window",                            "Dachluke schließen");
    l10n.add("de", "Input_A3D_open_Transportbox",                       "Klappe öffnen");    
    l10n.add("de", "Input_A3D_close_Transportbox",                      "Klappe schließen");
    l10n.add("de", "Input_A3D_Sticks_on",                               "Sticks hochklappen");    
    l10n.add("de", "Input_A3D_Sticks_off",                              "Sticks herunterklappen");
    l10n.add("de", "Input_A3D_add_Chaine",                              "Kette am Windeseil hinzufügen");
    l10n.add("de", "Input_A3D_remove_Chaine",                           "Kette am Windeseil entfernen");
    l10n.add("de", "A3D_Input_TT10_on",                                 "Turm kippen");
    l10n.add("de", "A3D_Input_TT10_off",                                "Turm zurückklappen");
    l10n.add("de", "Input_A3D_Remove_Snowsat",                          "Snowsat entfernen");
    l10n.add("de", "Input_A3D_Remove_Shape_Academy",                    "Shape Academy Logos entfernen");

    l10n.add("de", "InputDesc_A3D_Winch_Light",                         "Windenlicht ein / aus");    
    l10n.add("de", "InputDesc_A3D_Remove_Groomer",                      "Fräse entfernen");
    l10n.add("de", "InputDesc_A3D_Remove_Crawlers",                     "Ketten entfernen");
    l10n.add("de", "InputDesc_A3D_Remove_Blade",                        "Schild entfernen");
    l10n.add("de", "InputDesc_A3D_Remove_Grommer_middle",               "Fräsenhydraulik entfernen");        
    l10n.add("de", "InputDesc_A3D_Add_Chain",                           "Kette zum Schild hinzufügen");    
    l10n.add("de", "InputDesc_A3D_Turn_On_Wipers",                      "Scheibenwischer ein / aus");
    l10n.add("de", "InputDesc_A3D_Turn_On_Mirrors",                     "Spiegel ein / aus");        
    l10n.add("de", "InputDesc_A3D_Beacons_Lights",                      "Rundumleuchten ein / aus");
    l10n.add("de", "InputDesc_A3D_Change_Winch_To_Standart",            "Um von einer Winden Maschiene auf eine Solo Maschiene umzustellen");
    l10n.add("de", "InputDesc_A3D_Change_BisonX_To_Bison",              "Um von einer Bison X Maschiene auf eine normale Bison Maschiene umzustellen");
    l10n.add("de", "InputDesc_A3D_Remove_Snowsat",                      "Um Snowsat zu deaktivieren / aktivieren");
    l10n.add("de", "InputDesc_A3D_Remove_Shape_Academy",                "Um das Shape Academy Logos zu deaktivieren / aktivieren");
    l10n.add("de", "InputDesc_A3D_Add_Transportbox",                    "Transportbox hinzufügen");


    l10n.add("de", "A3D_MSG_UpdateInfo_Title",                          "SNOW.Control aktualisiert!");
    l10n.add("de", "A3D_MSG_UpdateInfo_Desc",                           "Du nutzt nun SNOW.Control in der Version 1.1.6. Was genau es in dieser Version neues zu entdecken gibt erfährst du unter www.alpin3d-design.com oder auf unseren Social Media Kanälen.\nViel Spaß wünschen dir das A3D & SRTD!");
end;

function addI18nKeysEN()
    l10n.add("en", "A3D_closeUpdateInfo",                               "close update info");
    l10n.add("en", "A3D_setCannonPowerTrue",                            "Activate power supply");
    l10n.add("en", "A3D_setCannonPowerFalse",                           "Disable power supply");
    l10n.add("en", "A3D_setCannonAutomaticTrue",                        "Start the snowmaker");
    l10n.add("en", "A3D_setCannonAutomaticFalse",                       "Stop the snowmaker");
    l10n.add("en", "A3D_setCannonCoverTrue",                            "Cover the snow guns");
    l10n.add("en", "A3D_setCannonCoverFalse",                           "Uncover the snow guns");
    l10n.add("en", "A3D_setCannonProtectionTrue",                       "Attach the protective mat");
    l10n.add("en", "A3D_setCannonProtectionFalse",                      "Remove the protective mat");
    l10n.add("en", "A3D_setCannonLightTrue",                            "Turn on the lighting");
    l10n.add("en", "A3D_setCannonLightFalse",                           "Turn off the lighting");
    l10n.add("en", "A3D_setCannonAlignTrue",                            "Align with the terrain");
    l10n.add("en", "A3D_setCannonAlignFalse",                           "Prepare for transport");
    l10n.add("en", "A3D_moveGunLifterUpDown",                           "GunLifter Up / Down");
--	l10n.add("en", "A3D_SwivelUpDown",                                  "Swivelarm Up / Down");
--    l10n.add("en", "A3D_SwivelLeftRight",                               "Swivelarm to the left / right");
    l10n.add("en", "A3D_Align_PopUp_Header",                            "Boss, we have a problem");
    l10n.add("en", "A3D_Align_PopUp_Desc",                              "This device is positioned at a slight angle. Try it again on a less steep slope");
    l10n.add("en", "A3D_Align_PopUp_Button",                            "Well, if you must...");

    l10n.add("en", "A3D_remote_cannon_info",                            "extended");
    l10n.add("en", "A3D_remote_cannon_info_headline",                   "A3D Remote Management");
    l10n.add("en", "A3D_remote_cannon_info_desc",                       "In this overview you can remotely control other functions of the snow gun");

    l10n.add("en", "A3D_remote_cannon_info_btn_mobileOn",               "mode:cannon");
    l10n.add("en", "A3D_remote_cannon_info_btn_mobileOff",              "mode:tower");
    l10n.add("en", "A3D_remote_cannon_info_btn_lightOn",                "light:on");
    l10n.add("en", "A3D_remote_cannon_info_btn_lightOff",               "light:off");
    l10n.add("en", "A3D_remote_cannon_info_btn_swivelOn",               "swivel:on");
    l10n.add("en", "A3D_remote_cannon_info_btn_swivelOff",              "swivel:off");
    l10n.add("en", "A3D_remote_cannon_info_btn_protectionOn",           "protection:on");
    l10n.add("en", "A3D_remote_cannon_info_btn_protectionOff",          "protection:off");
    l10n.add("en", "A3D_remote_cannon_info_btn_coverOn",                "cover:on");
    l10n.add("en", "A3D_remote_cannon_info_btn_coverOff",               "cover:off");
    l10n.add("en", "A3D_back",                                          "back");

    l10n.add("en", "A3D_remote_start",                                  "cannon:off");
    l10n.add("en", "A3D_remote_stop",                                   "cannon:on");
    l10n.add("en", "A3D_remote_prepareStart",                           "cannon:starting...");
    l10n.add("en", "A3D_remote_prepareStop",                            "cannon:stopping...");

    l10n.add("en", "A3D_remote_start",                                  "Start release");
    l10n.add("en", "A3D_remote_stop",                                   "Stopp");
    l10n.add("en", "A3D_remote_prepareStart",                           "Will be started...");
    l10n.add("en", "A3D_remote_prepareStop",                            "Will be stopped...");

    l10n.add("en", "A3D_setCannonSwivelFalse",                          "Deactivate pan repeat");
    l10n.add("en", "A3D_setCannonSwivelTrue",                           "Activate pan repeat");
    
    l10n.add("en", "InputCategory_A3D_Snow.Control",                    "A3D SNOW.Control");
    l10n.add("en", "InputCategoryDesc_A3D_Snow.Control",                "This category contains the key allocation of the snow makers and snowcats by Alpin 3D Design");  
    l10n.add("en", "Input_A3D_closeUpdateInfo",                         "close update info");
    l10n.add("en", "Input_A3D_setCannonPowerState",                     "Power supply");
    l10n.add("en", "Input_A3D_setCannonAutomaticState",                 "Controlling snowmaker");
    l10n.add("en", "Input_A3D_setCannonCoverState",                     "Cover");
    l10n.add("en", "Input_A3D_setCannonProtectionState",                "Protection Mat");
    l10n.add("en", "Input_A3D_setCannonLightState",                     "Worklight");
    l10n.add("en", "Input_A3D_setCannonAlignState",                     "Align snowmaker");
    l10n.add("en", "Input_A3D_moveGunLifterUp",                         "GunLifter up");
    l10n.add("en", "Input_A3D_moveGunLifterDown",                       "GunLifter down");
    l10n.add("en", "Input_A3D_debugUI",                                 "SUFAG UI Reset");
    l10n.add("en", "Input_A3D_setCannonSwivelState",                    "pan repeat");
       
    l10n.add("en", "InputDesc_A3D_closeUpdateInfo",                     "close update info");
    l10n.add("en", "InputDesc_A3D_setCannonPowerState",                 "Switching the power supply on / off");
    l10n.add("en", "InputDesc_A3D_setCannonAutomaticState",             "Snowmaker start / stop");
    l10n.add("en", "InputDesc_A3D_setCannonCoverState",                 "Cover on / off");
    l10n.add("en", "InputDesc_A3D_setCannonProtectionState",            "Protection Mat on / off");
    l10n.add("en", "InputDesc_A3D_setCannonLightState",                 "Worklight on / off");
    l10n.add("en", "InputDesc_A3D_setCannonAlignState",                 "Align snowmaker horizontally to the ground (not implemented in current version!)");
    l10n.add("en", "InputDesc_A3D_moveGunLifterUp",                     "GunLifter up");
    l10n.add("en", "InputDesc_A3D_moveGunLifterDown",                   "GunLifter down");
    l10n.add("en", "InputDesc_A3D_debugUI",                             "Reset the UI of Sufag. Please contact the support of Alpin 3D Design if you need to use this function!");
    l10n.add("en", "InputDesc_A3D_setCannonSwivelState",                "pan repeat");
--	l10n.add("en", "InputDesc_A3D_SwivelUp",                            "Swivelarm up");
--    l10n.add("en", "InputDesc_A3D_SwivelDown",                          "Swivelarm down");
--    l10n.add("en", "InputDesc_A3D_SwivelLeft",                          "Turn the swivelarm to the left");
--    l10n.add("en", "InputDesc_A3D_SwivelRight",                         "Turn the swivelarm to the right");

    l10n.add("en", "Input_A3D_Winch_Light",                             "Winch light");
    l10n.add("en", "Input_A3D_Remove_Groomer",                          "Remove groomer");
    l10n.add("en", "Input_A3D_Remove_Crawlers",                         "Remove crawlers");
    l10n.add("en", "Input_A3D_Remove_Blade",                            "Remove blade");
    l10n.add("en", "Input_A3D_Remove_Grommer_middle",                   "Remove groomerhydraulics");
    l10n.add("en", "Input_A3D_Add_Chain",                               "Chain anchor");
    l10n.add("en", "Input_A3D_Turn_On_Wipers",                          "Wipers");
    l10n.add("en", "Input_A3D_Turn_On_Mirrors",                         "Mirrors");
    l10n.add("en", "Input_A3D_Beacons_Lights",                          "Beacons lights");
    l10n.add("en", "Input_A3D_Change_Winch_To_Standart",                "Remove winch");
    l10n.add("en", "Input_A3D_Change_BisonX_To_Bison",                  "Remove bison X");
    l10n.add("en", "Input_A3D_Remove_Snowsat",                          "Remove snowsat");
    l10n.add("en", "Input_A3D_Remove_Shape_Academy",                    "Remove Shape Academy decals");
    l10n.add("en", "Input_A3D_Add_Transportbox",                        "Remove transportation crate");
    l10n.add("en", "Input_A3D_Winch_off",                               "Put the winch up");    
    l10n.add("en", "Input_A3D_Winch_on",                                "Put the winch down");
    l10n.add("en", "Input_A3D_Sticks_on",                               "Put the sticks up");
    l10n.add("en", "Input_A3D_Winch_back_off",                          "Put the winch backwards");    
    l10n.add("en", "Input_A3D_Winch_back_on",                           "Put the winch forward");
    l10n.add("en", "Input_A3D_open_Window",                             "Open skylight");    
    l10n.add("en", "Input_A3D_close_Window",                            "Close skylight"); 
    l10n.add("en", "Input_A3D_open_Transportbox",                       "Open flap");    
    l10n.add("en", "Input_A3D_close_Transportbox",                      "Close flap");    
    l10n.add("en", "Input_A3D_Sticks_off",                              "Put the sticks down");
    l10n.add("en", "Input_A3D_add_Chaine",                              "Add chain to hook");
    l10n.add("en", "Input_A3D_remove_Chaine",                           "Remove chain from hook");
    l10n.add("en", "A3D_Input_TT10_on",                                 "Tilt the tower");
    l10n.add("en", "A3D_Input_TT10_off",                                "Fold back the tower");

    l10n.add("en", "InputDesc_A3D_Winch_Light",                         "Switching the winch light on / off");    
    l10n.add("en", "InputDesc_A3D_Remove_Groomer",                      "Remove the groomer");
    l10n.add("en", "InputDesc_A3D_Remove_Crawlers",                     "Remove the crawlers");
    l10n.add("en", "InputDesc_A3D_Remove_Blade",                        "Remove blade");
    l10n.add("en", "InputDesc_A3D_Remove_Grommer_middle",               "Remove groomerhydraulics");    
    l10n.add("en", "InputDesc_A3D_Add_Chain",                           "Add a chain for blade anchor");    
    l10n.add("en", "InputDesc_A3D_Turn_On_Wipers",                      "Switching the wipers on / off");
    l10n.add("en", "InputDesc_A3D_Turn_On_Mirrors",                     "Switching the mirrors on / off");        
    l10n.add("en", "InputDesc_A3D_Beacons_Lights",                      "Switching the beacons lights on / off");
    l10n.add("en", "InputDesc_A3D_Change_Winch_To_Standart",            "Change the version winch to standart");
    l10n.add("en", "InputDesc_A3D_Change_BisonX_To_Bison",              "Change the version bison X to bison standart");
    l10n.add("en", "InputDesc_A3D_Remove_Snowsat",                      "Remove snowsat");
    l10n.add("en", "InputDesc_A3D_Remove_Shape_Academy",                "Remove Shape Academy decals");
    l10n.add("en", "InputDesc_A3D_Add_Transportbox",                    "Remove transportation crate");


    l10n.add("en", "A3D_MSG_UpdateInfo_Title",                          "SNOW.Control updated!");
    l10n.add("en", "A3D_MSG_UpdateInfo_Desc",                           "You are now using the SNOW.Control in version 1.1.6. You can find out what exactly is new in this version at www.alpin3d-design.com or on our social media channels.\nHave fun, your A3D & SRTD!");
end;

function addI18nDescDE()
    l10n.add("de", "A3D_CannonDesc_Peak",                               "Die Peak lohnt sich besonders bei breiten Pisten. Sufag zeichnet sich vor allem durch eine leistungsstarke Schneeerzeugung im Grenztemperaturbereich aus.");
    l10n.add("de", "A3D_CannonDesc_Power",                              "Die Compact Power bietet sich hervorragend für Pisten mittlerer Breite an. Sufag zeichnet sich vor allem durch eine leistungsstarke Schneeerzeugung im Grenztemperaturbereich aus.");
	l10n.add("de", "A3D_CannonDesc_TA_TR10",							"Jedes Einzelteil der TR10 wurde mit Präzision und Akribie entwickelt und stellt für sich allein ein herausragendes Produkt dar. Das Zusammenspiel dieser Komponenten übertrifft seine Einzelteile und schafft ein eigenes, unübertroffenes Werk.");
	l10n.add("de", "A3D_CannonDesc_TA_TL6",								"Die Schneilanze TL6 verfügt über eine Version mit einem 6m Lanzenarm und 10m Lanzenarm.");
	l10n.add("de", "A3D_CannonDesc_DemacLenko_TA_ST",					"Die Demaclenko FA und ST sind Schneekanonen, die alt sind, aber in einigen Skigebieten noch in Betrieb sind.");
	l10n.add("de", "A3D_VehicleDesc_Prinoth_Bison",						"Dieser vielseitige Allrounder ist nicht umsonst ein Kundenliebling. Die kompakte Grundfläche sorgt für optimale Manövrierfähigkeit, und der Caterpillar C9.3-Motor verleiht dem BISON die Kraft, um Snowparks in Form zu bringen.");
    l10n.add("de", "A3D_techSpecs_Prinoth_Bison",						"Motorleistung:\t\t406 PS\nSchild:\t\t\t12-way blade 4.5 m\nFräse:\t\t\tPOWER Fräse 6.2 m.");   
    l10n.add("de", "A3D_CannonDesc_TA_T40",                             "Die T40 ist die kompakteste Propellermaschine von TechnoAlpin und besticht durch ihre schlanken Maße und das geringe Gewicht. Die Schneekanone T40 verfügt über eine manuelle vertikale Höhenverstellung und eine motorisierte horizontale Schwenkvorrichtung mit manueller Entriegelung.");
    l10n.add("de", "A3D_CannonDesc_TA_TT10",                            "Die TT10 vereint die Garantie bester Schneequalität, optimaler Ressourcennutzung und höchster Benutzerfreundlichkeit mit einzigartiger Technologie und noch nie dagewesener Einfachheit.");

-- CannonDescs DE
    l10n.add("de", "A3D_CannonDesc_Peak_Mobile",                        "Die mobile Variante der SUFAG Peak kann individuell durch ein Pistengerät neu platziert werden");
    l10n.add("de", "A3D_CannonDesc_Power_Mobile",                       "Die mobile Variante der SUFAG Compact Power kann individuell durch ein Pistengerät neu platziert werden");
	l10n.add("de", "A3D_CannonDesc_Peak_3mTower",						"Der 3 m Turm ermöglicht eine Erhöhung der Fallhöhe des Schnees und damit neben der höheren Schneequalität auch eine Vergrößerung der Schneifläche.");
    l10n.add("de", "A3D_CannonDesc_Power_3mTower",						"Der 3 m Turm ermöglicht eine Erhöhung der Fallhöhe des Schnees und damit neben der höheren Schneequalität auch eine Vergrößerung der Schneifläche.");
	l10n.add("de", "A3D_CannonDesc_Peak_Tower4m",                       "Der kleinere 4 m Liftturm ermöglicht eine Erhöhung der Fallhöhe des Schnees und damit neben der höheren Schneequalität auch eine Vergrößerung der Schneifläche.");
    l10n.add("de", "A3D_CannonDesc_Power_Tower4m",                      "Der kleinere 4 m Liftturm ermöglicht eine Erhöhung der Fallhöhe des Schnees und damit neben der höheren Schneequalität auch eine Vergrößerung der Schneifläche.");
	l10n.add("de", "A3D_CannonDesc_Peak_5mTower",						"Der 5 m Turm ermöglicht eine Erhöhung der Fallhöhe des Schnees und damit neben der höheren Schneequalität auch eine Vergrößerung der Schneifläche.");
    l10n.add("de", "A3D_CannonDesc_Power_5mTower",						"Der 5 m Turm ermöglicht eine Erhöhung der Fallhöhe des Schnees und damit neben der höheren Schneequalität auch eine Vergrößerung der Schneifläche.");
    l10n.add("de", "A3D_CannonDesc_Peak_Tower6m",                       "Der größere 6 m Liftturm ermöglicht eine maximale Erhöhung der Fallhöhe des Schnees und damit neben der höheren Schneequalität auch eine maximale Vergrößerung der Schneifläche.");
    l10n.add("de", "A3D_CannonDesc_Power_Tower6m",                      "Der größere 6 m Liftturm ermöglicht eine maximale Erhöhung der Fallhöhe des Schnees und damit neben der höheren Schneequalität auch eine maximale Vergrößerung der Schneifläche.");
	l10n.add("de", "A3D_CannonDesc_Peak_Swivelarm8m",                   "The smaller 4 m lift tower makes it possible to increase the fall height of the snow and thus, in addition to the higher snow quality, to increase the snow surface.");
    l10n.add("de", "A3D_CannonDesc_Power_Swivelarm8m",                  "The smaller 4 m lift tower makes it possible to increase the fall height of the snow and thus, in addition to the higher snow quality, to increase the snow surface.");
    l10n.add("de", "A3D_CannonDesc_TA_TR10_Mobil",					    "Die Montage auf dem Unterwagen schafft Mobilität und Flexibilität. Das bewährte 3-Punkt-Transportsystem erlaubt einen einfachen Transport mit jedem Pistengerät.");
    l10n.add("de", "A3D_CannonDesc_TA_TR10_1,6mTurm",					"Pistenabschnitte mit großem Schneebedarf und schwer zugängliche Passagen sind der häufigste Einsatzbereich dieser Fixinstallation. UniversalturmHöhe: 1,6 m.");
    l10n.add("de", "A3D_CannonDesc_TA_TR10_Liftturm",				    "Manuell, motorisiert (mit HIT-TRAC) oder hydraulisch verstellbar – Standardhöhen: 3,5 m oder 4,5 m.");
    l10n.add("de", "A3D_CannonDesc_TA_TL6_6m",							"Die Schneilanze TL6 verfügt über 4 Düsenringe mit 6 Kombinationsmöglichkeiten. Jeder Düsenring verfügt dabei über 3 Düsen. Dadurch weist die Lanze eine enorme Schneileistung auf und produziert höchste Schneequalität.");
	l10n.add("de", "A3D_CannonDesc_TA_TL6_10m",							"Die Schneilanze TL6 verfügt über 4 Düsenringe mit 6 Kombinationsmöglichkeiten. Jeder Düsenring verfügt dabei über 3 Düsen. Dadurch weist die Lanze eine enorme Schneileistung auf und produziert höchste Schneequalität.");
	l10n.add("de", "A3D_CannonDesc_DemacLenko_FA3_Mobile",				"Die Demaclenko FA3 Schneekanone ist auch heute noch weit verbreitet und überzeugt durch gute Schneequalität trotz ihres hohen Alters.");
	l10n.add("de", "A3D_CannonDesc_DemacLenko_FA4_Mobile",				"Die Demaclenko FA4 Schneekanone ist auch heute noch weit verbreitet und überzeugt durch gute Schneequalität trotz ihres hohen Alters.");
	l10n.add("de", "A3D_CannonDesc_DemacLenko_FA5_Mobile",				"Die Demaclenko FA5 Schneekanone ist auch heute noch weit verbreitet und überzeugt durch gute Schneequalität trotz ihres hohen Alters.");
	l10n.add("de", "A3D_CannonDesc_DemacLenko_FA380_Mobile",			"Die Demaclenko FA380 Schneekanone ist auch heute noch weit verbreitet und überzeugt durch gute Schneequalität trotz ihres hohen Alters.");
	l10n.add("de", "A3D_CannonDesc_DemacLenko_ST380_Mobile",			"Die Demaclenko ST380 Schneekanone ist auch heute noch weit verbreitet und überzeugt durch gute Schneequalität trotz ihres hohen Alters.");
    l10n.add("de", "A3D_CannonDesc_DemacLenko_FA3_WT6",				    "Mit der Variante auf einem WT6 Turm bietet die Demaclenko FA3 noch mehr Vielfalt.");
    l10n.add("de", "A3D_CannonDesc_DemacLenko_FA4_WT6",			    	"Mit der Variante auf einem WT6 Turm bietet die Demaclenko FA4 noch mehr Vielfalt.");
    l10n.add("de", "A3D_CannonDesc_DemacLenko_FA5_WT6",		    		"Mit der Variante auf einem WT6 Turm bietet die Demaclenko FA5 noch mehr Vielfalt.");
    l10n.add("de", "A3D_CannonDesc_DemacLenko_FA380_WT6",   			"Mit der Variante auf einem WT6 Turm bietet die Demaclenko FA380 noch mehr Vielfalt.");
    l10n.add("de", "A3D_CannonDesc_DemacLenko_ST380_WT6",   			"Mit der Variante auf einem WT6 Turm bietet die Demaclenko ST380 noch mehr Vielfalt.");

-- VehicleDescs DE
    l10n.add("de", "A3D_VehicleDesc_BisonGrey",						    "Komfort und Luxus wie für einen König - der 'Thron' im BISON ist der mittig angeordnete Fahrersitz in der geräumigen Kabine, der optimale Sicht bietet.");   
    l10n.add("de", "A3D_VehicleDesc_BisonBlue",						    "Der BISON ist ein Allzweckfahrzeug, aber wenn es um Parks geht, dreht er richtig auf! Der enorme Bewegungsbereich von Schild und Fräse ermöglichen ein Maximum an Präzision und Effizienz bei der Präparierung und Pflege sämtlicher Parkelemente.");   
    l10n.add("de", "A3D_VehicleDesc_BisonGrey2021",						"Mit einer hochmodernen Kabine, dem saubersten Stage-V-Motor von Caterpillar und einem brandneuen Look ist der BISON das leistungsstärkste und komfortabelste Pistenfahrzeug seiner Klasse.");   
end;

function addI18nDescEN()
    l10n.add("en", "A3D_CannonDesc_Peak",                               "The Peak is particularly worthwhile on wide pistes. Sufag is characterised above all by powerful snow production in the temperature limit range.");
    l10n.add("en", "A3D_CannonDesc_Power",                              "The Compact Power is ideal for medium width slopes. Sufag is characterized above all by powerful snow production in the marginal temperature range.");
    l10n.add("en", "A3D_CannonDesc_TA_TR10",							"Every single part of the TR10 has been engineered with meticulous precision and is an outstanding product in its own right. The interaction of these components as a whole is sublime, surpassing the contributions of the individual parts and taking excellence to another level.");
    l10n.add("en", "A3D_CannonDesc_TL6",								"The TL6 snow lance has a version with a 6m lance arm and 10m lance arm.");
    l10n.add("en", "A3D_CannonDesc_DemacLenko_TA_ST",					"The Demaclenko FA and ST are snowcannons which are old but still in operation in some ski areas.");
    l10n.add("en", "A3D_VehicleDesc_Prinoth_Bison",						"This versatile all-rounder is a customer favorite for a reason. The working compact footprint provides optimal maneuverability, and the Caterpillar C9.3 engine gives the BISON the power to shape snowparks courses.");
    l10n.add("en", "A3D_techSpecs_Prinoth_Bison",						"Engine power:\t\t406 HP\nBlade:\t\t\t12-way blade 4.5 m\nTiller:\t\t\t\tPOWER Tiller 6.2 m.");   
    l10n.add("en", "A3D_CannonDesc_TA_TT10",						    "The TT10 is quite literally the TR10 fan-based snow producer taken to a whole new level. It combines the guarantee of top snow quality, optimum use of resources and maximum usability with unique technology and unprecedented simplicity.");   

-- CannonDescs EN
    l10n.add("en", "A3D_CannonDesc_Peak_Mobile",                        "The mobile version of SUFAG Peak can be individually repositioned by a snow groomer.");
    l10n.add("en", "A3D_CannonDesc_Power_Mobile",                       "The mobile version of SUFAG Compact Power can be individually repositioned by a snow groomer.");
	l10n.add("en", "A3D_CannonDesc_Peak_3mTower",						"The 3 m tower makes it possible to increase the fall height of the snow and thus, in addition to the higher snow quality, to increase the snow surface.");
	l10n.add("en", "A3D_CannonDesc_Power_3mTower",						"The 3 m tower makes it possible to increase the fall height of the snow and thus, in addition to the higher snow quality, to increase the snow surface.");
	l10n.add("en", "A3D_CannonDesc_Peak_Tower4m",                       "The smaller 4 m lift tower makes it possible to increase the fall height of the snow and thus, in addition to the higher snow quality, to increase the snow surface.");
    l10n.add("en", "A3D_CannonDesc_Power_Tower4m",                      "The smaller 4 m lift tower makes it possible to increase the fall height of the snow and thus, in addition to the higher snow quality, to increase the snow surface.");
	l10n.add("en", "A3D_CannonDesc_Peak_5mTower",						"The 5 m tower makes it possible to increase the fall height of the snow and thus, in addition to the higher snow quality, to increase the snow surface.");
	l10n.add("en", "A3D_CannonDesc_Power_5mTower",						"The 5 m tower makes it possible to increase the fall height of the snow and thus, in addition to the higher snow quality, to increase the snow surface.");
    l10n.add("en", "A3D_CannonDesc_Peak_Tower6m",                       "The larger 6 m lift tower allows a maximum increase in the fall height of the snow and thus in addition to the higher snow quality also a maximum enlargement of the snow surface.");
	l10n.add("en", "A3D_CannonDesc_Power_Tower6m",                      "The larger 6 m lift tower allows a maximum increase in the fall height of the snow and thus in addition to the higher snow quality also a maximum enlargement of the snow surface.");
	l10n.add("en", "A3D_CannonDesc_Peak_Swivelarm8m",                   "The smaller 4 m lift tower makes it possible to increase the fall height of the snow and thus, in addition to the higher snow quality, to increase the snow surface.");
    l10n.add("en", "A3D_CannonDesc_Power_Swivelarm8m",                  "The smaller 4 m lift tower makes it possible to increase the fall height of the snow and thus, in addition to the higher snow quality, to increase the snow surface.");
	l10n.add("en", "A3D_CannonDesc_TA_TR10_Mobil",					    "Die Montage auf dem Unterwagen schafft Mobilität und Flexibilität. Das bewährte 3-Punkt-Transportsystem erlaubt einen einfachen Transport mit jedem Pistengerät.");
    l10n.add("en", "A3D_CannonDesc_TA_TR10_1,6mTurm",					"Pistenabschnitte mit großem Schneebedarf und schwer zugängliche Passagen sind der häufigste Einsatzbereich dieser Fixinstallation. UniversalturmHöhe: 1,6 m.");
    l10n.add("en", "A3D_CannonDesc_TA_TR10_Liftturm",				    "Manuell, motorisiert (mit HIT-TRAC) oder hydraulisch verstellbar – Standardhöhen: 3,5 m oder 4,5 m.");
    l10n.add("en", "A3D_CannonDesc_TA_TL6_6m",							"The TL6 snow lance has four nozzle rings with six possible combinations. Each nozzle ring has three nozzles. Therefore the lance provides enormous snow output and produces snow of the highest quality.");
	l10n.add("en", "A3D_CannonDesc_TA_TL6_10m",							"The TL6 snow lance has four nozzle rings with six possible combinations. Each nozzle ring has three nozzles. Therefore the lance provides enormous snow output and produces snow of the highest quality.");
    l10n.add("en", "A3D_CannonDesc_DemacLenko_FA3_Mobile",				"The Demaclenko FA3 snowcannon is still widespread today and impresses with its good snow quality despite its old age.");
    l10n.add("en", "A3D_CannonDesc_DemacLenko_FA4_Mobile",				"The Demaclenko FA4 snowcannon is still widespread today and impresses with its good snow quality despite its old age.");
    l10n.add("en", "A3D_CannonDesc_DemacLenko_FA5_Mobile",				"The Demaclenko FA5 snowcannon is still widespread today and impresses with its good snow quality despite its old age.");
    l10n.add("en", "A3D_CannonDesc_DemacLenko_FA380_Mobile",			"The Demaclenko FA380 snowcannon is still widespread today and impresses with its good snow quality despite its old age.");
    l10n.add("en", "A3D_CannonDesc_DemacLenko_ST380_Mobile",			"The Demaclenko ST380 snowcannon is still widespread today and impresses with its good snow quality despite its old age.");
    l10n.add("en", "A3D_CannonDesc_DemacLenko_FA3_WT6",				    "With the variant on a WT6 tower, the Demaclenko FA3 offers even more variety.");
    l10n.add("en", "A3D_CannonDesc_DemacLenko_FA4_WT6",			    	"With the variant on a WT6 tower, the Demaclenko FA4 offers even more variety.");
    l10n.add("en", "A3D_CannonDesc_DemacLenko_FA5_WT6",		    		"With the variant on a WT6 tower, the Demaclenko FA5 offers even more variety.");
    l10n.add("en", "A3D_CannonDesc_DemacLenko_FA380_WT6",   			"With the variant on a WT6 tower, the Demaclenko FA380 offers even more variety.");
    l10n.add("en", "A3D_CannonDesc_DemacLenko_ST380_WT6",   			"With the variant on a WT6 tower, the Demaclenko ST380 offers even more variety.");

-- VehicleDescs EN
    l10n.add("en", "A3D_VehicleDesc_BisonGrey",						    "Comfort and luxury fit for a king – the 'throne' in the BISON is the centered operator seat in the roomy cabin, which offers optimal visibility.");   
    l10n.add("en", "A3D_VehicleDesc_BisonBlue",						    "While the BISON is an all-purpose vehicle, it is a true leader when it comes to parks. The incredible range of the blade and tiller enable precise and efficient preparation and maintenance of all park elements.");   
    l10n.add("en", "A3D_VehicleDesc_BisonGrey2021",						"With a state-of-the-art cockpit design, Caterpillar’s cleanest stage V engine, and a brand new look, BISON is both the most powerful and comfortable snow groomer in its class.");   
end;

addInputKeys();
addI18nKeysEN();
addI18nKeysDE();
addI18nDescDE();
addI18nDescEN();