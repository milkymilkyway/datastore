function define(script)
{
    script.Name = "mot";
    script.Type = "AI";
    return 0;
}

function prepare(eState, manager)
{
    local aiState = eState.GetAIState();
    aiState.SetActionOverridesEntry("target", "theater");
    aiState.SetActionOverridesEntry("combatSkillHit", "");
    return 0;
}

function theater(eState, possibleTargets, manager, now)
{
    local valid = [];
    for(local i = 0; i < possibleTargets.len(); i++)
    {
        local enemyState = AllyState.Cast(possibleTargets[i]);
        local enemy = enemyState != null ? enemyState.GetEntity() : null;
        if(enemy == null || enemy.GetType() != 5435)
        {
            valid.append(possibleTargets[i].GetEntityID());
        }
    }
    return valid.len() > 0 ? valid[Randomizer.RNG(0, valid.len() - 1)] : 0;
}

function combatSkillHit(eState, manager, source, skillData)
{
        local enemyState = AllyState.Cast(source);
        local enemy = enemyState != null ? enemyState.GetEntity() : null;
        if(enemy == null || enemy.GetType() != 5435)
        {
            return 1;
        }
        return 0;
}