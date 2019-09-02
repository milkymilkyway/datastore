function define(script)
{
    script.Name = "action_startRemoteEvent";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    if(params.len() < 3 || zone == null || server == null)
    {
        return Result_t.FAIL;
    }

    local targetZone = server.GetZoneManager().GetGlobalZone(params[0].tointeger(), 
    params[1].tointeger());

    if(server.GetZoneManager().StartZoneEvent(targetZone, params[2]))
    {
        return Result_t.SUCCESS;
    }

    return Result_t.FAIL;
}