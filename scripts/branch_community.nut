function define(script)
{
    script.Name = "branch_community";
    script.Type = "EventBranchLogic";
    return 0;
}

// Branch based on the current or previous zone ID when entering
// or exiting the community area
function check(source, cState, dState, zone, params)
{
    local cZone = zone.GetDefinitionID();

    //Entering community area.
    if(cZone == 20101)
    {
        return 0;
    }
    else if(cZone == 50101 || cZone == 200101)
    {
        return 1;
    }

    //Leaving community area.
    local character = cState.GetEntity();
    if(character.PreviousZone == 20101)
    {
        return -1;
    }
    else if(character.PreviousZone == 50101)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}