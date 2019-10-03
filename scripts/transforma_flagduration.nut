function define(script)
{
    script.Name = "transforma_flagDuration";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an ActionDelay command by setting the duration to the value in
// a specified zone flag
// - params[0]: Zone flag key
function transform(source, cState, dState, zone, params)
{
    if(params.len() < 1 || zone == null)
    {
        return -1;
    }

    action.SetDuration(zone.GetFlagState(params[0].tointeger(), 0, 0));

    return 0;
}