function define(script)
{
    script.Name = "action_eventCounter";
    script.Type = "ActionCustom";
    return 0;
}

// Create/Modify an event counter
// - params[0]: event counter ID
// - params[1]: value to change/set counter by
// - params[2]: counter should be decreased if 1
function run(source, cState, dState, zone, server, params)
{
    local syncManager = server.GetChannelSyncManager();
    local worldDB = server.GetWorldDatabase();
    local worldClock = server.GetWorldClockTime();

    local character = cState.GetEntity();
    if(character == null)
    {
        return Result_t.FAIL;
    }

    local eCounter = cState.GetEventCounter(params[0].tointeger());
    local counterValue = 1;
    if(params.len() >= 2)
    {
        counterValue = params[1].tointeger();
    }

    if(params.len() == 3 && params[2].tointeger() == 1)
    {
        counterValue = counterValue * -1;
    }

    if(!eCounter)
    {
        eCounter = EventCounter();
        eCounter.SetCharacter(character.GetUUID());
        eCounter.SetType(params[0].tointeger());
        eCounter.SetCounter(counterValue);

        if(!PersistentObject.Register(eCounter, UUID()) || !eCounter.Insert(worldDB))
        {
            return Result_t.FAIL;
        }
    }
    else
    {
        eCounter.SetCounter(eCounter.GetCounter() + counterValue);

        if(!eCounter.Update(worldDB))
        {
            return Result_t.FAIL;
        }
    }

    syncManager.UpdateRecord(eCounter, "EventCounter");
    syncManager.SyncOutgoing();

    return Result_t.SUCCESS;
}