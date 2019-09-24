function define(script)
{
    script.Name = "transforma_flagRandom";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an ActionUpdateZoneFlags command by setting specified flag keys to
// a random number between a set range
// - params[0]: Minimum random value
// - params[1]: Maximum random value
// - params[2]+: Flag keys to transform
function transform(source, cState, dState, zone, params)
{
    if(params.len() < 3)
    {
        return -1;
    }

    local min = params[0].tointeger();
    local max = params[1].tointeger();
    if(min > max)
    {
        return -1;
    }

    for(local i = 2; i < params.len(); i++)
    {
        action.SetFlagStatesEntry(params[i].tointeger(), Randomizer.RNG(min, max));
    }

    return 0;
}