function define(script)
{
    script.Name = "branch_dungeonVariant";
    script.Type = "EventBranchLogic";
    return 0;
}

// Branch on a dungeon's variant type.
function check(source, cState, dState, zone, params)
{
    local cInstance = zone.GetZoneInstance().GetVariant();
    if(cInstance != null)
    {
        if(cInstance.InstanceType == ServerZoneInstanceVariant_InstanceType_t.TIME_TRIAL)
        {
            return 0;
        }
        if(cInstance.InstanceType == ServerZoneInstanceVariant_InstanceType_t.DEMON_ONLY)
        {
            return 1;
        }
    }
    return -1;
}