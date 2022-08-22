local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Importer, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
		AlexChassis = require(ReplicatedStorage.Module.AlexChassis),
        ImportPacket = {},
		Packets = {}
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

local UpdateSteppedUpValues = debug.getupvalues(Importer.Data.AlexChassis.UpdateStepped)

Importer.Data.AlexChassis.UpdateStepped = function(p58)
	local t_Model_77 = p58.Model
	if (p58.IK) then
		local v501 = 0.6 * p58.RotY;
		local v502 = v501;
		p58.WeldSteer.C0 = UpdateSteppedUpValues[1](0, v501, 0);
		local t_CFrame_78 = t_Model_77.Steer.CFrame;
		local v503 = (t_Model_77.Steer.Size.X * 0.5) - 0.2;
		if CollectionService:HasTag(t_Model_77, "Overlayed") then
			local Steer = Importer.Data.Packets[t_Model_77:GetAttribute("Key")].Data.Model.Steer
			t_CFrame_78 = Steer.CFrame
			v503 = (Steer.Size.X * 0.5) - 0.2
		end
		local v504 = v503;
		local v505 = p58.SteerOffset;
		local t_SteerOffset_79 = v505;
		local t_IK_80 = p58.IK;
		local v506 = UpdateSteppedUpValues[2](v503, 0.1, 0);
		if (v505) then
			v506 = v506 + t_SteerOffset_79;
		end
		local v507 = UpdateSteppedUpValues[2](-v504, 0.1, 0);
		if (t_SteerOffset_79) then
			v507 = v507 + t_SteerOffset_79;
		end
		t_IK_80.RightArm = t_CFrame_78 * v506;
		t_IK_80.LeftArm = t_CFrame_78 * v507;
		t_IK_80.RightAngle = (-v502) - 0.6;
		t_IK_80.LeftAngle = (-v502) + 0.6;
		UpdateSteppedUpValues[3].Arms(t_IK_80);
	end
end

Importer.Data.AlexChassis.LockCamera = function(p66)
	assert(not p66.IsCameraLocked);
	local l__InsideCamera__368 = p66.Model:FindFirstChild("InsideCamera");
	if CollectionService:HasTag(p66.Model, "Overlayed") then
		l__InsideCamera__368 = Importer.Data.Packets[p66.Model:GetAttribute("Key")].Data.Model.InsideCamera
	end
	if l__InsideCamera__368 == nil then
		return false;
	end;
	p66.IsCameraLocked = true;
	Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
	p66.seatMaid.cameraLockRenderStepped = RunService.RenderStepped:Connect(function()
		Workspace.CurrentCamera.CFrame = l__InsideCamera__368.CFrame;
	end);
	p66.seatMaid.cameraUnlock = function()
		Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
	end;
end

Workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
	if Workspace.CurrentCamera.CameraSubject:IsDescendantOf(Workspace.Vehicles) and CollectionService:HasTag(Workspace.CurrentCamera.CameraSubject.Parent, "Overlayed") then
		Workspace.CurrentCamera.CameraSubject = Importer.Data.Packets[Workspace.CurrentCamera.CameraSubject.Parent:GetAttribute("Key")].Data.Model.Camera
	end
end)

Env.GetNearestThrust = function(Wheel)
	local Thrust, Distance = nil, 9e9
	for i, v in next, Wheel.Parent:GetChildren() do
		if v.Name == "Thrust" then
			local Magnitude = math.abs((Wheel.Wheel.Position - v.Position).Magnitude)
			if Distance > Magnitude then
				Thrust, Distance = v, Magnitude
			end
		end
	end
	return Thrust, Distance
end

