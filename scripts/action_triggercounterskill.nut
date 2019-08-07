function define(script)
{
    script.Name = "action_triggerCounterSkill";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    if(params.len() < 2 || source == null)
    {
        return Result_t.FAIL;
    }

    local aiState = source.GetAIState();
    if(aiState == null)
    {
        return Result_t.FAIL;
    }

    aiState.SetActionOverridesEntry("CounterSkill", params[0].tointeger());
    aiState.SetActionOverridesEntry("CounterActionType", params[1].tointeger());

    return Result_t.SUCCESS;
}