
// --- Getters and setters for wrapper variables --- \\

// ==========
//   Hunger
// ==========

function PN_HungerOn()                  : bool       { return theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhuntoggle'); }
function PN_GetHungerCounter()          : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhuncounter')); }
function PN_GetHungerDamage()           : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhundamage')); }
function PN_GetHungerCombatAdd()        : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhuncombat')); }
function PN_GetHungerVitalityAdd()      : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhunvital')); }
function PN_GetHungerStaminaAdd()       : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhunstamina')); }
function PN_GetHungerAdrenalineAdd()    : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhunadrenaline')); }
function PN_GetHungerToxAdd()           : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhuntox')); }
function PN_GetHungerMaxFastTravel()    : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhunfast')); }
function PN_GetHungerMeditationMult()   : float      { var med : bool; med = thePlayer.GetPrimalNeeds().PeekMeditationFlag(); if (med) { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNhunger', 'PNhunmed')); } else { return 1; } }


// ==========
//   Thirst
// ==========

function PN_ThirstOn()                  : bool       { return theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrtoggle'); }
function PN_GetThirstCounter()          : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrcounter')); }
function PN_GetThirstCombatAdd()        : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrcombat')); }
function PN_GetThirstVitalityAdd()      : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrvital')); }
function PN_GetThirstStaminaAdd()       : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrstamina')); }
function PN_GetThirstAdrenalineAdd()    : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthradrenaline')); }
function PN_GetThirstToxAdd()           : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrtox')); }
function PN_GetThirstMaxFastTravel()    : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrfast')); }
function PN_GetThirstStaminaMult()      : float      { return (StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrstaminamult')) / 100) + 1.f; }
function PN_GetShallowThirstRise()      : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrshallow')); }
function PN_GetShallowPukeLevel()       : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrshallowpuke')); }
function PN_GetShallowTox()             : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrshallowtox')); }
function PN_GetThirstMeditationMult()   : float      { var med : bool; med = thePlayer.GetPrimalNeeds().PeekMeditationFlag(); if (med) { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNthirst', 'PNthrmed')); } else { return 1; } }

// ==========
//  Fatigue
// ==========

function PN_FatigueOn()                 : bool       { return theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfattoggle'); } 
function PN_GetFatigueCounter()         : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatcounter')); }
function PN_GetFatigueCombatAdd()       : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatcombat')); }
function PN_GetFatigueVitalityAdd()     : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatvital')); }
function PN_GetFatigueStaminaAdd()      : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatstamina')); }
function PN_GetFatigueAdrenalineAdd()   : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatadrenaline')); }
function PN_GetFatigueToxAdd()          : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfattox')); }
function PN_GetFatigueMaxFastTravel()   : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatfast')); }
function PN_GetOverEatMult()            : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatovereat'));}
function PN_GetOverDrinkMult()          : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatoverdrink'));}
function PN_GetFatigueWeightAdd()       : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatweight'));}
function PN_GetFatigueWeightThreshold() : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatweightthr')) / 100.f;}
function PN_GetLightArmorAdd()          : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatlight'));}
function PN_GetMediumArmorAdd()         : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatmedium'));}
function PN_GetHeavyArmorAdd()          : float      { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfatigue', 'PNfatheavy'));}

// ==============
//  Pee and Poop
// ==============

function PN_PeeOn()                     : bool       { return theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpeeon'); }
function PN_PoopOn()                    : bool       { return theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpoopon'); }
function PN_PeeRisePerDrink()           : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpeeperdrink'));}
function PN_PeeRisePerOverdrink()       : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpeeperoverdrink'));}
function PN_PoopRisePerEat()            : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpooppereat'));}
function PN_PoopRisePerOvereat()        : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpoopperovereat'));}
function PN_GetPukeThirstCap()          : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpukethr')); }
function PN_GetPukeHungerCap()          : int        { return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('PNpp', 'PNpukehun')); }

// ==========
//    HUD
// ==========

function PN_ToggleHud()                              { if (PN_HudOn()) PN_ResetHud(); else PN_SetHud(); }
function PN_HudOn() 				: bool           { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudon'); }
function PN_SetHud()                                 { theGame.GetInGameConfigWrapper().SetVarValue('PNhud', 'PNhudon', true); }
function PN_ResetHud()                               { theGame.GetInGameConfigWrapper().SetVarValue('PNhud', 'PNhudon', false); }
function PN_UpdateHud()                              { theGame.GetGuiManager().GetHudEventController().RunEvent_ControlsFeedbackModule_Update( 'PrimalNeeds' );}
function PN_HudAlwaysOn() 			: bool           { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudaon'); }
function PN_HUDNeedSpeedOn() 		: bool           { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudspeedon'); }
function PN_HUDNeedTimeLeftOn() 	: bool           { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudtimeon'); }
function PN_FactorHungerSpeed() 	: bool           { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudhfac'); }
function PN_FactorThirstSpeed() 	: bool           { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudtfac'); }
function PN_FactorFatigueSpeed() 	: bool           { return theGame.GetInGameConfigWrapper().GetVarValue('PNhud', 'PNhudffac'); }


// ==========================
//		Food And Drinks
// ==========================

function PN_GetFed1Duration()   : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNfed1dur'));}
function PN_GetFed2Duration()   : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNfed2dur'));}
function PN_GetFed3Duration()   : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNfed3dur'));}
function PN_GetHyd1Duration()   : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNhyd1dur'));}
function PN_GetHyd2Duration()   : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNhyd2dur'));}
function PN_GetHyd3Duration()   : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNhyd3dur'));}
function PN_GetFed1Heal()       : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNfed1heal'));}
function PN_GetFed2Heal()       : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNfed2heal'));}
function PN_GetFed3Heal()       : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNfed3heal'));}
function PN_GetHyd1Heal()       : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNhyd1heal'));}
function PN_GetHyd2Heal()       : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNhyd2heal'));}
function PN_GetHyd3Heal()       : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNhyd3heal'));}
function PN_GetFed1CombatHeal() : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNfed1combatheal'));}
function PN_GetFed2CombatHeal() : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNfed2combatheal'));}
function PN_GetFed3CombatHeal() : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNfed3combatheal'));}
function PN_GetHyd1CombatHeal() : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNhyd1combatheal'));}
function PN_GetHyd2CombatHeal() : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNhyd2combatheal'));}
function PN_GetHyd3CombatHeal() : float         { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNfood', 'PNhyd3combatheal'));}


// ==========
//    Misc
// ==========

function PN_Initalized() : bool                 { return theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNinit'); }
function PN_GetVersion() : float                { return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNversion')); }
function PN_ExpireOn() : bool                   { return theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNexptoggle'); }
function PN_Notify( text : string)              { theGame.GetGuiManager().ShowNotification( text , 5000 ); }
function PN_HudNotify( text : string )          { thePlayer.DisplayHudMessage( text );}
function PN_ConsumeCombatOn() : bool            { return theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNconsumecombaton'); }
function PN_AllowAnimsInCombat() : bool         { return theGame.GetInGameConfigWrapper().GetVarValue('PNmisc', 'PNanimcombat'); }


// ==============
//      PATCH
// ==============
function PN_IsPatch() : bool { return false; }

// --- Initialisation --- //
function PN_Init() {
	
	var wrapper : CInGameConfigWrapper;
	wrapper = theGame.GetInGameConfigWrapper();
	
	if (!PN_Initalized()) {
		// Hunger
		wrapper.SetVarValue('PNhunger', 'PNhuntoggle', true);
		wrapper.SetVarValue('PNhunger', 'PNhuncounter', "15");
		wrapper.SetVarValue('PNhunger', 'PNhundamage', "10");
		wrapper.SetVarValue('PNhunger', 'PNhuncombat', "0.1");
		wrapper.SetVarValue('PNhunger', 'PNhunvital', "0.8");
		wrapper.SetVarValue('PNhunger', 'PNhunstamina', "0.2");
		wrapper.SetVarValue('PNhunger', 'PNhunadrenaline', "0.5");
		wrapper.SetVarValue('PNhunger', 'PNhuntox', "0.5");
		wrapper.SetVarValue('PNhunger', 'PNhunmed', "0.1");
		wrapper.SetVarValue('PNhunger', 'PNhunfast', "7");
		
		// Thirst
		wrapper.SetVarValue('PNthirst', 'PNthrtoggle', true );
		wrapper.SetVarValue('PNthirst', 'PNthrfast', "9" );
		wrapper.SetVarValue('PNthirst', 'PNthrcounter', "5" );
		wrapper.SetVarValue('PNthirst', 'PNthrcombat', "0.3" );
		wrapper.SetVarValue('PNthirst', 'PNthrvital', "0.1" );
		wrapper.SetVarValue('PNthirst', 'PNthrstamina', "0.5" );
		wrapper.SetVarValue('PNthirst', 'PNthradrenaline', "0.2" );
		wrapper.SetVarValue('PNthirst', 'PNthrtox', "0.7" );
		wrapper.SetVarValue('PNthirst', 'PNthrmed', "0.1" );
		wrapper.SetVarValue('PNthirst', 'PNthrstaminamult', "50");
		wrapper.SetVarValue('PNthirst', 'PNthrshallow', "5");
		wrapper.SetVarValue('PNthirst', 'PNthrshallowpuke', "5");
		wrapper.SetVarValue('PNthirst', 'PNthrshallowtox', "10");
		
		// Fatigue
		wrapper.SetVarValue('PNfatigue', 'PNfattoggle', "1" );
		wrapper.SetVarValue('PNfatigue', 'PNfatcounter', "20" );
		wrapper.SetVarValue('PNfatigue', 'PNfatfast', "5" );
		wrapper.SetVarValue('PNfatigue', 'PNfatcombat', "1.0" );
		wrapper.SetVarValue('PNfatigue', 'PNfatvital', "0.4" );
		wrapper.SetVarValue('PNfatigue', 'PNfatstamina', "0.2" );
		wrapper.SetVarValue('PNfatigue', 'PNfatadrenaline', "0" );
		wrapper.SetVarValue('PNfatigue', 'PNfattox', "0" );
		wrapper.SetVarValue('PNfatigue', 'PNfatovereat', "0.2" );
		wrapper.SetVarValue('PNfatigue', 'PNfatoverdrink', "0.1" );
		wrapper.SetVarValue('PNfatigue', 'PNfatweight', "1.0");
		wrapper.SetVarValue('PNfatigue', 'PNfatweightthr', "50");
		wrapper.SetVarValue('PNfatigue', 'PNfatlight', "0.05");
		wrapper.SetVarValue('PNfatigue', 'PNfatmedium', "0.15");
		wrapper.SetVarValue('PNfatigue', 'PNfatheavy', "0.25");
		
		// Pee and Poop
		wrapper.SetVarValue('PNpp', 'PNpeeon', true );
		wrapper.SetVarValue('PNpp', 'PNpoopon', true );
		wrapper.SetVarValue('PNpp', 'PNpukethr', "8" );
		wrapper.SetVarValue('PNpp', 'PNpukehun', "5" );
		wrapper.SetVarValue('PNpp', 'PNpeeperdrink', "1" );
		wrapper.SetVarValue('PNpp', 'PNpeeperoverdrink', "2" );
		wrapper.SetVarValue('PNpp', 'PNpooppereat', "1" );
		wrapper.SetVarValue('PNpp', 'PNpoopperovereat', "2" );
		
		// Animations
		wrapper.SetVarValue('PNanim', 'PNeat', true );
		wrapper.SetVarValue('PNanim', 'PNdrink', true );
		wrapper.SetVarValue('PNanim', 'PNpuke', true );
		wrapper.SetVarValue('PNanim', 'PNpee', true );
		wrapper.SetVarValue('PNanim', 'PNpoop', true );
		wrapper.SetVarValue('PNanim', 'PNsleep', true );
		wrapper.SetVarValue('PNanim', 'PNoil', true);
		wrapper.SetVarValue('PNanim', 'PNinv', true);
		wrapper.SetVarValue('PNanim', 'PNloot', true);
		wrapper.SetVarValue('PNanim', 'PNgrindstone', true);
		wrapper.SetVarValue('PNanim', 'PNworkbench', true);
		wrapper.SetVarValue('PNanim', 'PNalteat', false );
		wrapper.SetVarValue('PNanim', 'PNaltdrink', false );	
		wrapper.SetVarValue('PNanim', 'PNhorndrink', true);
		wrapper.SetVarValue('PNanim', 'PNhorneat', true);
		
		// Animation Speeds
		wrapper.SetVarValue('PNanimspeed', 'PNpeesp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNpoopsp', "1.4" );
		wrapper.SetVarValue('PNanimspeed', 'PNdrinksp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNdrink2sp', "2.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNeatsp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNeat2sp', "1.2" );
		wrapper.SetVarValue('PNanimspeed', 'PNpukesp', "0.8" );
		wrapper.SetVarValue('PNanimspeed', 'PNcollapsesp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNoilsp', "0.4" );
		wrapper.SetVarValue('PNanimspeed', 'PNgrindstonesp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNworkbenchsp', "1.0" );
		wrapper.SetVarValue('PNanimspeed', 'PNlootstartsp', "1.2" );
		wrapper.SetVarValue('PNanimspeed', 'PNlootstopsp', "1.6" );
		wrapper.SetVarValue('PNanimspeed', 'PNdblootstartsp', "1.35" );
		wrapper.SetVarValue('PNanimspeed', 'PNdblootstopsp', "1.75" );
		
		// Hud
		wrapper.SetVarValue('Hud', 'ControlsFeedbackModule', true);
		wrapper.SetVarValue('PNhud', 'PNhudaon', true);
		wrapper.SetVarValue('PNhud', 'PNhudon', true);
		wrapper.SetVarValue('PNhud', 'PNhudspeedon', true);
		wrapper.SetVarValue('PNhud', 'PNhudtimeon', true);
		wrapper.SetVarValue('PNhud', 'PNhudhfac', true);
		wrapper.SetVarValue('PNhud', 'PNhudtfac', true);
		wrapper.SetVarValue('PNhud', 'PNhudffac', true);
		
		// Misc
		wrapper.SetVarValue('PNmisc', 'PNmed', false);
		wrapper.SetVarValue('PNmisc', 'PNdiff', false);
		wrapper.SetVarValue('PNmisc', 'PNexptoggle', true);
		wrapper.SetVarValue('PNmisc', 'PNconsumecombaton', true);
		wrapper.SetVarValue('PNmisc', 'PNfeed1', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNfeed2', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNfeed3', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNfeed4', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNdrink1', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNdrink2', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNdrink3', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNdrink4', "1.0");
		wrapper.SetVarValue('PNmisc', 'PNanimcombat', true);
		
		// Friendly Meditation by Wasteland ghost81
		wrapper.SetVarValue('modFriendlyMeditation', 'fmedMaxHoursPerMinute', "60");
		wrapper.SetVarValue('modFriendlyMeditation', 'fmedHoursPerMinutePerSecond', "10");
		wrapper.SetVarValue('modFriendlyMeditation', 'fmedUseTimescale', false);
		wrapper.SetVarValue('modFriendlyMeditation', 'fmedSpawnCampfire', false);
		wrapper.SetVarValue('modFriendlyMeditation', 'fmedFullHealthRegenAnyDifficulty', false);
		wrapper.SetVarValue('modFriendlyMeditation', 'fmedRefillPotionsWhileMeditating', true);
		wrapper.SetVarValue('modFriendlyMeditation', 'fmedResetRefillSettingToDefaultAfterMeditation', true);
		wrapper.SetVarValue('modFriendlyMeditation', 'fmedRefillIntervalMins', "60");
		wrapper.SetVarValue('modFriendlyMeditation', 'fmedHotkeyAsToggle', false);
		
		// Toggles
		wrapper.SetVarValue('CAanim', 'CAeat', "0" );
		wrapper.SetVarValue('CAanim', 'CAdrink', "0" );
		wrapper.SetVarValue('CAanim', 'CAoil', true);
		wrapper.SetVarValue('CAanim', 'CAloot', "0");
		wrapper.SetVarValue('CAanim', 'CAgrindstone', "1");
		wrapper.SetVarValue('CAanim', 'CAworkbench', "1");
		wrapper.SetVarValue('CAanim', 'CApee', true);
		wrapper.SetVarValue('CAanim', 'CApoop', true);
		
		// Animation Speeds
		wrapper.SetVarValue('CAanimspeed', 'CAdrinksp', "1.0" );
		wrapper.SetVarValue('CAanimspeed', 'CAeatsp', "1.0" );
		wrapper.SetVarValue('CAanimspeed', 'CAoilsp', "1.0" );
		wrapper.SetVarValue('CAanimspeed', 'CAgrindstonesp', "1.0" );
		wrapper.SetVarValue('CAanimspeed', 'CAworkbenchsp', "1.0" );
		wrapper.SetVarValue('CAanimspeed', 'CAlootstartsp', "1.0" );
		wrapper.SetVarValue('CAanimspeed', 'CAdblootstartsp', "1.0" );
		wrapper.SetVarValue('CAanimspeed', 'CAshallowsp', "1.0" );
		wrapper.SetVarValue('CAanimspeed', 'CAcollapsesp', "1.0" );
		wrapper.SetVarValue('CAanimspeed', 'CApeesp', "1.0" );
		wrapper.SetVarValue('CAanimspeed', 'CApoopsp', "1.0" );
	
		// Settings
		wrapper.SetVarValue('CAsettings', 'CAanimcombat', true);
		wrapper.SetVarValue('CAsettings', 'CAinv', true);
		wrapper.SetVarValue('CAsettings', 'CAautooil', true);
		wrapper.SetVarValue('CAsettings', 'CAautogrind', true);
		wrapper.SetVarValue('CAsettings', 'CAoilcombat', false);
		
		// Version
		wrapper.SetVarValue('PNmisc', 'PNversion', "2.0");
		wrapper.SetVarValue('PNmisc', 'PNinit', true);
		
		thePlayer.PN_Init();
		PN_HudNotify("Primal Needs: Initialized!");
	} else {
		// PN_HudNotify("Primal Needs: Already Initialized!");
	}
}