Importer.Data.ImportPacket.NewPacket = function(self, Name, Data)
	local Packet = {
		Settings = {
			Name = Name,
			Data = Data,
			Model = nil,
			Height = 0
		},
		Data = {
			Key = os.clock() .. string.char(math.random(1, 200)),
			Initialized = false,
			Calculated = {},
			LatchCFrames = {},
			RelativeWheels = {},
			RelativeThrust = {},
			RelativeSteeringWheel = nil,
			LargestWheelSize = 0
		}
	}

	setmetatable(Packet, {
		__index = self
	})

	return Packet
end

Importer.Data.ImportPacket.UpdateModel = function(self, Model)
	if self.Data.Initialized then
		return "This config has already been initialized, you can not update it's base model\nPlease clone the config if you would like to overlay it over another model", Vector2.new(600, 800)
	end
	self.Settings.Model = Model
	return "Model Updated", Vector2.new(0, 900)
end

Importer.Data.ImportPacket.UpdateHeight = function(self, Height)
	self.Settings.Height = Height
end

Importer.Data.ImportPacket.LoadModel = function(self)
    local Model = game:GetObjects(getsynasset and getsynasset("./Vehicles/" .. self.Settings.Data .. ".rbxm") or "rbxassetid://" .. self.Settings.Data)[1]

    return Model
end

Importer.Data.ImportPacket.InitPacket = function(self)
	if self.Data.Initialized then
		return "Config already initialized", Vector2.new(600, 800)
	end
	if self.Settings.Model == nil or not self.Settings.Model:IsDescendantOf(Workspace.Vehicles) then
		return "Base model does not exist", Vector2.new(600, 800)
	end
	self.Data.Initialized = true
	self.Data.Model = self:LoadModel()
	self.Data.Chassis = self.Settings.Model

	Importer.Data.Packets[self.Data.Key] = self

	self.Data.Chassis:SetAttribute("Key", self.Data.Key)
	CollectionService:AddTag(self.Data.Chassis, "Overlayed")

	local WheelDiff = self.Data.Model.WheelFrontLeft.Wheel.Position - self.Data.Model.WheelBackRight.Wheel.Position
	self.Data.Model.PrimaryPart.Position = WheelDiff.Unit * (WheelDiff.Magnitude/2) + self.Data.Model.WheelBackRight.Wheel.Position

	for i, v in next, self.Data.Model:GetChildren() do
		if string.find(v.Name, "Wheel") and v:IsA("Model") then
			local NewRim = self.Data.Chassis[v.Name].Rim:Clone()
			NewRim.Size = Vector3.new(v.Wheel.Size.X, v.Rim.Size.Y, v.Rim.Size.Z)
			NewRim.CFrame = v.Wheel.CFrame:ToWorldSpace(self.Data.Chassis[v.Name].Wheel.CFrame:ToObjectSpace(self.Data.Chassis[v.Name].Rim.CFrame))
			v.Rim:Destroy()
			NewRim.Parent = v

			local NewWheel = self.Data.Chassis[v.Name].Wheel:Clone()
			NewWheel.Size = v.Wheel.Size
			NewWheel.CFrame = v.Rim.CFrame:ToWorldSpace(self.Data.Chassis[v.Name].Rim.CFrame:ToObjectSpace(self.Data.Chassis[v.Name].Wheel.CFrame))
			v.Wheel:Destroy()
			NewWheel.Parent = v

			table.insert(self.Data.Calculated, v.Wheel)
			table.insert(self.Data.Calculated, v.Rim)
			self.Data.RelativeWheels[v.Name] = {
				Rim = self.Data.Model.PrimaryPart.CFrame:ToObjectSpace(v.Rim.CFrame),
				Wheel = self.Data.Model.PrimaryPart.CFrame:ToObjectSpace(v.Wheel.CFrame),
			}

			self.Data.LargestWheelSize = NewWheel.Size.Y > self.Data.LargestWheelSize and NewWheel.Size.Y/2 or self.Data.LargestWheelSize

			local Thrust = Importer.Functions.GetNearestThrust(self.Data.Chassis[v.Name])
			self.Data.RelativeThrust[Thrust] = self.Data.Chassis.PrimaryPart.CFrame:ToObjectSpace(Thrust.CFrame)
		end
	end

	for i, v in next, self.Data.Model:GetDescendants() do
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

	self.Data.Model.PrimaryPart.CFrame = self.Data.Chassis.PrimaryPart.CFrame + Vector3.new(0, self.Settings.Height, 0)
	self.Data.Model.Seat.CFrame = self.Data.Model.PrimaryPart.CFrame:ToWorldSpace(self.Data.LatchCFrames[self.Data.Model.Seat])

	local Update = RunService.Heartbeat:Connect(function()
		self:Update()
	end)
	Workspace.Vehicles.DescendantRemoving:Connect(function(descendant)
		if descendant == self.Data.Chassis then
			Update:Disconnect()
		end
	end)

	if Workspace.CurrentCamera.CameraSubject:IsDescendantOf(Workspace.Vehicles) and CollectionService:HasTag(Workspace.CurrentCamera.CameraSubject.Parent, "Overlayed") then
		Workspace.CurrentCamera.CameraSubject = Importer.Data.Packets[Workspace.CurrentCamera.CameraSubject.Parent:GetAttribute("Key")].Data.Model.Camera
	end

	return "Config initialized", Vector2.new(0, 900)
