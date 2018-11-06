function define(script)
{
    script.Name = "branch_counterValue";
    script.Type = "EventBranchLogic";
    return 0;
}

// Branch based on the current value of the specified event counter
// - params[0]: event counter
function check(source, cState, dState, zone, params)
{
    if(params.len() == 0)
    {
        return -1;
    }

    local counter = cState.GetEventCounter(params[0].tointeger());
    if(counter != null)
    {
        return counter.GetCounter();
    }

    return -1;
}