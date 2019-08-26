function define(script)
{
    script.Name = "bool_flagCompare";
    script.Type = "EventCondition";
    return 0;
}

// Check if the values of two zone flags match
// - value1: Flag key 1
// - value2: Flag key 2
function check(source, cState, dState, zone, value1, value2, params)
{
    if(zone == null)
    {
        return -1;
    }

    return zone.GetFlagState(value1, 0, 0) == zone.GetFlagState(value2, 0, 0) ? 0 : -1;
}