if not game:IsLoaded() then
    game.Loaded:Wait()
end

getgenv().getcustomasset = getcustomasset or getsynasset

if not isfile("jailbreak.png") then
    writefile("jailbreak.png", game:HttpGet("https://github.com/HazeWasTaken/PayPal_Importer/blob/main/Images/jailbreak.png?raw=true"))
end
if not isfile("badimo.webm") then
    writefile("badimo.webm", game:HttpGet("https://github.com/HazeWasTaken/PayPal_Importer/blob/main/Images/badimo.webm?raw=true"))
end

local Loaded = {}

import = function(dir)
    local Split = string.split(dir, "/")
    local Data = Vehicle_Importer

    Split[#Split] = string.split(Split[#Split], ".")[1]

    for i = 1 , #Split  do
        Data = Data[Split[i]]
    end

    if not Loaded[dir] and typeof(Data) == "function" then
        Loaded[dir] = Data()
    elseif typeof(Data) == "table" then
        Loaded[dir] = {}
        for i, v in next, Data do
            Loaded[dir][i] = import(dir .. "/" .. i)
        end
    end

    return Loaded[dir]
end

local CreateUi = import("Ui/Create.lua")
local ReadWrite = import("Modules/ReadWrite/ReadWrite.lua")

ReadWrite.Functions.SetupReadWrite()
CreateUi.Functions.CreateUi()