function define(script)
{
    script.Name = "transforma_addItemRandom";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an ActionAddRemoveItems command by adding a random key value pair
// to the item list.
// - params[0]+: Pair of item IDs and amounts
function transform(source, cState, dState, zone, params)
{
    if(params.len() < 2 || (params.len() % 2) != 0)
    {
        return -1;
    }

    local key = Randomizer.RNG(0, (params.len() / 2)) * 2;

    action.SetItemsEntry(params[key].tointeger(), params[key + 1].tointeger());

    return 0;
}