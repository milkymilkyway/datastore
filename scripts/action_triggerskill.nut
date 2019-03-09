function define(script)
{
    script.Name = "action_triggerSkill";
    script.Type = "ActionCustom";
    return 0;
}

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