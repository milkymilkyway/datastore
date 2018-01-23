function define(script)
{
    script.Name = "branch_randomSplit";
    script.Type = "EventBranchLogic";
    return 0;
}

function check(cState, dState, params)
{
    if(params.len() != 1)
    {
        return -1;
    }

    return Randomizer.RNG(0, params[0].tointeger() - 1);
}