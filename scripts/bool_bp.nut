function define(script)
{
    script.Name = "bool_bp";
    script.Type = "EventCondition";
    return 0;
}

// Check if a character has a certain amount of PvP BP
// - value1: BP amount
function check(source, cState, dState, zone, value1, value2, params)
{
    local character = cState.GetEntity();
    if(character != null)
    {
        local pvp = character.GetPvPData().Get();
        if (pvp != null)
        {
            return pvp.GetBP() >= value1 ? 0 : -1;
        }
    }
    return -1;
}