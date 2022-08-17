--!nocheck

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Loaded = {}

import = function(dir: string)
    if not Loaded[dir] then
        Loaded[dir] = Vehicle_Importer[dir]()
    end
    return Loaded[dir]
end

local CreateUi = import("Ui/Create.lua")

CreateUi.Functions.CreateUi()