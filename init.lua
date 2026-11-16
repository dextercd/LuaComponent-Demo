function OnPlayerSpawned(p)
    local x, y = EntityGetTransform(p)

    EntityLoad("mods/LuaComponent-Demo/switch.xml", x - 20, y - 20)
    EntityLoad("mods/LuaComponent-Demo/switch.xml", x + 20, y - 20)
end
