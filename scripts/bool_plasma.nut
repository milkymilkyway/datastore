function define(script)
{
    script.Name = "bool_plasma";
    script.Type = "EventCondition";
    return 0;
}

// - params[0]+: Plasma IDs
function check(source, cState, dState, zone, value1, value2, params)
{
    local cZone = zone.GetDefinitionID()
    if(cZone != null)
    {
        for(local i = 0; i < params.len(); i++)
        {
            local pState = zone.GetPlasma(params[i].tointeger());
            if(pState != null && pState.IsActive(false))
            {
                return 0;
            }
        }
        return 0;
    }
    return -1;
}