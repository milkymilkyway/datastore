function define(script)
{
    script.Name = "action_enablePlasma";
    script.Type = "ActionCustom";
    return 0;
}

// Enable the supplied plasmas in the current zone
// - params[0]: Plasma IDs
function run(source, cState, dState, zone, server, params)
{
    if(zone != null)
    {
        for(local i = 0; i < params.len(); i++)
        {
            local pState = zone.GetPlasma(params[i].tointeger());
            if(pState == 0)
            {
                return Result_t.FAIL;
            }

            pState.Toggle(true, true);
        }

        return Result_t.SUCCESS;
    }

    return Result_t.FAIL;
}