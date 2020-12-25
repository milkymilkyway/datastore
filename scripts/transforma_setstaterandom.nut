function define(script)
{
    script.Name = "transforma_setStateRandom";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an object to a random state
// -params[0]: minimum actor ID
// -params[1]: maximum actor ID
// -params[2]: Optional "On" State
// -params[3]: Optional "Off" State
function transform(source, cState, dState, zone, params)
{
    if(zone == null || params.len() < 2)
    {
        return -1;
    }

    local minID = params[0].tointeger();
    local maxID = params[1].tointeger();
    local selectedID = Randomizer.RNG(minID, maxID);
    action.SetActorID(selectedID);

    if(params.len() >= 4)
    {
        local onState = params[2].tointeger();
        local offState = params[3].tointeger();
        local random = Randomizer.RNG(0, 1);
        if(random > 0)
        {
            action.SetState(onState);
        }
        else
        {
            action.SetState(offState);
        }
    }
    return 0;
}