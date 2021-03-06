/***********************************************************************/
/** 	© 2015 CD PROJEKT S.A. All rights reserved.
/** 	THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/***********************************************************************/




class CR4HudModuleControlsFeedback extends CR4HudModuleBase
{		
	private var	m_fxSetSwordTextSFF 	: CScriptedFlashFunction;
	private var m_flashValueStorage 	: CScriptedFlashValueStorage;
	private var m_currentInputContext	: name;
	private var m_previousInputContext 	: name;
	private var m_currentPlayerWeapon	: EPlayerWeapon;
	private var m_displaySprint 		: bool;
	private var m_displayJump 			: bool;
	private var m_displayCallHorse		: bool;
	private var m_displayDiveDown		: bool;
	private var m_displayGallop			: bool;
	private var m_displayCanter			: bool;
	private	var m_movementLockType 		: EPlayerMovementLockType;
	private var m_lastUsedPCInput		: bool;
	private var m_CurrentHorseComp		: W3HorseComponent;
	
	private const var KEY_CONTROLS_FEEDBACK_LIST : string; 		default KEY_CONTROLS_FEEDBACK_LIST 		= "hud.module.controlsfeedback";

	event  OnConfigUI()
	{		
		var flashModule : CScriptedFlashSprite;
		var hud : CR4ScriptedHud;
		
		m_anchorName = "mcAnchorControlsFeedback"; 
		m_displaySprint = thePlayer.IsActionAllowed(EIAB_RunAndSprint);
		super.OnConfigUI();
		flashModule = GetModuleFlash();	
		m_flashValueStorage = GetModuleFlashValueStorage();
		m_fxSetSwordTextSFF = flashModule.GetMemberFlashFunction( "setSwordText" );
		
		SetTickInterval( 0.5 );
		
		hud = (CR4ScriptedHud)theGame.GetHud();
		
		UpdateInputContext(hud.currentInputContext);
		
		if (hud)
		{
			hud.UpdateHudConfig('ControlsFeedbackModule', true);
		}
	}

	public function UpdateInputContext( inputContextName :name )
	{		
		m_currentInputContext = 'PrimalNeeds';
		SendInputContextActions('PrimalNeeds');
	}
	
	event OnTick( timeDelta : float )
	{
		
		if ( !CanTick( timeDelta ) )
		{
			return true;
		}
		m_currentInputContext = 'PrimalNeeds';
		ForceModuleUpdate();
		UpdateSwordDisplay();
	}
	
	function UpdateInputContextActions()
	{
		SendInputContextActions('PrimalNeeds',true);
	}
	
	function ForceModuleUpdate()
	{
		SendInputContextActions(m_currentInputContext, true);
	}
	
	function SetEnabled( value : bool )
	{
		super.SetEnabled(value);
		SendInputContextActions(m_currentInputContext, true);
	}	
	
	private function UpdateSwordDisplay()
	{
		m_fxSetSwordTextSFF.InvokeSelfOneArg(FlashArgString(""));
	}
	
