function define(script)
{
    script.Name = "transforma_statusMultiply";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an ActionAddRemoveStatus command by multiplying the stack count on
// each status being added based on a zone flag key
// - params[0]: Zone flag key with stack count multiplier
function transform(source, cState, dState, zone, params)
{
    if(zone == null || params.len() < 1)
    {
        return -1;
    }

    local multiplier = zone.GetFlagState(params[0].tointeger(), 0, 0);
    foreach(key in action.GetStatusStacksKeys())
    {
        action.SetStatusStacksEntry(key,
            action.GetStatusStacksByKey(key) * multiplier);
    }

    return 0;
}