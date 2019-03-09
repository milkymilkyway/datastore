function define(script)
{
    script.Name = "bool_player";
    script.Type = "EventCondition";
    return 0;
}

function check(source, cState, dState, zone, value1, value2, params)
{
    if(cState != null)
    {
        if(source.GetEntityID() == cState.GetEntityID())
        {
            return 0;
        }
    }
    return -1;
}