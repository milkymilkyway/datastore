function define(script)
{
    script.Name = "branch_instFlagSum";
    script.Type = "EventBranchLogic";
    return 0;
}

// Branch based on the number of zone instance flags set to 1 in a supplied range
// - params[0]: starting flag ID
// - params[1]: number of sequential flags to check
function check(source, cState, dState, zone, params)
{
    if(params.len() < 2)
    {
        return -1;
    }

    local zone = cState.GetZone();

    local flagsSet = -1;
    for(local i = 0; i < params[1].tointeger(); i++)
    {
        if(zone.GetInstance().GetFlagState(params[0].tointeger() + i, 0) == 1)
        {
            flagsSet++;
        }
    }

    return flagsSet;
}