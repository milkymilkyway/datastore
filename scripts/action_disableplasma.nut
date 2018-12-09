function define(script)
{
    script.Name = "action_disablePlasma";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    local cZone = zone.GetDefinitionID()
    if(cZone != null)
    {
        for(local i = 0; i < params.len(); i++)
        {
            local pState = zone.GetPlasma(params[i].tointeger());
            if(pState == 0)
            {
                return -1;
            }
            pState.Toggle(false, true);
        }
        return Result_t.SUCCESS;
    }
    return -1
}