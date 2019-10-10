function define(script)
{
    script.Name = "action_spawnNear";
    script.Type = "ActionCustom";
    return 0;
}

// Spawn an enemy near the current source entity, accounting for zone geometry
// - params[0]+: Valid spawn IDs (one is randomly chosen)
function run(source, cState, dState, zone, server, params)
{
    if(params.len() < 1 || zone == null || source == null)
    {
        return Result_t.FAIL;
    }

    local xPos1 = source.GetCurrentX();
    local yPos1 = source.GetCurrentY();

    local zoneManager = server.GetZoneManager();
    local spawnID = params[Randomizer.RNG(0, params.len() - 1)].tointeger();
    local enemy = zoneManager.CreateEnemy(zone, 0, spawnID, 0,
        xPos1, yPos1, Randomizer.RNG(-314159, 314159) * 0.00001);
    if(enemy == null)
    {
        return Result_t.FAIL;
    }

    // todo: comment this in and remove the temporary reposition
    /*// Extend and rotate the point around the source 800 units out
    local radians = Randomizer.RNG(-314159, 314159) * 0.00001;

    local xPos2 = (800.0 * cos(radians)) + xPos1;
    local yPos2 = (800.0 * sin(radians)) + yPos1;*/

    // Temporary solution: move to 8 points on square around the source
    local xPos2 = xPos1;
    local yPos2 = yPos1;
    switch(Randomizer.RNG(1, 8))
    {
        case 1:
            xPos2 = xPos1 + 800.0;
            break;
        case 2:
            xPos2 = xPos1 + 800.0;
            yPos2 = yPos1 + 800.0;
            break;
        case 3:
            yPos2 = yPos1 + 800.0;
            break;
        case 4:
            xPos2 = xPos1 - 800.0;
            yPos2 = yPos1 + 800.0;
            break;
        case 5:
            xPos2 = xPos1 - 800.0;
            break;
        case 6:
            xPos2 = xPos1 - 800.0;
            yPos2 = yPos1 - 800.0;
            break;
        case 7:
            yPos2 = yPos1 - 800.0;
            break;
        case 8:
            xPos2 = xPos1 + 800.0;
            yPos2 = yPos1 - 800.0;
            break;
    }

    zoneManager.LinearReposition(enemy, xPos2, yPos2);

    local enemyList = [ enemy ];
    if(zoneManager.AddEnemiesToZone(enemyList, zone, true, true, ""))
    {
        local aiState = enemy.GetAIState();
        aiState.SetDespawnWhenLost(false);
        aiState.SetStatus(AIStatus_t.WANDERING, true);

        return Result_t.SUCCESS;
    }

    return Result_t.FAIL;
}