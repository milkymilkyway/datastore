function define(script)
{
    script.Name = "action_triggerSkill";
    script.Type = "ActionCustom";
    return 0;
}

// Trigger a skill on the current source entity that is AI controlled (only
// works with specific custom AI types)
// - params[0]: Skill ID to trigger
function run(source, cState, dState, zone, server, params)
{
    if(params.len() < 1 || source == null)
    {
        return Result_t.FAIL;
    }

    local aiState = source.GetAIState();
    if(aiState == null)
    {
        return Result_t.FAIL;
    }

    aiState.SetActionOverridesEntry("TriggerSkill", params[0].tointeger());

    return Result_t.SUCCESS;
}