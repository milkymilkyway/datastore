function define(script)
{
    script.Name = "bool_coin";
    script.Type = "EventCondition";
    return 0;
}

// - value1: Amount of coins.
function check(source, cState, dState, zone, value1, value2, params)
{
    local character = cState.GetEntity();
    if(character != null)
    {
        local coin = character.GetProgress().Get();
        if (coin != null)
        {
            return coin.GetCoins() >= value1 ? 0 : -1;
        }
    }
    return -1;
}