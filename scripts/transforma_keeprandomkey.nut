function define(script)
{
    script.Name = "transforma_keepRandomKey";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an ActionAddRemoveItems or ActionUpdateCOMP command by keeping
// only one random key.
function transform(source, cState, dState, zone, params)
{
    if(action.ActionType == Action_actionType_t.ADD_REMOVE_ITEMS)
    {
        local keys = action.GetItemsKeys();
        if(keys.len() > 0)
        {
            local key = keys[Randomizer.RNG(0, keys.len() - 1)];
            local value = action.GetItemsByKey(key);
            action.ClearItems();
            action.SetItemsEntry(key, value);
        }
    }
    else if(action.ActionType == Action_actionType_t.UPDATE_COMP)
    {
        local keys = action.GetAddDemonsKeys();
        if(keys.len() > 0)
        {
            local key = keys[Randomizer.RNG(0, keys.len() - 1)];
            local value = action.GetAddDemonsByKey(key);
            action.ClearAddDemons();
            action.SetAddDemonsEntry(key, value);
        }
    }
    else
    {
        return -1;
    }

    return 0;
}