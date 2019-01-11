function define(script)
{
    script.Name = "action_toggleTower";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    if(params.len() < 2)
    {
        return Result_t.FAIL;
    }

    local bases = zone.GetDiasporaBases();

    local sourceEntityID = cState != null ? cState.GetEntityID() : -1;
    local capture = params[0].tointeger() == 1;
    local matchManager = server.GetMatchManager();
    local anyMissing = false;
    for(local i = 1; i < params.len(); i++)
    {
        local missing = true;
        local baseID = params[i].tointeger();
        for(local k = 0; k < bases.len(); k++)
        {
            if(bases[k].GetEntity().GetDefinition().GetID() == baseID)
            {
                matchManager.ToggleDiasporaBase(zone, bases[k].GetEntityID(),
                    sourceEntityID, capture);
                missing = false;
                break;
            }
        }

        anyMissing = anyMissing || missing;
    }

    return anyMissing ? Result_t.SUCCESS : Result_t.FAIL;
}