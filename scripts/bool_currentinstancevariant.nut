function define(script)
{
    script.Name = "bool_currentInstanceVariant";
    script.Type = "EventCondition";
    return 0;
}

// Check if the current instance variant is one of the supplied values
// - params[0]+: list of zone instance variant IDs
function check(source, cState, dState, zone, value1, value2, params)
{
    local instance = zone.GetZoneInstance();
    if(instance != null)
    {
        local variant = instance.GetVariant();
        if(variant != null)
        {
            for(local i = 0; i < params.len(); i++)
            {
                if(params[i].tointeger() == variant.GetID())
                {
                    return 0;
                }
            }
        }
    }

    return -1;
}