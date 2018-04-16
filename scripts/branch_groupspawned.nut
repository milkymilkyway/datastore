function define(script)
{
    script.Name = "branch_groupSpawned";
    script.Type = "EventBranchLogic";
    return 0;
}

function check(cState, dState, zone, params)
{
	local cZone = zone.GetDefinitionID();
	//Nyarlathotep in nakano
    if(cZone == 40101)
    {
		return zone.GroupHasSpawned(166, true, true) ? 0 : -1;
    }
    if(cZone == 90101)
    {
		return zone.GroupHasSpawned(1, true, true) ? 0 : -1;
    }
    if(cZone == 110101)
    {
		return zone.GroupHasSpawned(685, true, true) ? 0 : -1;
    }
	return 0;
}