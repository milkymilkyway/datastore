function define(script)
{
    script.Name = "action_flagRandom";
    script.Type = "ActionCustom";
    return 0;
}

// Set a zone flag to a random value between a supplied min/max.
// - params[0]: Destination flag key
// - params[1]: Min value
// - params[2]: Max value
// - params[3]: Destination flag type: ZONE (default), INSTANCE,
//   CHARACTER or INSTANCE_CHARACTER
function run(source, cState, dState, zone, server, params)
{
    local worldCID = cState != null ? cState.GetWorldCID() : 0;
    if(params.len() < 2 || zone == null)
    {
        return Result_t.FAIL;
    }

    local value = Randomizer.RNG(params[1].tointeger(), params[2].tointeger());
    local type = params.len() >= 4 ? params[3] : "ZONE";
    if(zone.GetZoneInstance() == null &&
        (type == "INSTANCE" || type == "INSTANCE_CHARACTER"))
    {
        return -1;
    }
    else if(worldCID <= 0 &&
        (type == "CHARACTER" || type == "INSTANCE_CHARACTER"))
    {
        return Result_t.FAIL;
    }

    if(type == "ZONE" || type == "CHARACTER")
    {
        zone.SetFlagState(params[0].tointeger(), value,
            type == "ZONE" ? 0 : worldCID);
    }
    else if(type == "INSTANCE" || type == "INSTANCE_CHARACTER")
    {
        zone.GetZoneInstance().SetFlagState(params[0].tointeger(), value,
            type == "INSTANCE" ? 0 : worldCID);
    }
    else
    {
        return Result_t.FAIL;
    }

    return Result_t.SUCCESS;
}