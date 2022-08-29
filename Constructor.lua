if not game:IsLoaded() then
    game.Loaded:Wait()
end

getgenv().getcustomasset = getcustomasset or getsynasset

local Loaded = {}

import = function(dir)
    if not Loaded[dir] then
        Loaded[dir] = Vehicle_Importer[dir]()
    end
    return Loaded[dir]
end

local CreateUi = import("Ui/Create.lua")
local ReadWrite = import("Modules/ReadWrite/ReadWrite.lua")

ReadWrite.Functions.SetupReadWrite()
CreateUi.Functions.CreateUi()