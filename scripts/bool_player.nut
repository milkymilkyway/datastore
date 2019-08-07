function define(script)
{
    script.Name = "bool_player";
    script.Type = "EventCondition";
    return 0;
}

// Check if the current character is the target source entity
function check(source, cState, dState, zone, value1, value2, params)
{
    if(source != null && cState != null &&
        source.GetEntityID() == cState.GetEntityID())
    {
        return 0;
    }

    return -1;
}