function define(script)
{
    script.Name = "bool_isMitamaFused";
    script.Type = "EventCondition";
    return 0;
}

function check(source, cState, dState, zone, params)
{
	local demon = dState.GetEntity();
    if(demon != null)
    {
		return demon.GetMitamaType() != 0 ? 0 : -1;
    }
	return -1;

}