end

Importer.Data.ImportPacket.Update = function(self)
	local HasPlayer = self.Data.Chassis:FindFirstChild("Seat") and self.Data.Chassis.Seat:FindFirstChild("PlayerName") and self.Data.Chassis.Seat.PlayerName.Value == Players.LocalPlayer.Name

	for i, v in next, self.Data.Chassis:GetDescendants() do
		if v:IsA("Decal") or v:IsA("BasePart") or v:IsA("TextLabel") then
			v.Transparency = 1
		end
	end
	for i, v in next, self.Data.Model:GetDescendants() do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end

	self.Data.Model.PrimaryPart.CFrame = self.Data.Chassis.PrimaryPart.CFrame  + Vector3.new(0, self.Settings.Height - (HasPlayer and self.Data.LargestWheelSize or 0), 0)

	for i,v in next, self.Data.LatchCFrames do
		i.CFrame = self.Data.Model.PrimaryPart.CFrame:ToWorldSpace(v)
	end

	self.Data.Chassis.Seat.Weld.C0 = self.Data.Model.Seat.CFrame:Inverse() * self.Data.Chassis.PrimaryPart.CFrame
	for i, v in next, self.Data.Model:GetChildren() do
		if string.find(v.Name, "Wheel") and v:IsA("Model") then
			local Thrust = Importer.Functions.GetNearestThrust(self.Data.Chassis[v.Name])
			local ThrustCF = self.Data.Chassis.PrimaryPart.CFrame:ToWorldSpace(self.Data.RelativeThrust[Thrust])
			local WorldCF = self.Data.Chassis.PrimaryPart.CFrame:ToWorldSpace(self.Data.RelativeWheels[v.Name].Wheel)
			Thrust.Position = HasPlayer and Vector3.new(WorldCF.X, ThrustCF.Position.Y - self.Data.Model[v.Name].Wheel.Size.Y/2, WorldCF.Z) or ThrustCF.Position
		end
	end

	if self.Data.Chassis.Model:FindFirstChild("SteeringWheel") then
		self.Data.Model.Model.SteeringWheel.Orientation = Vector3.new(self.Data.Model.Model.SteeringWheel.Orientation.X, self.Data.Model.Model.SteeringWheel.Orientation.Y, self.Data.Chassis.Model.SteeringWheel.Orientation.Z)
	end

	for i, v in next, self.Data.Model:GetChildren() do
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

Env.MCreateNewSave = function(Data)
	local Packet = Importer.Data.ImportPacket:NewPacket(getsynasset and Data or MarketplaceService:GetProductInfo(Data).Name, Data)

	return Packet
end

return Importer.Module