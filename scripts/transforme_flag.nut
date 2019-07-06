function define(script)
{
    script.Name = "transforme_flag";
    script.Type = "EventTransform";
    return 0;
}

// Apply zone or zone instance flag value to an Ex NPC Message
// - params[0]: Flag key
// - params[1]: ZONE or INSTANCE for flag type to set
function transform(source, cState, dState, zone, params)
{
    if(params.len() < 2 || zone == null ||
        (params[1] != "ZONE" && params[1] != "INSTANCE") ||
        (params[1] == "INSTANCE" && zone.GetZoneInstance() == null))
    {
        return -1;
    }

    if(params[1] == "INSTANCE")
    {
        event.SetMessageValue(zone.GetZoneInstance().GetFlagState(
            params[0].tointeger(), 0, 0));
    }
    else
    {
        event.SetMessageValue(zone.GetFlagState(params[0].tointeger(), 0, 0));
    }

    return 0;
}