	private function SendInputContextActions( inputContextName :name, optional isForced : bool )
	{
		var l_FlashArray			: CScriptedFlashArray;
		var l_DataFlashObject 		: CScriptedFlashObject;
		var bindingGFxData	 		: CScriptedFlashObject;
		var bindingGFxData2	 		: CScriptedFlashObject;
		var l_ActionsArray	 		: array <name>;
		var l_swimingSprint	 		: bool;
		var i	 					: int;
		var outKeys 				: array< EInputKey >;
		var outKeysPC 				: array< EInputKey >;
		var labelPrefix				: string;
		var curAction				: name;
		var bracketOpeningSymbol 	: string;
		var bracketClosingSymbol  	: string;
		var actionLabel			  	: string;
		
		var attackKeysPC 			: array< EInputKey >;
		var attackModKeysPC 	    : array< EInputKey >;
		var alterAttackKeysPC 	    : array< EInputKey >;
		var modifier				: EInputKey;
		
		var fontred : string;
		var fontgreen : string;
		var fontyellow : string;
		var fontend : string;
		var currfont : string;
		var numfont : string;
		var mult : float;
		var multString : string;
		var timeLeft : float;
		var timeLeftString : string;
		var hrs : int;
		var hrsString : string;
		var mins : int;
		var minsString : string;
		var peeStr : string;
		var poopStr : string;
		
		fontred = "<font face=\"$BoldFont\" color=\"#c41515\">";
		fontgreen = "<font face=\"$BoldFont\" color=\"#26aa23\">";
		fontyellow = "<font face=\"$BoldFont\" color=\"#FCAD36\">";
		fontend = "</font>";
		
		l_FlashArray = m_flashValueStorage.CreateTempFlashArray();
		l_ActionsArray.Clear();
		
		if (PN_HungerOn()) l_ActionsArray.PushBack('Hunger');
		if (PN_ThirstOn()) l_ActionsArray.PushBack('Thirst');
		if (PN_FatigueOn()) l_ActionsArray.PushBack('Fatigue');
		if (PN_PeeOn() || PN_PoopOn()) l_ActionsArray.PushBack('PeeAndPoop');
		
		if( PN_HudOn() )
		{			
			for( i = 0; i < l_ActionsArray.Size(); i += 1 )
			{
				curAction = l_ActionsArray[i];
				
				l_DataFlashObject = m_flashValueStorage.CreateTempFlashObject();
				bindingGFxData = l_DataFlashObject.CreateFlashObject("red.game.witcher3.data.KeyBindingData");

				switch (curAction)
				{
					case 'Hunger':
						if (thePlayer.GetPrimalNeeds().GetHunger() < 30) {
							currfont = fontgreen;
						} else if (thePlayer.GetPrimalNeeds().GetHunger() < 50) {
							currfont = fontyellow;
						} else {
							currfont = fontred;
						}
						
						mult = PN_GetHungerInc();
						if (mult < 1) {
							numfont = fontgreen;
						} else if (FloatToStringPrec(mult, 2) == "1") {
							numfont = "<font>";
						} else if (mult < 1.5) {
							numfont = fontyellow;
						} else numfont = fontred;
						if (PN_HUDNeedSpeedOn()) {
							if (mult != FloorF(mult)) {
								multString = "   +" + FloatToStringPrec( mult, 2 );
							} else {
								multString = "   +" + FloatToStringPrec( mult, 0 ) + ".00";
							}
						} else {
							multString = "";
						}
						
						if (PN_HUDNeedTimeLeftOn()) {
							timeLeft = ((50 - (float)thePlayer.GetPrimalNeeds().GetHunger() - 1) * (float)PN_GetHungerCounter() + thePlayer.GetPrimalNeeds().GetHungerCnt());
							if (PN_FactorHungerSpeed()) {
								timeLeft /= mult;
							}
							if (timeLeft <= 0) {
								timeLeftString = "   00:00";
							} else {
								hrs = FloorF( timeLeft / 60 );
								if (hrs < 10) {
									hrsString = "0" + hrs;
								} else {
									hrsString = hrs;
								}
								mins = FloorF( timeLeft ) - ( hrs * 60 );
								if (mins < 10) {
									minsString = "0" + mins;
								} else {
									minsString = mins;
								}
								timeLeftString = "   " + hrsString + ":" + minsString + " ";
							}
						} else {
							timeLeftString = "";
						}
						
						labelPrefix = GetLocStringByKeyExt("HUD_Hunger")+ ": " + currfont + thePlayer.GetPrimalNeeds().GetHunger() + "%" + fontend + numfont + multString + fontend + timeLeftString;
						bindingGFxData.SetMemberFlashInt("keyboard_keyCode", 61 );
						bindingGFxData.SetMemberFlashInt("gamepad_keyCode", IK_Pad_Start );
						break;
					case 'Thirst':
						if (thePlayer.GetPrimalNeeds().GetThirst() < 50) {
							currfont = fontgreen;
						} else if (thePlayer.GetPrimalNeeds().GetThirst() < 75) {
							currfont = fontyellow;
						} else {
							currfont = fontred;
						}
						mult = PN_GetThirstInc();
						if (mult < 1) {
							numfont = fontgreen;
						} else if (FloatToStringPrec(mult, 2) == "1") {
							numfont = "<font>";
						} else if (mult < 1.25) {
							numfont = fontyellow;
						} else numfont = fontred;
						if (PN_HUDNeedSpeedOn()) {
							if (mult != FloorF(mult)) {
								multString = "   +" + FloatToStringPrec( mult, 2 );
							} else {
								multString = "   +" + FloatToStringPrec( mult, 0 ) + ".00";
							}
						} else {
							multString = "";
						}
						
						if (PN_HUDNeedTimeLeftOn()) {
							timeLeft = ((75 - (float)thePlayer.GetPrimalNeeds().GetThirst() - 1) * (float)PN_GetThirstCounter() + thePlayer.GetPrimalNeeds().GetThirstCnt() );
							if (PN_FactorThirstSpeed()) {
								timeLeft /= mult;
							}
							if (timeLeft <= 0) {
								timeLeftString = "   00:00";
							} else {
								hrs = FloorF( timeLeft / 60 );
								if (hrs < 10) {
									hrsString = "0" + hrs;
								} else {
									hrsString = hrs;
								}
								mins = FloorF( timeLeft ) - ( hrs * 60 );
								if (mins < 10) {
									minsString = "0" + mins;
								} else {
									minsString = mins;
								}
								timeLeftString = "   " + hrsString + ":" + minsString + " ";
							}
						} else {
							timeLeftString = "";
						}
						
						labelPrefix = GetLocStringByKeyExt("HUD_Thirst")+ ": " + currfont + thePlayer.GetPrimalNeeds().GetThirst() + "%" + fontend + numfont + multString + fontend + timeLeftString;
						bindingGFxData.SetMemberFlashInt("keyboard_keyCode", 61 );
						bindingGFxData.SetMemberFlashInt("gamepad_keyCode", IK_Pad_Start );
						break;
					case 'Fatigue':
						if (thePlayer.GetPrimalNeeds().GetFatigue() < 45) {
							currfont = fontgreen;
						} else if (thePlayer.GetPrimalNeeds().GetFatigue() < 85) {
							currfont = fontyellow;
						} else {
							currfont = fontred;
						}
						mult = PN_GetFatigueInc();
						if (mult < 1) {
							numfont = fontgreen;
						} else if (mult <= 2) {
							numfont = "<font>";
						} else if (mult < 3) {
							numfont = fontyellow;
						} else numfont = fontred;
						if (PN_HUDNeedSpeedOn()) {
							if (mult != FloorF(mult)) {
								multString = "   +" + FloatToStringPrec( mult, 2 );
							} else {
								multString = "   +" + FloatToStringPrec( mult, 0 ) + ".00";
							}
						} else {
							multString = "";
						}
						
						if (PN_HUDNeedTimeLeftOn()) {
							timeLeft = ((85 - (float)thePlayer.GetPrimalNeeds().GetFatigue() - 1) * (float)PN_GetFatigueCounter() + thePlayer.GetPrimalNeeds().GetFatigueCnt());
							if (PN_FactorFatigueSpeed()) {
								timeLeft /= mult;
							}
							if (timeLeft <= 0) {
								timeLeftString = "   00:00";
							} else {
								hrs = FloorF( timeLeft / 60 );
								if (hrs < 10) {
									hrsString = "0" + hrs;
								} else {
									hrsString = hrs;
								}
								mins = FloorF( timeLeft ) - ( hrs * 60 );
								if (mins < 10) {
									minsString = "0" + mins;
								} else {
									minsString = mins;
								}
								timeLeftString = "   " + hrsString + ":" + minsString + " ";
							}
						} else {
							timeLeftString = "";
						}
						
						labelPrefix = GetLocStringByKeyExt("HUD_Fatigue")+ ": " + currfont + thePlayer.GetPrimalNeeds().GetFatigue() + "%" + fontend + numfont + multString + fontend + timeLeftString;
						bindingGFxData.SetMemberFlashInt("keyboard_keyCode", 61 );
						bindingGFxData.SetMemberFlashInt("gamepad_keyCode", IK_Pad_Start );
						break;
					case 'PeeAndPoop':
						if (PN_PeeOn()) {
							peeStr = GetLocStringByKeyExt("HUD_Pee") + ": " + thePlayer.GetPrimalNeeds().GetPee() + "% ";
						} else peeStr = "";
						if (PN_PoopOn()) {
							poopStr = GetLocStringByKeyExt("HUD_Poop") + ": " + thePlayer.GetPrimalNeeds().GetPoop() + "% ";
						} else poopStr = "";
						labelPrefix = peeStr + poopStr;
						bindingGFxData.SetMemberFlashInt("keyboard_keyCode", 61 );
						bindingGFxData.SetMemberFlashInt("gamepad_keyCode", IK_Pad_Start );
						break;
				}

				bindingGFxData.SetMemberFlashString("label", labelPrefix );
				
				l_FlashArray.PushBackFlashObject(bindingGFxData);
				
				if ( thePlayer.GetPrimalNeeds().GetHunger() < 50 && thePlayer.GetPrimalNeeds().GetThirst() < 75 && thePlayer.GetPrimalNeeds().GetFatigue() < 85 && !PN_HudAlwaysOn() ) {
					PN_ResetHud();
				}
				
			}
			
		} else {
			for( i = 0; i < l_ActionsArray.Size(); i += 1 )
			{
				curAction = l_ActionsArray[i];
				
				l_DataFlashObject = m_flashValueStorage.CreateTempFlashObject();
				bindingGFxData = l_DataFlashObject.CreateFlashObject("red.game.witcher3.data.KeyBindingData");
				
				// bindingGFxData.SetMemberFlashString("label", "" );
				
				// l_FlashArray.PushBackFlashObject(bindingGFxData);
			}
			if (PN_HungerOn())
				if (thePlayer.GetPrimalNeeds().GetHunger() >= 50)
					PN_SetHud();
            if (PN_ThirstOn())
				if (thePlayer.GetPrimalNeeds().GetThirst() >= 75)
					PN_SetHud();
			if (PN_FatigueOn())
				if (thePlayer.GetPrimalNeeds().GetFatigue() >= 85)
					PN_SetHud();
		}
		
		if( l_ActionsArray.Size() > 0 )
		{
			m_flashValueStorage.SetFlashArray( KEY_CONTROLS_FEEDBACK_LIST, l_FlashArray );
			
		}
		m_previousInputContext = m_currentInputContext;

	}
	
	protected function UpdateScale( scale : float, flashModule : CScriptedFlashSprite ) : bool
	{
		return super.UpdateScale(scale * 0.75,flashModule );
	}
	
	protected function UpdatePosition(anchorX:float, anchorY:float) : void
	{
		var l_flashModule 		: CScriptedFlashSprite;
		var tempX				: float;
		var tempY				: float;
		
		l_flashModule 	= GetModuleFlash();
		
		
		
		
		tempX = anchorX - (300.0 * (1.0 - theGame.GetUIHorizontalFrameScale()));
		tempY = anchorY - (200.0 * (1.0 - theGame.GetUIVerticalFrameScale())); 
		
		l_flashModule.SetX( tempX );
		l_flashModule.SetY( tempY );	
	}
	
	event OnControllerChanged()
	{
		
	}	

	event OnInputHandled(NavCode:string, KeyCode:int, ActionId:int)
	{
	}
}