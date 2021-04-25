function define(script)
{
    script.Name = "action_reactivateSavedSwitchSkills";
    script.Type = "ActionCustom";
    return 0;
}

// Reactivate character's saved switch skills on login
function run(source, cState, dState, zone, server, params)
{
    local character = cState != null ? cState.GetEntity() : null;
    if(character == null)
    {
        return Result_t.FAIL;
    }

    local skillManager = server.GetSkillManager();
	skillManager.ReactivateSavedSwitchSkills(source);

    return Result_t.SUCCESS;
}