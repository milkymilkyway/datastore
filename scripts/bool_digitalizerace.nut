function define(script)
{
    script.Name = "bool_digitalizeRace";
    script.Type = "EventCondition";
    return 0;
}

// Checks the demon race that a character is digitalized with.
// - value1 = ID of a demon race or -1 for any.
function check(source, cState, dState, zone, value1, value2, params)
{
    local character = cState.GetEntity();
    if(character != null)
    {
        local dgState = cState.GetDigitalizeState();
        if(dgState)
        {
            return value1 == -1 ? 0 : (dgState.GetRaceID() == value1 ? 0 : -1);
        }
    }

    return -1;
}