function define(script)
{
    script.Name = "branch_random";
    script.Type = "EventBranchLogic";
    return 0;
}

function check(cState, dState, zone, params)
{
    if(params.len() != 2)
    {
        return -1;
    }

    local success = params[0].tointeger();
    local fail = params[1].tointeger();
    if(Randomizer.RNG(1, success + fail) <= success)
    {
        return 0;
    }
    else
    {
        return -1;
    }
}