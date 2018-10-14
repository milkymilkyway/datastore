function define(script)
{
    script.Name = "bool_digitalizeRaceDLv";
    script.Type = "EventCondition";
    return 0;
}

// Checks if a character's digitalize level for a particular demon race is greater than a provided value.
// - value1 = ID of a demon race; if 0, check params instead.
// - value2 = DLevel
// - params[0]+ = list of race IDs to check.
function check(source, cState, dState, zone, value1, value2, params)
{
    local character = cState.GetEntity();
    if(character != null)
    {
        if(value1 != 0)
        {
            return character.GetProgress().DigitalizeLevels(value1) >= value2 ? 0 : -1;
        }
        else
        {
            for(local i = 0; i < params.len(); i++)
            {
                if(character.GetProgress().DigitalizeLevels(params[i].tointeger()) >= value2)
                {
                    return 0;
                }
            }
        }
        
    }
    return -1;
}