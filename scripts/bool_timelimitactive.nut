function define(script)
{
    script.Name = "bool_timeLimitActive";
    script.Type = "EventCondition";
    return 0;
}

// Check if the supplied instance timer ID is active
// - value1: timer ID
function check(source, cState, dState, zone, value1, value2, params)
{
    local instance = zone.GetZoneInstance();
    if(instance != null)
    {
        return instance.GetTimerID() == value1 ? 0 : -1;
    }

    return -1;
}