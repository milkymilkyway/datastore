function define(script)
{
    script.Name = "transforme_shop";
    script.Type = "EventTransform";
    return 0;
}

function transform(source, cState, dState, zone, params)
{
    if(params.len() == 0 || cState == null)
    {
        return -1;
    }

    event.SetShopID(zone.GetFlagState(params[0].tointeger(), 0, cState.GetWorldCID()));

    return 0;
}