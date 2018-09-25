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