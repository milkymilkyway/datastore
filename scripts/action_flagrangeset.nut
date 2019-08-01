function define(script)
{
    script.Name = "action_flagRangeSet";
    script.Type = "ActionCustom";
    return 0;
}

// Set character flag values (or value pairs) at a starting key with optional
// percentages to apply them. If the starting key has a non-zero value already,
// the starting key will be increased until a zero value is encountered.
// - params[0]: Starting key
// - params[1]: If 1, designates that flag values are pairs
// - params[2]: If 1, designates that percentages are included
// - params[3]+: Flag value pairs (and percentages to apply)
function run(source, cState, dState, zone, server, params)
{
    local worldCID = cState != null ? cState.GetWorldCID() : 0;
    if(params.len() < 4 || zone == null || worldCID == 0)
    {
        return Result_t.FAIL;
    }

    local key = params[0].tointeger();
    local pairs = params[1].tointeger() == 1;
    local percentIncluded = params[2].tointeger() == 1;
    local valueSize = 1 + (pairs ? 1 : 0) + (percentIncluded ? 1 : 0);

	while(zone.GetFlagState(key, 0, worldCID) != 0)
    {
        key++;
    }

    for(local i = 3; i < (params.len() - (valueSize - 1));)
    {
        local setKey = !percentIncluded;
        if(percentIncluded)
        {
            local chance = params[i + (valueSize - 1)].tointeger();
            setKey = chance >= 100 || chance >= Randomizer.RNG(1, 100);
        }

        if(setKey)
        {
            if(pairs)
            {
                zone.SetFlagState(key++, params[i].tointeger(), worldCID);
                zone.SetFlagState(key++, params[i + 1].tointeger(), worldCID);
            }
            else
            {
                zone.SetFlagState(key++, params[i].tointeger(), worldCID);
            }
        }

        i += valueSize;
    }

    return Result_t.SUCCESS;
}