function define(script)
{
    script.Name = "default";
    return 0;
}

function update(eState, now)
{
    // Rotate more whenever rotation completes
    if(!eState.IsRotating())
    {
        local rot = eState.GetCurrentRotation();
        rot += 1.0;
        eState.Rotate(rot, now);
        return 1;
    }
    
    return 0;
}