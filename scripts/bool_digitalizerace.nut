function define(script)
{
    script.Name = "bool_digitalizeRace";
    script.Type = "EventCondition";
    return 0;
}

// Checks the demon race that a character is digitalized with.
// - value1 = ID of a demon race.
function check(source, cState, dState, zone, value1, params)
{
    local character = cState.GetEntity();
    if(character != null)
    {
        return cState.GetDigitalizeState().GetRaceID() == value1 ? 0 : -1;
    }
    return -1;
}