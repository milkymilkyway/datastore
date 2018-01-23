function define(script)
{
    script.Name = "branch_gender";
    script.Type = "EventBranchLogic";
    return 0;
}

function check(cState, dState, params)
{
    local character = cState.GetEntity();

    return character.GetGenderValue() == Character_Gender_t.MALE ? 0 : 1;
}