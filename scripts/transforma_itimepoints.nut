function define(script)
{
    script.Name = "transforma_iTimePoints";
    script.Type = "ActionTransform";
    return 0;
}

// Transform an ActionUpdatePoints command to ensure the character does not
// exceed the current I-Time rank using
// - params[0]: Min rank
// - params[1]: Max point value
// - params[2]: Optional CHARACTER_ZONE flag ID for boost percentage
function transform(source, cState, dState, zone, params)
{
    local character = cState.GetEntity();
    local progress = character ? character.GetProgress().Get() : null;
    local addPoints = action.GetValue();
    if(character == null || progress == null || params.len() < 2 || addPoints < 0)
    {
        return -1;
    }

    local minRank = params[0].tointeger();
    local maxPoints = params[1].tointeger();

    local points = progress.GetITimePointsByKey(action.GetITimeID());
    local oldPoints = points;

    // Calculated boosted amount if flag specified
    if(params.len() >= 3)
    {
        local flagVal = zone.GetFlagState(params[2].tointeger(), 0,
            cState.GetWorldCID());
        if(flagVal > 0)
        {
            addPoints = ((100 + flagVal) * addPoints) / 100;
        }
    }

    points = points + addPoints;
    if(oldPoints >= maxPoints)
    {
        // Snap to max points
        points = maxPoints;
    }
    else
    {
        // Lock at current rank
    for(local i = 0; i < 5; i++)
        {
            if((5 - i) <= minRank)
            {
                local max = 10000 - (i * 2000);
                if(oldPoints <= max && points > max)
                {
                    points = max;
                }
            }
        }
    }

    action.SetValue(points);

    return 0;
}