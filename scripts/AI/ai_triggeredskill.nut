function define(script)
{
    script.Name = "triggeredSkill";
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
    return trigger(eState, manager, now);
}

function combat(eState, manager, now)
{
    return trigger(eState, manager, now);
}

function wander(eState, manager, now)
{
    return trigger(eState, manager, now);
}

function trigger(eState, manager, now)
{
    local aiState = eState.GetAIState();

    local skillID = aiState.GetActionOverridesByKey("TriggerSkill");
    if(skillID.len() > 0)
    {
        aiState.RemoveActionOverrides("TriggerSkill");
        manager.QueueUseSkillCommand(eState, skillID.tointeger(),
            aiState.GetTargetEntityID(), false);
        return -1;
    }

    return 0;
}