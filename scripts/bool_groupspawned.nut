function define(script)
{
    script.Name = "bool_groupSpawned";
    script.Type = "EventCondition";
    return 0;
}

// Check if the supplied spawn group has any living enemies
// - value1: current zone ID (for verification)
// - value2: spawn group ID
function check(source, cState, dState, zone, value1, value2, params)
{
    local cZone = zone.GetDefinitionID();
    return (cZone == value1) && zone.GroupHasSpawned(value2, true, true) ? 0 : -1;
}