function define(script)
{
    script.Name = "action_UBQueue";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    if(params.len() < 2)
    {
        return Result_t.FAIL;
    }

	local gZone = server.GetZoneManager().GetGlobalZone(params[0].tointeger(),
        params[1].tointeger());

    local match = UBMatch();
    match.SetQueueDuration(1);
    match.SetAnnounceDuration(1);
    match.SetReadyDuration(10);
    match.SetDarkLimit(400000);
    match.SetGaugeDecay(5000);
    match.SetGaugeDecayScale(1.25);
    return server.GetMatchManager().StartStopMatch(gZone, match)
		? Result_t.SUCCESS : Result_t.FAIL;
}