if not game:IsLoaded() then
    game.Loaded:Wait()
end

getgenv().getcustomasset = getcustomasset or getsynasset

if not isfile("jailbreak.png") then
    writefile("jailbreak.png", game:HttpGet())
end
if not isfile("badimo.webm") then
    writefile("badimo.webm", game:HttpGet())
end

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