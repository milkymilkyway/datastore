function define(script)
{
    script.Name = "bool_accountCooldown";
    script.Type = "EventCondition";
    return 0;
}

// Check if any of the supplied account cooldown IDs are active on the source
// - params[0]+: cooldown IDs
function check(source, cState, dState, zone, value1, value2, params)
{
    local character = cState != null ? cState.GetEntity() : null;
    if(character == null)
    {
        return -1;
    }

    cState.RefreshActionCooldowns(true, 0);
    for(local i = 0; i < params.len(); i++)
    {
        if(cState.ActionCooldownActive(params[i].tointeger(), true, false))
        {
            return 0;
        }
    }

    return -1;
}