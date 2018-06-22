function define(script)
{
    script.Name = "branch_gender";
    script.Type = "EventBranchLogic";
    return 0;
}

// Branch based on the character's gender
function check(source, cState, dState, zone, params)
{
    local character = cState.GetEntity();

    return character.Gender == Character_Gender_t.MALE ? 0 : 1;
}