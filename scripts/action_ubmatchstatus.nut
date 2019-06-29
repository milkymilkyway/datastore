function define(script)
{
    script.Name = "action_UBMatchStatus";
    script.Type = "ActionCustom";
    return 0;
}

// - params[0]: Zone ID.
// - params[1]: Zone ID.
// - params[2]: ID of Zone Flag.
function run(source, cState, dState, zone, server, params)
{
    if(params.len() < 3 || zone == null)
    {
        return Result_t.FAIL;
    }

    local gZone = server.GetZoneManager().GetGlobalZone(params[0].tointeger(),
        params[1].tointeger());
    local ubMatch = gZone != null ? gZone.GetUBMatch() : null;
    if(ubMatch == null)
    {
        return Result_t.SUCCESS;
    }

    local participants = ubMatch.MemberIDsCount();

	local key = params[2].tointeger();
	zone.SetFlagState(key, participants, 0);

	return Result_t.SUCCESS;
}