function define(script)
{
    script.Name = "action_UBReset";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    local matchManager = server.GetMatchManager();
    local syncManager = server.GetChannelSyncManager();
    local worldDB = server.GetWorldDatabase();

	local previous = matchManager.GetUBTournament();
	local worldClock = server.GetWorldClockTime();

	local tournament = UBTournament();
	tournament.SetStartTime(worldClock.SystemTime);
	if(previous)
	{
		tournament.SetPrevious(previous.GetUUID());
		previous.SetEndTime(worldClock.SystemTime);
	}

	if(!PersistentObject.Register(tournament, UUID()) || !tournament.Insert(worldDB) ||
		(previous && !previous.Update(worldDB)))
	{
		return Result_t.FAIL;
	}

	syncManager.UpdateRecord(tournament, "UBTournament");
	if(previous)
	{
		syncManager.UpdateRecord(previous, "UBTournament");
	}

	syncManager.SyncOutgoing();

    return Result_t.SUCCESS;
}