function define(script)
{
    script.Name = "action_disablePlasma";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    local cZone = zone.GetDefinitionID()
    if(zone != null)
    {
        for(local i = 0; i < params.len(); i++)
        {
            local pState = zone.GetPlasma(params[i].tointeger());
            if(pState == 0)
            {
                return Result_t.FAIL;
            }
            pState.Toggle(false, true);
        }
        return Result_t.SUCCESS;
    }
    return Result_t.FAIL
}