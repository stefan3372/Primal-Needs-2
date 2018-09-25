class NeedsController 
{
	// needs
	public var hunger : int;
	public var thirst : int;
	public var fatigue : int;
	public var pee : int;
	public var poop : int;

	// counters
	private var hungercnt : float;
	private var thirstcnt : float;
	private var fatiguecnt : float;

	// helpers
	private var daychanged : int;
	private var lasttime : int;
	private var medflag : bool;
	
	public function SetHunger( val : int )       { CheckVal(val); hunger = val; }	
	public function SetThirst( val : int )       { CheckVal(val); thirst = val; }
	public function SetFatigue( val : int )      { CheckVal(val); fatigue = val; }
	public function SetPee( val : int )          { CheckVal(val); pee = val; }
	public function SetPoop( val : int )         { CheckVal(val); poop = val; }
	public function GetHunger() : int            { return hunger; }
	public function GetThirst() : int            { return thirst; }
	public function GetFatigue() : int           { return fatigue; }
	public function GetPee() : int               { return pee; }
	public function GetPoop() : int              { return poop; }
	
	public function Meditate( mins : int ) { var dec : float; dec = (float) mins / 3.6; SetFatigue(RoundMath( fatigue - dec )); ResetFatigueCnt(); }
	public function MeditateDrop( mins : int ) { var dec : float; dec = (float) mins; SetFatigue(RoundMath( fatigue - dec )); ResetFatigueCnt(); }
	public function Feed( fed : int ) { if ( PN_HungerOn() ) { if (PN_PoopOn() && fed > 0) RisePoop(PN_PoopRisePerEat()); SetHunger( hunger - fed ); ResetHungerCnt(); } }
	public function Drink( drink : int ) { if ( PN_ThirstOn() ) { if (PN_PeeOn() && drink > 0) RisePee(PN_PeeRisePerDrink()); SetThirst( thirst - drink ); ResetThirstCnt(); } }
	public function DrinkShallow( drink : int ) { if ( PN_ThirstOn() ) { thePlayer.abilityManager.GainStat( BCS_Toxicity, PN_GetShallowTox() ); SetThirst( thirst - drink ); ResetThirstCnt(); } }
	public function DrinkShallowWater() { if ( PN_ThirstOn() ) { if (thePlayer.IsInShallowWater()) { thePlayer.GetPrimalAnims().ShallowAnim(); } else { PN_HudNotify( GetLocStringByKeyExt("HUDmessage_NoShallowWaterToDrink") ); } } }

	function Pee() {
		if (PN_PeeOn()) {
			theGame.GetBehTreeReactionManager().CreateReactionEventIfPossible( thePlayer, 'DrawSwordAction', -1, 10.0f, -1, 9999, true); 
			thePlayer.GetPrimalAnims().PeeAnim();
		}
	}

	function Poop() {
		if (PN_PoopOn()) {
			theGame.GetBehTreeReactionManager().CreateReactionEventIfPossible( thePlayer, 'DrawSwordAction', -1, 10.0f, -1, 9999, true); 
			thePlayer.GetPrimalAnims().PoopAnim();
		}
	}
	
	public function RiseHunger( diff : int ) {
		if ( diff > 1 ) {
			if (!medflag) {
				if (diff / PN_GetHungerCounter() >= PN_GetHungerMaxFastTravel()) {
					diff = PN_GetHungerMaxFastTravel() * PN_GetHungerCounter();
				}
			}
			Feed( RoundMath(((float) diff / (float) PN_GetHungerCounter()) * ( -1 ) * PN_GetHungerMeditationMult()));
		} else {
			DecHungerCnt( PN_GetHungerInc() );
		}
	}

	public function RiseThirst( diff : int ) {
		if ( diff > 1 ) {
			if (!medflag) {
				if (diff / PN_GetThirstCounter() >= PN_GetThirstMaxFastTravel()) {
					diff = PN_GetThirstMaxFastTravel() * PN_GetThirstCounter();
				}
			}
			Drink( RoundMath(((float) diff / (float) PN_GetThirstCounter()) * ( -1 ) * PN_GetThirstMeditationMult()));
		} else {
			DecThirstCnt( PN_GetThirstInc() );
		}
	}

	public function RiseFatigue( diff : int ) {
		if (!medflag) {
			if ( diff > 1 ) {
				if (diff / PN_GetFatigueCounter() >= PN_GetFatigueMaxFastTravel()) {
					diff = PN_GetFatigueMaxFastTravel() * PN_GetFatigueCounter();
				}
				MeditateDrop( RoundMath( ( (float) diff / (float) PN_GetFatigueCounter() ) * ( -1 ) ) );
			} else {
				DecFatigueCnt( PN_GetFatigueInc() );
			}
		} else {
			Meditate( diff );
		}
	}

	public function RisePee( val : int ) {
		if (PN_PeeOn()) {
			SetPee( pee + val);
		}
	}

	public function RisePoop( val : int ) {
		if (PN_PoopOn()) {
			SetPoop( poop + val );
		}
	}
	
	public function ResetHungerCnt()             { hungercnt = PN_GetHungerCounter(); }
	public function ResetThirstCnt()             { thirstcnt = PN_GetThirstCounter(); }
	public function ResetFatigueCnt()            { fatiguecnt = PN_GetFatigueCounter(); }
	public function DecHungerCnt( val : float )  { hungercnt -= val; }
	public function DecThirstCnt( val : float )  { thirstcnt -= val; }
	public function DecFatigueCnt( val : float ) { fatiguecnt -= val; }
	public function GetHungerCnt() : float       { return hungercnt; }
	public function GetThirstCnt() : float       { return thirstcnt; }
	public function GetFatigueCnt() : float      { return fatiguecnt; }

	public function SetDayChanged( val : int )   { daychanged = val; }
	public function IncDayChanged()              { daychanged += 1; }
	public function GetDayChanged() : int        { return daychanged; }
	public function SetLastTime( val : int )     { lasttime = val; }
	public function GetLastTime() : int          { return lasttime; }
	public function SetMeditationFlag()          { medflag = true; }
	public function PeekMeditationFlag() : bool  { return medflag; }
	public function ResetMeditationFlag()        { medflag = false;}
	
	// misc
	private function CheckVal( out val : int )   { if ( val > 100 ) val = 100; if ( val < 0 ) val = 0; }
	public function ResetNeeds() {
		hunger = 0; thirst = 0; fatigue = 0;
		pee = 0; poop = 0;
		ResetHungerCnt();
		ResetThirstCnt();
		ResetFatigueCnt();
	}

	public function Init()
	{	
		SetLastTime(GameTimeToSeconds(theGame.GetGameTime()) / 60);
		ResetNeeds();
	}
	
	// timers
	public function TimePass()
	{
		var dayNow : int;
		var time : int;
		var diff : int;

		print("is this working?");
				
		dayNow = GameTimeDays(theGame.GetGameTime());
		time = GameTimeToSeconds(theGame.GetGameTime()) / 60;

		PN_Notify("time");

		if ( thePlayer.IsCiri() ) {
			return;
		}

		// Real Time Meditation Support
		if ( thePlayer.GetCurrentStateName() == 'AlchemyBrewing' 		  	// Primer support
		  || thePlayer.GetCurrentStateName() == 'ExplorationMeditation' 	// Preparation + Friendly Meditation support
		  || thePlayer.GetCurrentStateName() == 'W3EEMeditation' ) {	 	// W3EE support
			SetMeditationFlag();
		}
		
		// Forced Urinating or Defecating
		if (PN_PeeOn() && pee >= 100)
			Pee();
		if (PN_PoopOn() && poop >= 100)
			Poop();
			
		// Forced Collapse
		if ( fatigue == 100 ) {
			thePlayer.GetPrimalAnims().CollapseAnim();
		}
		
		diff = time - GetLastTime();
		SetLastTime(time);

		if (PN_ExpireOn()) {
			if ( GetDayChanged() != dayNow) {
				IncDayChanged();
				thePlayer.GetPrimalFood().ExpireTheFood();
			}
		}
		
		if ( GetFloat("pauseneeds") ) {		
			if ( PeekMeditationFlag() ) {
				ResetMeditationFlag();
			}
			return;
		}
		
		if (PN_HungerOn()) {
			RiseHunger( diff );
			if ( GetHungerCnt() <= 0 ) {
				SetHunger( GetHunger() + 1 );
				ResetHungerCnt();
			}
		}
		
		if (PN_ThirstOn()) {
			RiseThirst( diff );
			if ( GetThirstCnt() <= 0 ) {
				SetThirst( GetThirst() + 1 );
				ResetThirstCnt();
			}
		}
		
		if (PN_FatigueOn()) {
			RiseFatigue( diff );
			if ( GetFatigueCnt() <= 0 ) {
				SetFatigue( GetFatigue() + 1 );
				ResetFatigueCnt();
			}
		}
		
		if ( PeekMeditationFlag() ) {
			ResetMeditationFlag();
		}
	}
}

