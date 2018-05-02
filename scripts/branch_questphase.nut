function define(script)
{
    script.Name = "branch_questPhase";
    script.Type = "EventBranchLogic";
    return 0;
}

// Branch based on the current phase of the supplied quest ID
// - params[0]: quest ID
function check(cState, dState, zone, params)
{
    if(params.len() == 0)
    {
        return -1;
    }

    local character = cState.GetEntity();
    local quest = character.GetQuestsByKey(params[0].tointeger()).Get();

    return quest ? quest.GetPhase() : -1;
}