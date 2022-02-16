local function printPrefix( str )
    return string.format( "[ Simphys Modifier ] %s", str )
end

local function tableMerge( t1, t2 )
    for k, v in pairs( t2 ) do
        if type( v ) == "table" then
            if type( t1[k] or false ) == "table" then
                tableMerge( t1[k] or {}, t2[k] or {} )
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end

    return t1
end

local function modifyVehicle( vehicleClass, tbl )
    local vehicleTable = list.Get( "simfphys_vehicles" )[vehicleClass]

    if not vehicleTable then
        local msg = printPrefix( vehicleClass .. " was not found, skipping modification." )

        if SERVER then
            ErrorNoHalt( msg )
        else
            print( "msg" )
        end

        return
    end

    vehicleTable = tableMerge( vehicleTable, tbl )
    list.Set( "simfphys_vehicles", vehicleClass, vehicleTable )
    print( printPrefix( "Modified " .. vehicleClass .. " succesfully" ) )
end

-- Example useage
-- local sim_fphys_tank2 = {
--     Members = {
--         MaxHealth = 10
--     }
-- }
-- modifyVehicle( "sim_fphys_tank2", sim_fphys_tank2 )