function PN_GetHungerInc() : float {
	var combatadd : float;
	var healthadd : float;
	var totaladd : float;
	var staminaadd : float;
	var adrenalineadd : float;
	var toxadd : float;
	
	combatadd = 0;
	if ( thePlayer.IsInCombat() ) {
		combatadd = PN_GetHungerCombatAdd();
	}
	healthadd = (1 - (thePlayer.GetStat(BCS_Vitality) / thePlayer.GetStatMax(BCS_Vitality))) * PN_GetHungerVitalityAdd();
	staminaadd = (1 - (thePlayer.GetStat(BCS_Stamina) / thePlayer.GetStatMax(BCS_Stamina))) * PN_GetHungerStaminaAdd();
	if (!PN_IsPatch())
		adrenalineadd = (thePlayer.GetStat(BCS_Focus) / thePlayer.GetStatMax(BCS_Focus)) * PN_GetHungerAdrenalineAdd();
	else
		adrenalineadd = (1 - (thePlayer.GetStat(BCS_Focus) / thePlayer.GetStatMax(BCS_Focus))) * PN_GetHungerAdrenalineAdd() * (-1.f);
	toxadd = (thePlayer.GetStat(BCS_Toxicity) / thePlayer.GetStatMax(BCS_Toxicity)) * PN_GetHungerToxAdd();
	totaladd = 1 + combatadd + healthadd + staminaadd - adrenalineadd - toxadd;
	if (totaladd < 0) { totaladd = 0; } 
	return totaladd;
}
function PN_GetThirstInc() : float {
	var combatadd : float;
	var healthadd : float;
	var totaladd : float;
	var staminaadd : float;
	var adrenalineadd : float;
	var toxadd : float;
	
	combatadd = 0;
	if ( thePlayer.IsInCombat() ) {
		combatadd = PN_GetThirstCombatAdd();
	}
	healthadd = (1 - (thePlayer.GetStat(BCS_Vitality) / thePlayer.GetStatMax(BCS_Vitality))) * PN_GetThirstVitalityAdd();
	staminaadd = (1 - (thePlayer.GetStat(BCS_Stamina) / thePlayer.GetStatMax(BCS_Stamina))) * PN_GetThirstStaminaAdd();
	if (!PN_IsPatch())
		adrenalineadd = (thePlayer.GetStat(BCS_Focus) / thePlayer.GetStatMax(BCS_Focus)) * PN_GetThirstAdrenalineAdd();
	else 
		adrenalineadd = (1 - (thePlayer.GetStat(BCS_Focus) / thePlayer.GetStatMax(BCS_Focus))) * PN_GetThirstAdrenalineAdd() * (-1.f);
	toxadd = (thePlayer.GetStat(BCS_Toxicity) / thePlayer.GetStatMax(BCS_Toxicity)) * PN_GetThirstToxAdd();
	totaladd = 1 + combatadd + healthadd + staminaadd - adrenalineadd - toxadd;
	if (totaladd < 0) { totaladd = 0; } 
	return totaladd;
}
function PN_GetFatigueInc() : float {
	var combatadd : float;
	var healthadd : float;
	var totaladd : float;
	var staminaadd : float;
	var adrenalineadd : float;
	var toxadd : float;
	var weightadd : float;
	var hasHorseUpgrade : bool;
	var weightPercent : float;
	
	combatadd = 0;
	if ( thePlayer.IsInCombat() ) {
		combatadd = PN_GetFatigueCombatAdd();
	}
	weightPercent = GetWitcherPlayer().GetEncumbrance() / GetWitcherPlayer().GetMaxRunEncumbrance(hasHorseUpgrade);
	healthadd = (1 - (thePlayer.GetStat(BCS_Vitality) / thePlayer.GetStatMax(BCS_Vitality))) * PN_GetFatigueVitalityAdd();
	staminaadd = (1 - (thePlayer.GetStat(BCS_Stamina) / thePlayer.GetStatMax(BCS_Stamina))) * PN_GetFatigueStaminaAdd();
	if (!PN_IsPatch())
		adrenalineadd = (thePlayer.GetStat(BCS_Focus) / thePlayer.GetStatMax(BCS_Focus)) * PN_GetFatigueAdrenalineAdd();
	else 
		adrenalineadd = (1 - (thePlayer.GetStat(BCS_Focus) / thePlayer.GetStatMax(BCS_Focus))) * PN_GetFatigueAdrenalineAdd() * (-1.f);
	toxadd = (thePlayer.GetStat(BCS_Toxicity) / thePlayer.GetStatMax(BCS_Toxicity)) * PN_GetFatigueToxAdd();
	if (weightPercent >= PN_GetFatigueWeightThreshold()) {
		weightadd = weightPercent * PN_GetFatigueWeightAdd();
	} else {
		weightadd = 0;
	}
	totaladd = 1 + combatadd + healthadd + staminaadd + weightadd + PN_ArmorType() - adrenalineadd - toxadd;
	if (totaladd < 0) { totaladd = 0; } 
	return totaladd;
}

exec function ResetNeeds() {
	thePlayer.GetPrimalNeeds().ResetNeeds();
}

//exec function PauseNeeds() {
//	SetBool("pauseneeds", true);
//}
//
//exec function ResumeNeeds() {
//	SetBool("pauseneeds", false);
//}
//
//exec function reinit() {
//	SetBool("initialized", false);
//}
