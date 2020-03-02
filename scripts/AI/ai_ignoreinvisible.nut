function define(script)
{
    script.Name = "ignoreInvisible";
    script.Type = "AI";
    return 0;
}

function prepare(eState, manager)
{
    local aiState = eState.GetAIState();
    aiState.SetActionOverridesEntry("target", "seeNoEvil");
    return 0;
}

function seeNoEvil(eState, possibleTargets, manager, now)
{
    local valid = [];

    for(local i = 0; i < possibleTargets.len(); i++)
    {
        local enemyState = EnemyState.Cast(possibleTargets[i]);
        local enemy = enemyState != null ? enemyState.GetEntity() : null;
        if(enemy && enemy.GetType() == 5273 || enemy.GetType() == 5274 || enemy.GetType() == 5275 || 
        enemy.GetType() == 5276 || enemy.GetType() == 5250 || enemy.GetType() == 5242 ||
        enemy.GetType() == 5324 || enemy.GetType() == 5262 || enemy.GetType() == 5287 || 
        enemy.GetType() == 5288 || enemy.GetType() == 5289 || enemy.GetType() == 5290 ||
        enemy.GetType() == 5291 || enemy.GetType() == 5292 || enemy.GetType() == 5293 ||
        enemy.GetType() == 5294 || enemy.GetType() == 5295 || enemy.GetType() == 5264)
        {
            continue;
        }
        else
        {
            valid.append(enemyState.GetEntityID());
        }
    }

    return valid.len() > 0 ? valid[Randomizer.RNG(0, valid.len() - 1)] : 0;
}