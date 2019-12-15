function define(script)
{
    script.Name = "transforma_actorFlag";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an ActionSetNPCState command by setting the actorID based on the value of a flag
// - params[0]: Flag type: ZONE, INSTANCE, CHARACTER or
//   INSTANCE_CHARACTER
// - params[1]: Flag key to use
function transform(source, cState, dState, zone, params)
{
    local worldCID = cState != null ? cState.GetWorldCID() : 0;
    if(params.len() < 2 || zone == null ||
        (params[0] != "ZONE" && params[0] != "INSTANCE" &&
        params[0] != "CHARACTER" && params[0] != "INSTANCE_CHARACTER"))
    {
        return -1;
    }
    else if(params[0] != "CHARACTER" && params[0] != "INSTANCE_CHARACTER")
    {
        worldCID = 0;
    }

    local flagSource = null;
    if(params[0] == "ZONE" || params[0] == "CHARACTER")
    {
        flagSource = zone;
    }
    else
    {
        flagSource = zone.GetZoneInstance();
    }

    if(flagSource == null)
    {
        return -1;
    }

	local actorID = flagSource.GetFlagState(params[1].tointeger(), 0, worldCID);
	action.SetActorID(actorID);

    return 0;
}