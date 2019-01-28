function define(script)
{
    script.Name = "quakinInMyBoots";
    script.Type = "AI";
    return 0;
}

function prepare(eState, manager)
{
    local aiState = eState.GetAIState();
    aiState.SetActionOverridesEntry("combatSkillHit", "");
    return 0;
}

function combatSkillHit(eState, manager, source, skillData)
{
    manager.UseDiasporaQuake(eState, 420, 5.0);

    return 1;
}