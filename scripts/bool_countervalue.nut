function define(script)
{
    script.Name = "bool_counterValue";
    script.Type = "EventCondition";
    return 0;
}

// Check the current value of the specified event counter
// - value1: event counter
// - value2: value
function check(source, cState, dState, zone, value1, value2, params)
{
    local character = cState.GetEntity();
    if(character != null)
    {
        if(value1 != null && value2 != null)
        {
            local counter = character.GetEventCounter(value1);
            if(counter != null)
            {
                return counter.GetCounter() >= value2 ? 0 : -1;
            }
        }    
    }
    return -1;
}