function define(script)
{
    script.Name = "action_postItem";
    script.Type = "ActionCustom";
    return 0;
}

// Send an item to a character's post.
// - params[0]: shop productID
// - params[1]: message ID
function run(source, cState, dState, zone, server, params)
{
    if(cState == null || params.len() < 1)
    {
        return Result_t.FAIL;
    }

    local syncManager = server.GetChannelSyncManager();
    local lobbyDB = server.GetLobbyDatabase();
    local clock = server.GetWorldClockTime();

    local character = cState.GetEntity();
    if(character == null)
    {
        return Result_t.FAIL;
    }

    local post = PostItem();
    post.SetAccount(character.GetAccount());
    post.SetTimestamp(clock.SystemTime);
    if(params.len() >= 2)
    {
        post.SetGiftMessage(params[1].tointeger());
    }

    post.SetType(params[0].tointeger());

    // todo: Set Source (post.Source = PostItem_Source_t.RECURRING etc);

    if(!PersistentObject.Register(post, UUID()) || !post.Insert(lobbyDB))
    {
        return Result_t.FAIL;
    }

    return Result_t.SUCCESS;
}