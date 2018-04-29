//---=== modFriendlyMeditation ===---
class CModFMeditationConfig
{
	private var refillPotionsWhileMeditatingToggle	: bool;
	
	public function RefillPotionsWhileMeditating() : bool
	{
		return refillPotionsWhileMeditatingToggle;
	}
	
	public function ResetRefillSettingToDefaultAfterMeditation() : bool
	{
		return (bool)theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyMeditation', 'fmedResetRefillSettingToDefaultAfterMeditation');
	}

	public function ResetRefillPotionsWhileMeditating()
	{
		var tmp : bool;
		tmp = refillPotionsWhileMeditatingToggle;
		refillPotionsWhileMeditatingToggle = (bool)theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyMeditation', 'fmedRefillPotionsWhileMeditating');
		if( tmp != refillPotionsWhileMeditatingToggle)
		{
			if( refillPotionsWhileMeditatingToggle )
			{
				GetWitcherPlayer().DisplayHudMessage( GetLocStringByKeyExt("fmed_potionsRefillOnMessage") );
			}
			else
			{
				GetWitcherPlayer().DisplayHudMessage( GetLocStringByKeyExt("fmed_potionsRefillOffMessage") );
			}
		}
	}
	
	public function ToggleRefillPotionsWhileMeditating()
	{
		refillPotionsWhileMeditatingToggle = ( !refillPotionsWhileMeditatingToggle );
		if( refillPotionsWhileMeditatingToggle )
		{
			GetWitcherPlayer().DisplayHudMessage( GetLocStringByKeyExt("fmed_potionsRefillOnMessage") );
		}
		else
		{
			GetWitcherPlayer().DisplayHudMessage( GetLocStringByKeyExt("fmed_potionsRefillOffMessage") );
		}
	}
	
	public function FullHealthRegenAnyDifficulty() : bool
	{
		return (bool)theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyMeditation', 'fmedFullHealthRegenAnyDifficulty');
	}
	
	public function RefillIntervalSeconds() : float
	{
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyMeditation', 'fmedRefillIntervalMins'))*60.0;
	}
	
	public function MaxHPM() : float
	{
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyMeditation', 'fmedMaxHoursPerMinute'));
	}
	
	public function HPMPerSecond() : float
	{
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyMeditation', 'fmedHoursPerMinutePerSecond'));
	}
	
	public function UseTimescale() : bool
	{
		return (bool)theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyMeditation', 'fmedUseTimescale');
	}
	
	public function SpawnCampFire() : bool
	{
		return (bool)theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyMeditation', 'fmedSpawnCampfire');
	}
	
	public function HotkeyAsToggle() : bool
	{
		return (bool)theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyMeditation', 'fmedHotkeyAsToggle');
	}
	
	public function Init()
	{
		refillPotionsWhileMeditatingToggle = (bool)theGame.GetInGameConfigWrapper().GetVarValue('modFriendlyMeditation', 'fmedRefillPotionsWhileMeditating');
	}
}

function GetFMeditationConfig() : CModFMeditationConfig
{
	return GetWitcherPlayer().fMeditationConfig;
}
//---=== modFriendlyMeditation ===---
