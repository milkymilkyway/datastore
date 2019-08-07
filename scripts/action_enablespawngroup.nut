function define(script)
{
    script.Name = "action_enableSpawnGroup";
    script.Type = "ActionCustom";
    return 0;
}

// Enable the supplied spawn groups in the current zone
// - params[0]: Spawn group IDs
function run(source, cState, dState, zone, server, params)
{
    if(zone != null)
    {
        for(local i = 0; i < params.len(); i++)
        {
            zone.EnableDisableSpawnGroup(params[i].tointeger(), true);
        }

        return Result_t.SUCCESS;
    }

    return Result_t.FAIL;
}