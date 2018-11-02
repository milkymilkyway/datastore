function define(script)
{
    script.Name = "action_nextPhase";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    if(params.len() == 0)
    {
        return Result_t.FAIL;
    }

    return server.GetMatchManager().AdvancePhase(zone, -1, params[0].tointeger())
		? Result_t.SUCCESS : Result_t.FAIL;
}