function define(script)
{
    script.Name = "mara";
    script.Type = "AI";
    return 0;
}

function prepare(eState, manager)
{
    local aiState = eState.GetAIState();
    aiState.SetActionOverridesEntry("aggro", "");
    aiState.SetActionOverridesEntry("combat", "");
    aiState.SetActionOverridesEntry("wander", "");
    aiState.SetActionOverridesEntry("combatSkillHit", "");
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

function combatSkillHit(eState, manager, source, skillData)
{
    local aiState = eState.GetAIState();

    local skillID = aiState.GetActionOverridesByKey("CounterSkill");
    if(skillID != 0)
    {
        local actionType = aiState.GetActionOverridesByKey("CounterActionType").tointeger();
        if(actionType == -1 || skillData.GetBasic().ActionType == actionType)
        {
            manager.QueueUseSkillCommand(eState, skillID.tointeger(), -1, false);
        }
    }

    return 1;
}

function trigger(eState, manager, now)
{
    local aiState = eState.GetAIState();

    local skillID = aiState.GetActionOverridesByKey("TriggerSkill");
    if(skillID.len() > 0)
    {
        if(skillID.tointeger() == 0)
        {
            return 0;
        }

        aiState.RemoveActionOverrides("TriggerSkill");
        manager.QueueUseSkillCommand(eState, skillID.tointeger(),
            aiState.GetTargetEntityID(), false);
        return -1;
    }

    return 0;
}