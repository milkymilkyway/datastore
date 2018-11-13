function define(script)
{
    script.Name = "action_UBTimer";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    if(params.len() < 4)
    {
        return Result_t.FAIL;
    }

	local gZone = server.GetZoneManager().GetGlobalZone(params[0].tointeger(),
        params[1].tointeger());

	local endPhase = false;
	if(params.len() >= 5 && params[4].tointeger() == 1)
	{
		endPhase = true;
	}

	local match = gZone.GetUBMatch();
	if(match)
	{
		if(endPhase)
		{
			match.State = UBMatch_State_t.PREROUND;
		}
		else
		{
			match.State = UBMatch_State_t.ROUND;
		}
	}

    return server.GetMatchManager().StartUltimateBattleTimer(gZone,
        params[2].tointeger(), params[3], endPhase) ? Result_t.SUCCESS : Result_t.FAIL;
}