function define(script)
{
    script.Name = "transforme_counterValue";
    script.Type = "EventTransform";
    return 0;
}

function transform(source, cState, dState, zone, params)
{
    if(params.len() == 0)
    {
        return -1;
    }

    local counter = cState.GetEventCounter(params[0].tointeger());

    if(counter != null)
    {
        event.SetMessageValue(counter.GetCounter());
    }
    else
    {
        event.SetMessageValue(0);
    }

    return 0;
}