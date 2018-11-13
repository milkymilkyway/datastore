function define(script)
{
    script.Name = "action_UBEnd";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    if(params.len() < 2)
    {
        return Result_t.FAIL;
    }

	local gZone = server.GetZoneManager().GetGlobalZone(params[0].tointeger(),
        params[1].tointeger());

    return server.GetMatchManager().StartStopMatch(gZone, null)
		? Result_t.SUCCESS : Result_t.FAIL;
}