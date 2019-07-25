function define(script)
{
    script.Name = "transforma_addItemFlagRange";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an ActionAddRemoveItems command based on zone character flags
// starting at a specified range. Range stops being read once a zero is
// encountered.
// - params[0]: Starting flag key
// - params[1]: If 1, flags are cleared after read
function transform(source, cState, dState, zone, params)
{
    local worldCID = cState != null ? cState.GetWorldCID() : 0;
    if(params.len() < 2 || zone == null || worldCID == 0)
    {
        return -1;
    }

    local key = params[0].tointeger();
    local clearKeys = params[1].tointeger() == 1;
    while(zone.GetFlagState(key, 0, worldCID) != 0 && zone.GetFlagState(key + 1, 0, worldCID) != 0)
    {
        action.SetItemsEntry(zone.GetFlagState(key, 0, worldCID),
            zone.GetFlagState(key + 1, 0, worldCID));

        if(clearKeys)
        {
            zone.SetFlagState(key, 0, worldCID);
            zone.SetFlagState(key + 1, 0, worldCID);
        }

        key += 2;
    }

    return 0;
}