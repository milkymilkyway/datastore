function define(script)
{
    script.Name = "gm_event_dropLoot";
    script.Type = "EventTransform";
    return 0;
}

// Create an ActionCreateLoot on an EventPerformActions event with the
// supplied parameters to drop a loot box where the player is standing.
// - params[0]: Either "ITEM" or "DROPSET" designating the mode
// - params[1]: Box expiration in seconds read as a decimal. 0 for none.
// - params[2]+: If "ITEM" mode, pairs of item IDs and stack counts to
//   add to the box. If "DROPSET" mode, drop set IDs to associate to the box.
function transform(source, cState, dState, zone, params)
{
    if(params.len() < 3 || zone == null ||
        (params[0] != "ITEM" && params[0] != "DROPSET"))
    {
        return -1;
    }

    local action = ActionCreateLoot();
    action.Position = ActionCreateLoot_position_t.SOURCE_RELATIVE;
    action.SetExpirationTime(params[1].tofloat());
    if(params[0] == "ITEM")
    {
        for(local i = 2; i < params.len();)
        {
            // Currently busted, boo me
            /*local drop = ItemDrop();
            drop.SetItemType(params[i].tointeger());
            drop.SetRate(100.0);
            drop.SetMinStack(params[i + 1].tointeger());
            drop.SetMaxStack(params[i + 1].tointeger());

            action.AppendDrops(drop);*/

            i += 2;
        }
    }
    else
    {
        for(local i = 2; i < params.len(); i++)
        {
            action.AppendDropSetIDs(params[i].tointeger());
        }
    }

    event.AppendActions(action);

    return 0;
}