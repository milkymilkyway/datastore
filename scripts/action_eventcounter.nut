function define(script)
{
    script.Name = "action_eventCounter";
    script.Type = "ActionCustom";
    return 0;
}

// Create/Modify an event counter
// - params[0]: event counter ID
// - params[1]: value to change/set counter by
// - params[2]: counter should be decreased if 1, set to params[1] if 2
// - params[3]: if 1, set the world counter instead
function run(source, cState, dState, zone, server, params)
{
    local syncManager = server.GetChannelSyncManager();
    local worldDB = server.GetWorldDatabase();

    local eCounter = null;
    local characterUID = null;
    local counterValue = 1;

    if(params.len() >= 4 && params[3] == 1)
    {
        // Use world counter
        eCounter = syncManager.GetWorldEventCounter(params[0].tointeger());
        characterUID = UUID();
    }
    else
    {
        // Use character counter
        local character = cState.GetEntity();
        if(character == null)
        {
            return Result_t.FAIL;
        }
    
        eCounter = cState.GetEventCounter(params[0].tointeger());
        if(params.len() >= 2)
        {
            counterValue = params[1].tointeger();
        }

        characterUID = character.GetUUID();
    }

    if(params.len() == 3 && params[2].tointeger() == 1)
    {
        counterValue = counterValue * -1;
    }

    if(params.len() == 3 && params[2].tointeger() == 2)
    {
        if(!eCounter)
        {
            eCounter = EventCounter();
            eCounter.SetCharacter(characterUID);
            eCounter.SetType(params[0].tointeger());
            eCounter.SetCounter(counterValue);

            if(!PersistentObject.Register(eCounter, UUID()) || !eCounter.Insert(worldDB))
            {
                return Result_t.FAIL;
            }
        }
        else
        {
            eCounter.SetCounter(counterValue);

            if(!eCounter.Update(worldDB))
            {
                return Result_t.FAIL;
            }
        }
        syncManager.UpdateRecord(eCounter, "EventCounter");
        syncManager.SyncOutgoing();

        return Result_t.SUCCESS;
    }

    if(!eCounter)
    {
        eCounter = EventCounter();
        eCounter.SetCharacter(characterUID);
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