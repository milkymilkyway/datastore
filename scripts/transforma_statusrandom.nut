function define(script)
{
    script.Name = "transforma_statusRandom";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an ActionAddRemoveStatus command by selecting a random status from
// pairs of parameters
// - params[0, 2, 4+]: ID of status effect
// - params[1, 3, 5+]: Stacks of the status to add
function transform(source, cState, dState, zone, params)
{
    if(zone == null || params.len() < 2 || (params.len() % 2) != 0)
    {
        return -1;
    }

    local r = Randomizer.RNG(0, ((params.len() / 2) - 1));
    local status = params[r].tointeger();
    local stack = params[r + 1].tointeger();
    action.SetStatusStacksEntry(status, stack);

    return 0;
}