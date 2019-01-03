function define(script)
{
    script.Name = "action_toggleTower";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    local cZone = zone.GetDefinitionID()
    if(cZone == null)
    {
        return Result_t.FAIL;
    }
    if(params.len() <= 0)
    {
        return Result_t.FAIL;
    }
    if(params.len() == 1)
    {
        return Result_t.FAIL;
    }
    if(params.len() >= 2)
    {
        for(local i = 1; i < params.len(); i++)
        {
            server.GetMatchManager().ToggleDiasporaBase(zone, params[i].tointeger(), params[0].tointeger() == 1)
        }
        return Result_t.SUCCESS
    }
    return Result_t.FAIL;
}