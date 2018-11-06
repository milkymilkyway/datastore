function define(script)
{
    script.Name = "action_eventCounter";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    local syncManager = server.GetChannelSyncManager();
    local worldDB = server.GetWorldDatabase();

    local character = cState.GetEntity();
    local eCounter = cState.GetEventCounter(params[0].toInteger());
    if(!eCounter)
    {
        eCounter.SetCharacter(character.GetUUID());
        eCounter.SetType(params[0].toInteger());
        eCounter.SetCounter(1);

        if(!PersistentObject.Register(eCounter, UUID()) || !eCounter.Insert(worldDB))
        {
            return Result_t.FAIL;
        }
    }
    else
    {
        eCounter.SetCounter(eCounter.GetCounter() + 1);

        if(!eCounter.Update(worldDB))
        {
            return Result_t.FAIL;
        }
    }

    syncManager.UpdateRecord(eCounter, "EventCounter");
    syncManager.SyncOutgoing();

    return Result_t.SUCCESS;
}