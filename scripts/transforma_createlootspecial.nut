function define(script)
{
    script.Name = "transforma_createLootSpecial";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an ActionCreateLoot command by adding one of two possible drop set
// IDs depending on if an instance flag is set
//params[0] = instance flag ID
//params[1] = lootID A
//params[2] = lootID B
function transform(source, cState, dState, zone, params)
{
    local character = cState != null ? cState.GetEntity() : null;
    local instance = zone != null ? zone.GetZoneInstance() : null;
    if(character == null || instance == null || params.len() < 3)
    {
        return -1;
    }

    local drops = null;
    if(instance.GetFlagState(params[0].tointeger(), 0, 0) == 1)
    {
        drops = params[1].tointeger();
    }
    else
    {
        drops = params[2].tointeger();
    }

    if(drops == null)
    {
        return -1;
    }

    action.AppendDropSetIDs(drops);

    return 0;
}