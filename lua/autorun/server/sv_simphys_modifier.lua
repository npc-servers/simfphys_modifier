local rawget = rawget
local weaponModifiers = {
    --["weapon_357"] = 100, --Makes the magnum do 100x more damage
}

hook.Add( "EntityTakeDamage", "SimphysModifiers_DamageModifiers", function( target, dmginfo )
    if not IsValid( target ) then return end
    if target:GetClass() ~= "gmod_sent_vehicle_fphysics_base" then return end

    local weapon = dmginfo:GetAttacker():GetActiveWeapon()
    if not IsValid( weapon ) then return end
    local weaponClass = weapon:GetClass()

    local mult = rawget( weaponModifiers, weaponClass )
    if not mult then return end
    dmginfo:ScaleDamage( mult )
end)
