local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Importer, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
        ImportPacket = {},
		UpdatePackets = {}
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

Importer.Data.ImportPacket.NewPacket = function(self, Name, Data)
	local Packet = {
		Settings = {
			Name = Name,
			Data = Data,
			Model = nil
		},
		Data = {
			Initialized = false
		}
	}

	setmetatable(Packet, {
		__index = self
	})

	return Packet
end

Importer.Data.ImportPacket.UpdateModel = function(self: table, Model: Instance)
	self.Settings.Model = Model
end

Importer.Data.ImportPacket.LoadModel = function(self: table)
    local Model: Instance = game:GetObjects(syn and getsynasset("./Vehicles/" .. self.Settings.Data .. ".rbxm") or "rbxassetid://" .. self.Settings.Data)[1]

    return Model
end

Importer.Data.ImportPacket.InitPacket = function(self: table)
	if self.Data.Initialized then
		return
	end
	self.Data.Initialized = true
	self.Data.Model = self:LoadModel()
	self.Data.Origin = self.Settings.Model
	table.insert(Importer.Data.UpdatePackets, self)
end

Importer.Data.ImportPacket.Update = function(self: table)
	for i: number, v: Instance in next, self.Data.Origin:GetDescendants() do
		if v.Transparency then
			v.Transparency = 1
		end
	end
	for i: number, v:Instance in next, self.Data.Model:GetDescendants() do
		if v.CanCollide then
			v.CanCollide = false
		end
	end
end

Env.MCreateNewSave = function(Data: string | number)

end

return Importer.Module