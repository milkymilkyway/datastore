function define(script)
{
    script.Name = "branch_gender";
    script.Type = "EventBranchLogic";
    return 0;
}

function check(cState, dState, params)
{
    local character = cState.GetEntity();
    local lnc = character.GetLNC();

    return character.GetGenderValue();
}