local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
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


Env.MCreateNewSave = function(Data: string | number)
    print(syn and Data or MarketplaceService:GetProductInfo(Data))
end

Env.LoadModel = function(Id: string)
    local Model = game:GetObjects("rbxassetid://" .. Id)[1]

    return Model
end

return Importer.Module