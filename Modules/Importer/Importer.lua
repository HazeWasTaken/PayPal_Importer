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
			Model = nil
		},
		Data = {
			Initialized = false,
			Calculated = {},
			LatchCFrames = {},
			RelativeWheels = {}
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

	for i: number, v: Instance in next, self.Data.Model:GetChildren() do
		if string.find(v.Name, "Wheel") and v:IsA("Model") then
			table.insert(self.Data.Calculated, v.Wheel)
			table.insert(self.Data.Calculated, v.Rim)
			self.Data.RelativeWheels[v.Name] = {
				Rim = self.Data.Model.PrimaryPart.CFrame:ToObjectSpace(v.Rim.CFrame),
				Wheel = self.Data.Model.PrimaryPart.CFrame:ToObjectSpace(v.Wheel.CFrame),
			}
		end
	end

	for i: number, v: Instance in next, self.Data.Model:GetDescendants() do
		if v:IsA("Weld") then
			v:Destroy()
		end
		if v:IsA("BasePart") then
			v.Anchored = false
			if v ~= self.Data.Model.PrimaryPart and not table.find(self.Data.Calculated, v) then
				self.Data.LatchCFrames[v] = self.Data.Model.PrimaryPart.CFrame:ToObjectSpace(v.CFrame)
			end
		end
	end

	self.Data.Model.Parent = Workspace

	self.Data.Model.PrimaryPart.CFrame = self.Data.Chassis.PrimaryPart.CFrame
	self.Data.Model.Seat.CFrame = self.Data.Model.PrimaryPart.CFrame:ToWorldSpace(self.Data.LatchCFrames[self.Data.Model.Seat])
	self.Data.Chassis.Seat.Weld.C0 = self.Data.Model.Seat.CFrame:Inverse() * self.Data.Chassis.PrimaryPart.CFrame

	local Update = RunService.Heartbeat:Connect(function()
		self:Update()
	end)
	Workspace.Vehicles.DescendantRemoving:Connect(function(descendant)
		if descendant == self.Data.Chassis then
			Update:Disconnect()
		end
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

	for i,v in next, self.Data.LatchCFrames do
		i.CFrame = self.Data.Model.PrimaryPart.CFrame:ToWorldSpace(v)
	end

	for i: number, v: Instance in next, self.Data.Model:GetChildren() do
		if string.find(v.Name, "Wheel") and v:IsA("Model") then
			local RimCFrame, RelativeRim = table.pack(self.Data.Chassis[v.Name].Rim.CFrame:GetComponents()), self.Data.Model.PrimaryPart.CFrame:ToWorldSpace(self.Data.RelativeWheels[v.Name].Rim)
			local WheelCFrame, RelativeWheel = table.pack(self.Data.Chassis[v.Name].Wheel.CFrame:GetComponents()), self.Data.Model.PrimaryPart.CFrame:ToWorldSpace(self.Data.RelativeWheels[v.Name].Wheel)

			RimCFrame[1] = RelativeRim.X
			RimCFrame[3] = RelativeRim.Z
			WheelCFrame[1] = RelativeWheel.X
			WheelCFrame[3] = RelativeWheel.Z

			v.Rim.CFrame = CFrame.new(table.unpack(RimCFrame))
			self.Data.Chassis[v.Name].Rim.Size = v.Rim.Size
			v.Wheel.CFrame = CFrame.new(table.unpack(WheelCFrame))
			self.Data.Chassis[v.Name].Wheel.Size = v.Wheel.Size
		end
	end
end

Env.MCreateNewSave = function(Data: string | number)
	local Packet = Importer.Data.ImportPacket:NewPacket(syn and Data or MarketplaceService:GetProductInfo(Data).Name, Data)

	return Packet
end

return Importer.Module