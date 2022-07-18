local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Importer, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
        Saves = {}
    },
	Functions = {
        GetLocalVehiclePacket = require(ReplicatedStorage.Game.Vehicle).GetLocalVehiclePacket
    }
}, {}

local LMeta = {
	__index = function(self: table, index: string)
		return Env[index]
	end
}

local MMeta = {
	__index = function(self: table, index: string)
		return Env["M" .. index]
	end
}

setmetatable(Importer.Functions, LMeta)
setmetatable(Importer.Module.Functions, MMeta)

Env.LoadSaves = function(List)
    for i,v in next, List.Lists do
        firesignal(v.List_remove.MouseButton1Down)
    end
    for i, v in next, listfiles("./Importer/Saves") do
        List:CreateListAtribute({Name = v, Value = HttpService:JSONDecode(readfile(v))})
    end
end

Env.CreateNewSave = function(Name)
    local SaveIndex = os.time()

    Importer.Data.Saves[SaveIndex] = {
        Name = Name
    }

    writefile("./Importer/Saves/" .. Name .. ".json", HttpService:JSONEncode(Importer.Data.Saves[SaveIndex]))

    return SaveIndex
end

Env.UpdateSaveId = function(Id: string, SaveIndex: number)
    Importer.Data.Saves[SaveIndex].Id = Id

    writefile("./Importer/Saves/" .. Importer.Data.Saves[SaveIndex].Name .. ".json", HttpService:JSONEncode(Importer.Data.Saves[SaveIndex]))
end

Env.UpdateModel = function(SaveIndex: number)
    Importer.Data.Saves[SaveIndex].BaseModel = Importer.Functions.GetLocalVehiclePacket().Model

    writefile("./Importer/Saves/" .. tostring(SaveIndex) .. ".json", HttpService:JSONEncode(Importer.Data.Saves[SaveIndex]))
end

Env.LoadModel = function(Id: string)
    local Model = game:GetObjects("rbxassetid://" .. Id)[1]

    return Model
end

return Importer