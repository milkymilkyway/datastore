function define(script)
{
    script.Name = "bool_TrialTime";
    script.Type = "EventCondition";
    return 0;
}

function check(source, cState, dState, zone, value1, value2, params)
{
    local character = cState.GetEntity();
    local progress = character != null ? character.GetProgress().Get() : null;
    local time = progress.GetTimeTrialRecordsByIndex(value1);
    if(time != null)
    {
        if(time <= value2)
        {
        return 0;
        }
    }
    return -1;
}