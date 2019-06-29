function define(script)
{
    script.Name = "action_pentalphaReset";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    local matchManager = server.GetMatchManager();
    local syncManager = server.GetChannelSyncManager();
    local worldDB = server.GetWorldDatabase();

    local previous = matchManager.GetPentalphaMatch(false);
    if(previous && params.len() > 0 && params[0] == "INITONLY")
    {
        return Result_t.SUCCESS;
    }

    local worldClock = server.GetWorldClockTime();

    local match = PentalphaMatch();
    match.SetStartTime(worldClock.SystemTime);

    if(previous)
    {
        match.SetPrevious(previous.GetUUID());
        previous.SetEndTime(worldClock.SystemTime);
    }

    if(!PersistentObject.Register(match, UUID()) || !match.Insert(worldDB) ||
        (previous && !previous.Update(worldDB)))
    {
        return Result_t.FAIL;
    }

    syncManager.UpdateRecord(match, "PentalphaMatch");
    if(previous)
    {
        syncManager.UpdateRecord(previous, "PentalphaMatch");
    }

    syncManager.SyncOutgoing();

    return Result_t.SUCCESS;
}