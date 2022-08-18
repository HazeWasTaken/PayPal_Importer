local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

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
			Model = Importer.Functions.GetLocalVehiclePacket().Model
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
	self.Data.Chassis = self.Settings.Model

	self.Data.Model.Parent = Workspace

	for i,v in next, self.Data.Model:GetDescendants() do
        if v:IsA("BasePart") and not v == self.Data.Model.PrimaryPart then
            v.Anchored = false
            local Weld = Instance.new("WeldConstraint", v)
            Weld.Part0 = v
            Weld.Part1 = self.Data.Model.PrimaryPart
        end
    end

	self.Data.Model.PrimaryPart.CFrame = self.Data.Chassis.PrimaryPart.CFrame

	self.Data.Chassis.Seat.Weld:Destroy()
    self.Data.Model.Seat.WeldConstraint.Parent = self.Data.Chassis.Seat
    self.Data.Chassis.Seat.WeldConstraint.Part0 = self.Data.Chassis.Seat

	self.Data.Chassis.Seat.Weld.Enabled = false
	self.Data.Chassis.Seat.CFrame = self.Data.Model.Seat.CFrame
	self.Data.Chassis.Seat.Weld.Part1 = self.Data.Model.PrimaryPart
	self.Data.Chassis.Seat.Weld.Enabled = true

	RunService.Heartbeat:Connect(function(deltaTime)
		self:Update()
	end)
end

Importer.Data.ImportPacket.Update = function(self: table)
	for i: number, v: Instance in next, self.Data.Chassis:GetDescendants() do
		if v:IsA("Decal") or v:IsA("BasePart") or v:IsA("TextLabel") then
			v.Transparency = 1
		end
	end
	for i: number, v:Instance in next, self.Data.Model:GetDescendants() do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end

	self.Data.Model.PrimaryPart.CFrame = self.Data.Chassis.PrimaryPart.CFrame
end

Env.MCreateNewSave = function(Data: string | number)
	local Packet = Importer.Data.ImportPacket:NewPacket(syn and Data or MarketplaceService:GetProductInfo(Data).Name, Data)

	return Packet
end

return Importer.Module