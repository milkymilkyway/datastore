function define(script)
{
    script.Name = "action_eventCounter";
    script.Type = "ActionCustom";
    return 0;
}

// Create/Modify an event counter
// - params[0]: event counter ID
// - params[1]: value to change/set counter by
// - params[2]: counter should be decreased if 1, set to params[1] if 2, flag mask (add) if 3
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
        local character = cState != null ? cState.GetEntity() : null;
        if(character == null)
        {
            return Result_t.FAIL;
        }
    
        eCounter = cState.GetEventCounter(params[0].tointeger(), true);
        if(params.len() >= 2)
        {
            counterValue = params[1].tointeger();
        }

        characterUID = character.GetUUID();
    }

    if(params.len() == 3)
    {
        if(params[2].tointeger() == 1)
        {
            // Decrease
            counterValue = counterValue * -1;
        }
        else if(params[2].tointeger() == 3)
        {
            // Flag mask (add)
            counterValue = 1 << counterValue;
        }
    }

    if(!eCounter || eCounter.GetUUID().IsNull())
    {
        if(!eCounter)
        {
            eCounter = EventCounter();
            eCounter.SetCharacter(characterUID);
            eCounter.SetType(params[0].tointeger());
        }

        eCounter.SetCounter(counterValue);

        if(!PersistentObject.Register(eCounter, UUID()) || !eCounter.Insert(worldDB))
        {
            return Result_t.FAIL;
        }
    }
    else
    {
        if(params.len() == 3 && params[2].tointeger() == 2)
        {
            // Setting
            eCounter.SetCounter(counterValue);
        }
        else if(params.len() == 3 && params[2].tointeger() == 3)
        {
            // Flag mask (add)
            eCounter.SetCounter(eCounter.GetCounter() | counterValue);
        }
        else
        {
            // Adding
            eCounter.SetCounter(eCounter.GetCounter() + counterValue);
        }

        if(!eCounter.Update(worldDB))
        {
            return Result_t.FAIL;
        }
    }

    syncManager.UpdateRecord(eCounter, "EventCounter");
    syncManager.SyncOutgoing();

    return Result_t.SUCCESS;
}