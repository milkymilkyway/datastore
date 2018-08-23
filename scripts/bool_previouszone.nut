function define(script)
{
    script.Name = "bool_previousZone";
    script.Type = "EventCondition";
    return 0;
}

function check(source, cState, dState, zone, value1, value2, params)
{
    local cZone = zone.GetDefinitionID();
    local character = cState.GetEntity();
    for(local i = 0; i < params.len(); i++)
    {
        if(params[i].tointeger() == character.PreviousZone)
        {
            return 0;
        }
    }

    return -1;
}