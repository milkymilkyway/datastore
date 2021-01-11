function define(script)
{
    script.Name = "action_respawnSpawnGroup";
    script.Type = "ActionCustom";
    return 0;
}

// Activate and set respawn timers for the supplied spawn groups in the current zone
// - params[0+]: Spawn group IDs
function run(source, cState, dState, zone, server, params)
{
    if(zone != null && params.len() > 0)
    {
        zone.RespawnSpawnGroup(params);

        return Result_t.SUCCESS;
    }

    return Result_t.FAIL;
}