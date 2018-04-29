function PN_Effects() {
	if ( PN_HungerOn() ) PN_HungerEffects();
	if ( PN_FatigueOn() ) PN_FatigueEffects();
}

// ==========
//   Hunger
// ==========

function PN_HungerEffects() {
	var witcher : W3PlayerWitcher;
	var currVital : float;
	var vitalDrain : float;
	
	witcher = GetWitcherPlayer();
	if (thePlayer.GetPrimalNeeds().GetHunger() >= 50) {
		currVital = thePlayer.GetStat(BCS_Vitality);
		vitalDrain = PN_GetHungerEffectsMult();
		
		if (currVital - vitalDrain <= 0.f) 
		{
			thePlayer.DrainVitality( currVital - 1 );
			thePlayer.AddEffectDefault( EET_VitalityDrain, thePlayer, "Starvation", false );
		}
		else 
		{
			thePlayer.DrainVitality( vitalDrain );
		}
	}
}

function PN_GetHungerEffectsMult() : float {
	if ( PN_HungerOn() ) {
		return (float) PN_GetHungerDamage() * ( (float) thePlayer.GetPrimalNeeds().GetHunger() / 100 );
	} else {
		return 0;
	}
}

function PN_GetHungerAdrenalineDrain() : float {
	if (PN_HungerOn()) {
		if (PN_IsPatch())
			return 1.5 - ((float) thePlayer.GetPrimalNeeds().GetHunger() / 100 );
		else 
			return (float) thePlayer.GetPrimalNeeds().GetHunger() / 100 + 0.5;
	} else {
		return 1;
	}
}

// ==========
//   Thirst
// ==========

function PN_GetThirstStaminaRegenMult() : float {
	if ( PN_ThirstOn() ) {
		return PN_GetThirstStaminaMult() - ( ((float) thePlayer.GetPrimalNeeds().GetThirst() * PN_GetThirstStaminaMult()) / 100 );
	} else {
		return 1;
	}
}

// ===========
//   Fatigue
// ===========

function PN_ArmorType() : float {
	var witcher : W3PlayerWitcher;
	var armor : SItemUniqueId;
	var gloves : SItemUniqueId;
	var pants : SItemUniqueId;
	var boots : SItemUniqueId;
	var total : float ;
	var items : array <SItemUniqueId>;
	var i : int ;
	
	witcher = GetWitcherPlayer();
	total = 0;
	
	witcher.GetItemEquippedOnSlot(EES_Armor, armor); items.PushBack (armor);
	witcher.GetItemEquippedOnSlot(EES_Gloves, gloves); items.PushBack (gloves);
	witcher.GetItemEquippedOnSlot(EES_Boots, pants); items.PushBack (pants);
	witcher.GetItemEquippedOnSlot(EES_Pants, boots); items.PushBack (boots);
	
	for( i = 0; i < items.Size(); i += 1 ) {	
		if( witcher.inv.ItemHasTag(items[i], 'LightArmor'))
			total += PN_GetLightArmorAdd();
		else if( witcher.inv.ItemHasTag(items[i], 'MediumArmor'))
			total += PN_GetMediumArmorAdd();
		else if( witcher.inv.ItemHasTag(items[i], 'HeavyArmor'))
			total += PN_GetHeavyArmorAdd();
	}
	return total;
}

function PN_FatigueEffects() {
	if ( PN_FatigueLevel5() ) {
		thePlayer.SetWalkToggle( true );
	}
}

function PN_FatigueLevel1() : bool {
	return thePlayer.GetPrimalNeeds().GetFatigue() >= 50;
}

function PN_FatigueLevel2() : bool {
	return thePlayer.GetPrimalNeeds().GetFatigue() >= 60;
}

function PN_FatigueLevel3() : bool {
	return thePlayer.GetPrimalNeeds().GetFatigue() >= 70;
}

function PN_FatigueLevel4() : bool {
	return thePlayer.GetPrimalNeeds().GetFatigue() >= 80;
}

function PN_FatigueLevel5() : bool {
	return thePlayer.GetPrimalNeeds().GetFatigue() >= 90;
}