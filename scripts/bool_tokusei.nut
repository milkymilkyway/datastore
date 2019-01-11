function define(script)
{
    script.Name = "bool_tokusei";
    script.Type = "EventCondition";
    return 0;
}

// Check if the provided tokusei is active on a target
function check(source, cState, dState, zone, value1, value2, params)
{
    return source.EffectiveTokuseiKeyExists(params[0].toInteger()) ? 0 : -1;
}