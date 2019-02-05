function define(script)
{
    script.Name = "transforma_clearItems";
    script.Type = "ActionTransform";
    return 0;
}

function transform(source, cState, dState, zone, params)
{
    if(params.len() < 1)
    {
        return -1;
    }

    local character = cState.GetEntity();
    if(character == null)
    {
        return -1;
    }

    local inventory = character.GetItemBoxesByIndex(0).Get();
    if(inventory == null)
    {
        return -1;
    }

    for(local i = 0; i < params.len(); i++)
    {
        local itemType = params[i].tointeger();
        local itemCount = 0;
        for(local k = 0; k < 50; k++)
        {
            local item = inventory.GetItemsByIndex(k).Get();
            if(item && item.GetType() == itemType)
            {
                itemCount -= item.GetStackSize();
            }
        }

        if(itemCount < 0)
        {
            action.SetItemsEntry(itemType, itemCount);
        }
    }

    return 0;
}