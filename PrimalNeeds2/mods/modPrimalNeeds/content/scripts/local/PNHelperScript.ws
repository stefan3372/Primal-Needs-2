function SetInt( variable : string, val : int )
{
	FactsSet(variable, val);
}

function GetInt( variable : string ) : int
{
	return FactsQuerySum(variable);
}

function SetBool( variable : string, val : bool )
{
	if ( val )
		FactsAdd(variable);
	else
		FactsRemove(variable);
}

function GetBool( variable : string) : bool
{
	return FactsDoesExist(variable);
}

function SetFloat( variable : string, val : float)
{
	FactsSet( variable, (int) FloorF( val * 100.0 ) );
}

function GetFloat( variable : string ) : float
{
	return (float) FactsQuerySum(variable) / 100.0;
}

latent function SlowDownAnimation( time : float, max : float, min : float, step : int)
{
	var speedMultID : int;
	var sleepStep : float;
	var speedStep : float;
	var currSpeed : float;
	var i : int;
	
	sleepStep = time / (float) step;
	speedStep = ( max - min ) / (float) step;
	currSpeed = max;
	
	for ( i = 0; i < step; i+=1) {
		speedMultID = thePlayer.SetAnimationSpeedMultiplier( currSpeed , speedMultID );
		currSpeed -= speedStep;
		Sleep(sleepStep);
	}
}

latent function SpeedUpAnimation( time : float, min : float, max : float, step : int)
{
	var speedMultID : int;
	var sleepStep : float;
	var speedStep : float;
	var currSpeed : float;
	var i : int;
	
	sleepStep = time / (float) step;
	speedStep = ( max - min ) / (float) step;
	currSpeed = min;
	
	for ( i = 0; i < step; i+=1) {
		speedMultID = thePlayer.SetAnimationSpeedMultiplier( currSpeed , speedMultID );
		currSpeed += speedStep;
		Sleep(sleepStep);
	}
}