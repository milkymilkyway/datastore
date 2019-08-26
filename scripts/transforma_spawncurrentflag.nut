function define(script)
{
    script.Name = "transforma_spawnCurrentFlag";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an ActionSpawn command by reading a value from a zone flag
// and writing that value to another when the spawn defeat actions execute
//params[0] = Zone flag key to read from
//params[1] = Zone flag key to write to in the spawn actions
function transform(source, cState, dState, zone, params)
{
    if(zone == null || params.len() < 2)
    {
        return -1;
    }

    local value = zone.GetFlagState(params[0].tointeger(), 0, 0);

    local flagAction = ActionUpdateZoneFlags();
    flagAction.SetFlagStatesEntry(params[1].tointeger(), value);

    action.PrependDefeatActions(flagAction);

    return 0;
}