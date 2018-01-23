function define(script)
{
    script.Name = "branch_LNC";
    script.Type = "EventBranchLogic";
    return 0;
}

function check(cState, dState, params)
{
    local character = cState.GetEntity();
    local lnc = character.GetLNC();

    if(lnc >= 5000)
    {
        // CHAOS
        return 2;
    }
    else if(lnc <= -5000)
    {
        // LAW
        return 0;
    }
    else
    {
        // NEUTRAL
        return 1;
    }

    return 0;
}