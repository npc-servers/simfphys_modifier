local rawget = rawget
-- Damage multipliers for example 2 means double damage and 0.5 means simphys only take half damage.
local weaponModifiers = {
    --["weapon_357"] = 100, --Makes the magnum do 100x more damage
    ["weapon_lfsmissilelauncher"] = 2,
    ["khr_m95"] = 7,
}

hook.Add( "EntityTakeDamage", "SimphysModifiers_DamageModifiers", function( target, dmginfo )
    if not IsValid( target ) then return end
    if target:GetClass() ~= "gmod_sent_vehicle_fphysics_base" then return end

    local weapon
    local attacker = dmginfo:GetAttacker()

    if attacker:IsPlayer() then
        weapon = attacker:GetActiveWeapon() or attacker
    else    
        weapon = attacker
    end

    if not IsValid( weapon ) then return end
    local weaponClass = weapon:GetClass()

    local mult = rawget( weaponModifiers, weaponClass )
    if not mult then return end
    dmginfo:ScaleDamage( mult )
end)