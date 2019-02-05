function define(script)
{
    script.Name = "quakinInMyBoots";
    script.Type = "AI";
    return 0;
}

function prepare(eState, manager)
{
    local aiState = eState.GetAIState();
    aiState.SetActionOverridesEntry("aggro", "");
    aiState.SetActionOverridesEntry("combat", "");
    aiState.SetActionOverridesEntry("wander", "");
    return 0;
}

function aggro(eState, manager, now)
{
    return queueQuake(eState, manager, now);
}

function combat(eState, manager, now)
{
    return queueQuake(eState, manager, now);
}

function wander(eState, manager, now)
{
    return queueQuake(eState, manager, now);
}

function queueQuake(eState, manager, now)
{
    local aiState = eState.GetAIState();

    local quakeTime = aiState.GetActionTimesByKey("Quake");
    if(quakeTime == 0)
    {
        // First quake is 3m from first check
        aiState.SetActionTimesEntry("Quake", now + 180000000);
    }
    else if(quakeTime <= now && manager.UseDiasporaQuake(eState, 420, 5.0))
    {
        // Subsequent quakes are 3m apart
        aiState.SetActionTimesEntry("Quake", now + 180000000);
    }

    // Never prevent other actions
    return 0;
}