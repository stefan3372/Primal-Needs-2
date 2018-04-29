//---=== modFriendlyMeditation ===---
state ExplorationMeditation in W3PlayerWitcher extends Exploration
{
	private var updatedGameTime : GameTime;
	private var storedHoursPerMinute, hoursPerMinute : float;
	private var startedFastforwardSecs : float;
	private var fullHealth, meditationIdle, startedFastforward : bool;
	private	var noSaveLock : int;
	private var storedGameTime : GameTime;
	private var refilled, timescaleTriggered : bool;
	private var maxHPM, HPMPerSecond : float;
	
	public function StartFastforward()
	{
		var fastForward : CGameFastForwardSystem;

		if( meditationIdle && !startedFastforward )
		{
			startedFastforward = true;
			startedFastforwardSecs = theGame.GetEngineTimeAsSeconds();
			updatedGameTime = theGame.GetGameTime();
			storedGameTime = theGame.GetGameTime();
			hoursPerMinute = storedHoursPerMinute;
			fullHealth = ( parent.GetStat( BCS_Vitality ) >= parent.GetStatMax( BCS_Vitality ) );
			fastForward = theGame.GetFastForwardSystem();
			fastForward.BeginFastForward();
		}
	}

	public function EndFastforward()
	{
		var fastForward : CGameFastForwardSystem;
	
		if( startedFastforward )
		{
			fastForward = theGame.GetFastForwardSystem();
			fastForward.AllowFastForwardSelfCompletion();
			theGame.SetHoursPerMinute( storedHoursPerMinute );
			startedFastforward = false;
			startedFastforwardSecs = 0;
		}
	}

	public function IsMeditationIdle() : bool
	{
		return meditationIdle;
	}

	event OnBehaviorGraphNotification( notificationName : name, stateName : name )
	{
		if ( parent.GetPlayerAction() == PEA_Meditation )
		{
			if( notificationName == 'OnPlayerActionStartFinished' && !meditationIdle )
			{
				meditationIdle = true;
				StartFastforward();
			}
		}
		parent.OnBehaviorGraphNotification( notificationName, stateName );
	}
	
	event OnEnterState( prevStateName : name )
	{	
		super.OnEnterState( prevStateName );
		
		//parent.DisplayHudMessage( "ExplorationMeditation begin" );
		maxHPM = parent.fMeditationConfig.MaxHPM();
		HPMPerSecond = parent.fMeditationConfig.HPMPerSecond();
		parent.SetBehaviorVariable( 'MeditateWithIgnite', 0 );
		parent.SetBehaviorVariable( 'HasCampfire', 0 );
		meditationIdle = false;
		timescaleTriggered = false;
		refilled = false;
		theGame.CreateNoSaveLock( "in_exploration_meditation", noSaveLock );
		storedHoursPerMinute = theGame.GetHoursPerMinute();
		HideItemsInHands();
		InternalBeginExplorationMeditation();
		thePlayer.RemoveTimer( 'MeditationOffTimer' );
		thePlayer.RemoveTimer( 'MeditationModulesOffTimer' );
		thePlayer.AddTimer( 'MeditationModulesOnTimer', 0.1, false ); //FHUD compatibility
	}

	event OnLeaveState( nextStateName : name )
	{
		//parent.DisplayHudMessage( "ExplorationMeditation end" );
		meditationIdle = false;
		theGame.ReleaseNoSaveLock( noSaveLock );
		InternalEndExplorationMeditation();
		thePlayer.RemoveTimer( 'MeditationOffTimer' );
		thePlayer.RemoveTimer( 'MeditationModulesOnTimer' );
		thePlayer.AddTimer( 'MeditationModulesOffTimer', 0.1, false ); //FHUD compatibility
		
		super.OnLeaveState( nextStateName );
	}
	
	event OnPlayerTickTimer( deltaTime : float )
	{
		super.OnPlayerTickTimer( deltaTime );
		
		if ( parent.GetPlayerAction() != PEA_Meditation )
		{
			parent.EndExplorationMeditation();
		}
		else if ( startedFastforward )
		{
			MeditationUpdate();
		}
	}
	
	private function InternalBeginExplorationMeditation()
	{
		startedFastforward = false;
		if ( parent.fMeditationConfig.SpawnCampFire() )
		{
			parent.SetBehaviorVariable( 'MeditateWithIgnite', 1 );
			thePlayer.AddTimer( 'SpawnCampFireTimer', 4.5, false );
		}
		parent.SetBehaviorVariable( 'HasCampfire', 0 );
		parent.PlayerStartAction( PEA_Meditation );
	}
	
	timer function SpawnCampFireTimer(dt : float, id : int)
	{
		var template : CEntityTemplate;
		var pos : Vector;
		var z : float;
		var rot : EulerAngles;

		template = (CEntityTemplate)LoadResource( "environment\decorations\light_sources\campfire\campfire_01.w2ent", true);
		pos = thePlayer.GetWorldPosition() + VecFromHeading( thePlayer.GetHeading() ) * Vector(0.8, 0.8, 0);
		if( theGame.GetWorld().NavigationComputeZ( pos, pos.Z - 128, pos.Z + 128, z ) )
		{
			pos.Z = z;
		}
		if( theGame.GetWorld().PhysicsCorrectZ( pos, z ) )
		{
			pos.Z = z;
		}
		rot = thePlayer.GetWorldRotation();
		parent.spawnedCampFire = (W3Campfire)theGame.CreateEntity(template, pos, rot);
		parent.spawnedCampFire.ToggleFire( true );
	}
	
	private function InternalEndExplorationMeditation()
	{
		thePlayer.RemoveTimer( 'SpawnCampFireTimer' );
		if ( startedFastforward )
		{
			EndFastforward();
		}
		if ( timescaleTriggered )
		{
			theGame.RemoveTimeScale( 'FriendlyMeditation' );
			timescaleTriggered = false;
		}
		if ( parent.spawnedCampFire )
		{
			parent.SetBehaviorVariable( 'HasCampfire', 1 );
			thePlayer.AddTimer( 'DeSpawnCampFireTimer', 1.5, false );
		}
		if ( parent.GetPlayerAction() == PEA_Meditation )
		{
			parent.PlayerStopAction( PEA_Meditation );
		}
		if ( GetFMeditationConfig().ResetRefillSettingToDefaultAfterMeditation() )
		{
			GetFMeditationConfig().ResetRefillPotionsWhileMeditating();
		}
		if ( GetFMeditationConfig().FullHealthRegenAnyDifficulty() )
		{
			parent.Heal( parent.GetStatMax( BCS_Vitality ) );
		}
	}
	
	private function MeditationUpdate()
	{
		var realTimeSecs, gameTimeSec : float;
		
		if ( GetDayPart( theGame.GetGameTime() ) != GetDayPart( updatedGameTime ) )
		{
			theGame.VibrateControllerVeryLight();
		}
		if ( !timescaleTriggered )
		{
			gameTimeSec = GameTimeToSeconds( theGame.GetGameTime() - updatedGameTime );
			realTimeSecs = ConvertGameSecondsToRealTimeSeconds( gameTimeSec );
			parent.UpdateEffectsAccelerated( realTimeSecs, hoursPerMinute / storedHoursPerMinute );
		}
		if ( !fullHealth )
		{
			fullHealth = NotifyOnHealthRegenEnded();
		}
		if ( !refilled )
		{
			refilled = MeditationCheckRefill();
		}
		if ( !timescaleTriggered )
		{
			if ( hoursPerMinute < maxHPM )
			{
				hoursPerMinute = MinF( maxHPM, storedHoursPerMinute + ( theGame.GetEngineTimeAsSeconds() - startedFastforwardSecs ) * HPMPerSecond );
				theGame.SetHoursPerMinute( hoursPerMinute );
			}
			else if ( parent.fMeditationConfig.UseTimescale() )
			{
				timescaleTriggered = true;
				EndFastforward();
				theGame.SetTimeScale( hoursPerMinute / storedHoursPerMinute, 'FriendlyMeditation', 100 );
			}
		}
		updatedGameTime = theGame.GetGameTime();
	}
	
	private function NotifyOnHealthRegenEnded() : bool
	{
		if ( parent.GetStat( BCS_Vitality ) >= parent.GetStatMax( BCS_Vitality ) )
		{
			theGame.VibrateControllerLight();
			return true;
		}
		return false;
	}
	
	private function MeditationCheckRefill() : bool
	{
		return parent.MeditationRefill( GameTimeToSeconds( theGame.GetGameTime() - storedGameTime ) );
	}
	
	private function HideItemsInHands()
	{
		if ( parent.GetCurrentMeleeWeaponType() != PW_None )
		{
			parent.OnEquipMeleeWeapon( PW_None, true, true );
		}
		if ( parent.IsHoldingItemInLHand() )
		{
			parent.HideUsableItem( true );
		}
		if ( parent.rangedWeapon )
		{
			parent.OnRangedForceHolster( true, true, false );
		}
	}
}
//---=== modFriendlyMeditation ===---
