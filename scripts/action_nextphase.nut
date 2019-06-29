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
    if(params.len() == 1)
    {
        return server.GetMatchManager().AdvancePhase(zone, params[0].tointeger(), -1)
            ? Result_t.SUCCESS : Result_t.FAIL;
    }
    if(params.len() == 2)
    {
        return server.GetMatchManager().AdvancePhase(zone, params[1].tointeger(), params[0].tointeger())
            ? Result_t.SUCCESS : Result_t.FAIL;
    }
    return Result_t.FAIL;
}