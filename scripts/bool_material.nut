function define(script)
{
    script.Name = "bool_material";
    script.Type = "EventCondition";
    return 0;
}

// Check if the supplied material count exists in the tank
// - value1: material ID
// - value2: item count
function check(cState, dState, zone, value1, value2, params)
{
    local character = cState.GetEntity();
    if(character != null)
    {
        return character.GetMaterialsByKey(value1) >= value2 ? 0 : -1;
    }

    return -1;
}