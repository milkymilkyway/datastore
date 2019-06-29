function define(script)
{
    script.Name = "bool_spectate";
    script.Type = "EventCondition";
    return 0;
}

function check(source, cState, dState, zone, value1, value2, params)
{
    if(cState != null &&
        cState.GetDisplayState() == ActiveEntityStateObject_DisplayState_t.UB_SPECTATE)
    {
        return 0;
    }

    return -1;
}