local ReadWrite = import("Modules/ReadWrite/ReadWrite.lua")
local Customization = import("Modules/Importer/Customization.lua")

local Importer = {
	Data = {
		AlexChassis = require(ReplicatedStorage.Module.AlexChassis),
        Vehicle = require(ReplicatedStorage.Game.Vehicle),
        ImportPacket = {},
		Packets = {}
    },
	Functions = {
		getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
    }
}

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

require(ReplicatedStorage.Game.Garage.StoreData.BodyColor).Update = function(p2, p3)
	local v7 = os.clock() / 2;
	p2.CFrame = (CFrame.Angles(0, v7 % (math.pi * 2), 0) * CFrame.Angles((math.sin(v7) * 0.25) - 0.3, 0, 0)) * CFrame.new(0, 0, p3.BoundingBox.Size.Magnitude * 0.6);
end

require(ReplicatedStorage.Game.Garage.StoreData.SecondTexture).Update = function(p2, p3)
	local v7 = os.clock() / 2;
	p2.CFrame = (CFrame.Angles(0, v7 % (math.pi * 2), 0) * CFrame.Angles((math.sin(v7) * 0.25) - 0.3, 0, 0)) * CFrame.new(0, 0, p3.BoundingBox.Size.Magnitude * 0.6);
end

require(ReplicatedStorage.Game.Garage.StoreData.Texture).Update = function(p2, p3)
	local v7 = os.clock() / 2;
	p2.CFrame = (CFrame.Angles(0, v7 % (math.pi * 2), 0) * CFrame.Angles((math.sin(v7) * 0.25) - 0.3, 0, 0)) * CFrame.new(0, 0, p3.BoundingBox.Size.Magnitude * 0.6);
end

local GetLocalVehicleModel = Importer.Data.Vehicle.GetLocalVehicleModel

Importer.Data.Vehicle.GetLocalVehicleModel = function()
    local Model = GetLocalVehicleModel()
    if debug.getinfo(2).name == "GetInstance" and Model and CollectionService:HasTag(Model, "Overlayed") then
        return Importer.Data.Packets[Model:GetAttribute("Key")].Data.Model
    end
    return GetLocalVehicleModel()
end

local getDefaultVehicleModel

pcall(function()
	getDefaultVehicleModel = hookfunction(Importer.Functions.getDefaultVehicleModel, function(Make, Type)
		local CollectionService = game:GetService("CollectionService")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")

		local CallingFunc = debug.getinfo(2).name
		if CallingFunc and (string.find(CallingFunc, "GetInstance") or string.find(CallingFunc, "getInstForSelection")) then
			local Packet = require(ReplicatedStorage.Game.Vehicle).GetLocalVehiclePacket()
			if Packet and CollectionService:HasTag(Packet.Model, "Overlayed") and Make == Packet.Make then
				return getDefaultVehicleModel(Importer.Data.Packets[Packet.Model:GetAttribute("Key")].Data.Model.Name, "Chassis")
			end
		end
		return getDefaultVehicleModel(Make, Type)
	end)
end)

Workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
	if Workspace.CurrentCamera.CameraSubject:IsDescendantOf(Workspace.Vehicles) and CollectionService:HasTag(Workspace.CurrentCamera.CameraSubject.Parent, "Overlayed") then
		Workspace.CurrentCamera.CameraSubject = Importer.Data.Packets[Workspace.CurrentCamera.CameraSubject.Parent:GetAttribute("Key")].Data.Model.Camera
	end
end)

Importer.Data.ImportPacket.WheelDescendant = function(Wheels, BasePart)
	for i,v in next, Wheels do
		if BasePart:IsDescendantOf(i) then
			return true
		end
	end
end

Importer.Data.ImportPacket.NewPacket = function(self, Data)
	if Data.Key and Importer.Data.Packets[Data.Key] then
		return
	end

	local Type = string.split(Data.Data, "\\")[3]
	print(Type)
	local Packet = {
		Settings = {
			Name = Data.Name,
			Data = Data.Data,
			Model = nil,
			Height = Data.Height,
			SimulateWheels = Data.SimulateWheels
		},
		VehiclePackets = {},
		Data = Type == "Cars" and {
			Key = Data.Key or math.ceil(os.clock() + math.random(1, 200)),
			Type = Type,
			Initialized = false,
			Calculated = {},
			LatchCFrames = {},
			ChassisTransparency = {},
			Wheels = {},
			WheelSize = {},
			RealWheels = {},
			RelativeWheels = {},
			RelativeThrust = {},
			PropertyChanges = {
				Nitrous = {},
				Headlights = {},
				Brakelights = {}
			},
			Connections = {
				Spoiler = {},
				Misc = {}
			},
			DescendantData = {},
			ChildData = {},
			SeatCF = nil,
			RelativeSteeringWheel = nil,
			LargestWheelSize = 0
		} or Type == "Helis" and {
			Key = Data.Key or math.ceil(os.clock() + math.random(1, 200)),
			Type = Type,
			Initialized = false,
			Calculated = {},
			LatchCFrames = {},
			ChassisTransparency = {},
			DescendantData = {},
			ChildData = {},
			Connections = {
				Discs = {},
				Misc = {}
			},
			SeatCF = nil
		}
	}

	setmetatable(Packet, {
		__index = self
	})

	Importer.Data.Packets[Packet.Data.Key] = Packet

	ReadWrite.Functions.WriteConfig(Packet)

	return Packet
end

Importer.Data.ImportPacket.UpdateModel = function(self, Model)
	if self.Data.Initialized then
		return "This config has already been initialized, you can not update it's base model\n\nWould you like to reload the config?", Vector2.new(600, 800)
	end
	self.Settings.Model = Model
	return "Model Updated", Vector2.new(0, 900)
end

Importer.Data.ImportPacket.UpdateHeight = function(self, Height)
	self.Settings.Height = Height
	ReadWrite.Functions.WriteConfig(self)
end

Importer.Data.ImportPacket.UpdateWheelSimulation = function(self, SimulateWheels)
	self.Settings.SimulateWheels = SimulateWheels
	ReadWrite.Functions.WriteConfig(self)
end

Importer.Data.ImportPacket.LoadModel = function(self)
    local Model = game:GetObjects(getcustomasset and getcustomasset(self.Settings.Data) or "rbxassetid://" .. string.split(self.Settings.Data, "\\")[4])[1]
	Model.PrimaryPart = Model.Engine
    return Model
end

Importer.Data.ImportPacket.PacketValue = function(self, Index, Type)
	self.VehiclePackets[Index] = {
		Index = Index,
		Type = Type
	}
end

Importer.Data.ImportPacket.NewPacketValue = function(self, Data, Value)
	if Data.Type == "number" then
		Value = tonumber(Value)
	elseif Data.Type == "boolean" then
		Value = Value:lower() == "true"
	elseif Data.Type == "table" then
		Value = HttpService:JSONDecode(Value)
	end
	self.VehiclePackets[Data.Index].NewValue = Value
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

	self.Data.Chassis:SetAttribute("Key", self.Data.Key)
	CollectionService:AddTag(self.Data.Chassis, "Overlayed")

	for i,v in next, self.Data.Chassis:GetDescendants() do
		if v:IsA("Decal") or v:IsA("BasePart") or v:IsA("TextLabel") then
			self.Data.ChassisTransparency[v] = v.Transparency
		end
	end

	self.Data.SeatCF = self.Data.Chassis.PrimaryPart.CFrame:ToObjectSpace(self.Data.Chassis.Seat.CFrame)

	local ReplicatedStorageClone = self:LoadModel()

	if not ReplicatedStorageClone:FindFirstChild("Preset") then
		local Model = Instance.new("Model", ReplicatedStorageClone)
		Model.Name = "Preset"
	end

	for i, v in next, ReplicatedStorageClone:GetDescendants() do
		if v:IsA("BasePart") then
			v.CanCollide = true
			v.Anchored = true
		end
		if v:IsA("Weld") then
			v:Destroy()
		end
	end
	for i,v in next, ReplicatedStorageClone:GetChildren() do
		if v.Name == "Thrust" then
			v:Destroy()
		end
		if string.find(v.Name, "Wheel") and v:IsA("Model") then
			v.Rim:Destroy()
			v.Wheel.Anchored = true
			v.Parent = ReplicatedStorageClone.Preset
		end
	end

	local NumberValue = Instance.new("NumberValue", ReplicatedStorageClone)
	NumberValue.Value = 0.7
	NumberValue.Name = "InnerWheelPct"
	ReplicatedStorageClone.Parent = ReplicatedStorage.Resource.Vehicles

	if self.Data.Type == "Cars" then
		self.Data.WheelSize.Wheel = self.Data.Chassis.Preset.WheelFrontLeft.Wheel.Size
		self.Data.WheelSize.Rim = self.Data.Chassis.Preset.WheelFrontLeft.Rim.Size

		local WheelDiff = self.Data.Model.Preset.WheelFrontLeft.Wheel.Position - self.Data.Model.Preset.WheelBackRight.Wheel.Position
		self.Data.Model.PrimaryPart.Position = WheelDiff.Unit * (WheelDiff.Magnitude/2) + self.Data.Model.Preset.WheelBackRight.Wheel.Position

		local CreateRim = function(v)
			local NewRim = self.Data.Chassis.Preset[v.Name].Rim:Clone()
			NewRim.Size = Vector3.new(v.Wheel.Size.X, v.Rim.Size.Y, v.Rim.Size.Z)
			NewRim.CFrame = v.Wheel.CFrame:ToWorldSpace(self.Data.Chassis.Preset[v.Name].Wheel.CFrame:ToObjectSpace(self.Data.Chassis.Preset[v.Name].Rim.CFrame))
			v.Rim:Destroy()
			NewRim.Parent = v
			self.Data.Wheels[v.Name .. "Rim"] = {
				Size = NewRim.Size,
				MeshPart = NewRim
			}
			self.Data.RealWheels[self.Data.Chassis.Preset[v.Name].Rim] = self.Data.Chassis.Preset[v.Name].Rim.Transparency
			table.insert(self.Data.Calculated, v.Rim)
		end

		local CreateWheel = function(v)
			local NewWheel = self.Data.Chassis.Preset[v.Name].Wheel:Clone()
			NewWheel.Size = v.Wheel.Size
			NewWheel.CFrame = v.Rim.CFrame:ToWorldSpace(self.Data.Chassis.Preset[v.Name].Rim.CFrame:ToObjectSpace(self.Data.Chassis.Preset[v.Name].Wheel.CFrame))
			v.Wheel:Destroy()
			NewWheel.Parent = v
			self.Data.Wheels[v.Name .. "Wheel"] = {
				Size = NewWheel.Size,
				MeshPart = NewWheel
			}
			self.Data.RealWheels[self.Data.Chassis.Preset[v.Name].Wheel] = self.Data.Chassis.Preset[v.Name].Wheel.Transparency
			self.Data.LargestWheelSize = NewWheel.Size.Y > self.Data.LargestWheelSize and NewWheel.Size.Y/2 or self.Data.LargestWheelSize
			table.insert(self.Data.Calculated, v.Wheel)
		end

		local UpdateRim = function(v)
			self.Data.Chassis.Preset[v.Name].Rim.Size = self.Data.Wheels[v.Name .. "Rim"].Size
			self.Data.RealWheels[self.Data.Chassis.Preset[v.Name].Rim] = self.Data.Chassis.Preset[v.Name].Rim.Transparency
			local NewRim = self.Data.Chassis.Preset[v.Name].Rim:Clone()
			v.Rim:Destroy()
			NewRim.CanCollide = false
			for index, value in next, NewRim:GetChildren() do
				if value:IsA("Weld") then
					value:Destroy()
				end
			end
			table.insert(self.Data.Calculated, NewRim)
			self.Data.Wheels[v.Name .. "Rim"].MeshPart = NewRim
			NewRim.Parent = v
		end

		for i, v in next, self.Data.Model.Preset:GetChildren() do
			if string.find(v.Name, "Wheel") and v:IsA("Model") then
				CreateRim(v)
				CreateWheel(v)

				self.Data.RelativeWheels[v.Name] = {
					Rim = self.Data.Model.PrimaryPart.CFrame:ToObjectSpace(v.Rim.CFrame),
					Wheel = self.Data.Model.PrimaryPart.CFrame:ToObjectSpace(v.Wheel.CFrame),
				}

				local Thrust, Connection = self.Data.Chassis.Preset[v.Name].Thrust
				self.Data.RelativeThrust[Thrust] = self.Data.Chassis.PrimaryPart.CFrame:ToObjectSpace(Thrust.CFrame)
				Connection = self.Data.Chassis.Preset[v.Name].DescendantAdded:Connect(function(descendant)
					if not self.Data.Model.Parent then
						return Connection:Disconnect()
					end
					UpdateRim(v)
				end)
			end
		end

		for i,v in next, self.Data.Model.Model:GetChildren() do
			if v.Name == "Nitrous" then
				table.insert(self.Data.PropertyChanges.Nitrous, v)
			end
			if v.Name == "Headlights" then
				table.insert(self.Data.PropertyChanges.Headlights, v)
			end
			if v.Name == "Brakelights" then
				table.insert(self.Data.PropertyChanges.Brakelights, v)
			end
		end

		for i,v in next, self.Data.Chassis.Model:GetChildren() do
			if v.Name == "Nitrous" then
				v.Fire.Transparency = NumberSequence.new(1)
				v.Smoke.Transparency = NumberSequence.new(1)
				v.Fire:GetPropertyChangedSignal("Enabled"):Connect(function()
					for _, value in next, self.Data.PropertyChanges.Nitrous do
						value.Fire.Enabled = v.Fire.Enabled
					end
				end)
				v.Smoke:GetPropertyChangedSignal("Enabled"):Connect(function()
					for _, value in next, self.Data.PropertyChanges.Nitrous do
						value.Smoke.Enabled = v.Smoke.Enabled
					end
				end)
			end
			if v.Name == "Headlights" then
				v:GetPropertyChangedSignal("Material"):Connect(function()
					for _, value in next, self.Data.PropertyChanges.Headlights do
						value.Material = self.Data.Chassis.Model.Headlights.Material
					end
				end)
			end
			if v.Name == "Brakelights" then
				v:GetPropertyChangedSignal("Material"):Connect(function()
					for _, value in next, self.Data.PropertyChanges.Brakelights do
						value.Material = self.Data.Chassis.Model.Brakelights.Material
					end
				end)
			end
		end

		self.Data.Destroy = function()
			self.Data.Update:Disconnect()
			for i,v in next, self.Data.Connections.Misc do
				v:Disconnect()
			end
			RunService.Heartbeat:Wait()
			if self.Data.Chassis.Parent then
				self.Data.Chassis:SetAttribute("Key", nil)
				CollectionService:RemoveTag(self.Data.Chassis, "Overlayed")
				for i, v in next, self.Data.Model.Preset:GetChildren() do
					if string.find(v.Name, "Wheel") and v:IsA("Model") then
						local Thrust = self.Data.Chassis.Preset[v.Name].Thrust
						local ThrustCF = self.Data.Chassis.PrimaryPart.CFrame:ToWorldSpace(self.Data.RelativeThrust[Thrust])
						Thrust.Position = ThrustCF.Position
						self.Data.Chassis.Preset[v.Name].Rim.Size = self.Data.WheelSize.Rim
						self.Data.Chassis.Preset[v.Name].Wheel.Size = self.Data.WheelSize.Wheel
					end
				end
				for i,v in next, self.Data.ChassisTransparency do
					i.Transparency = v
				end
				for i,v in next, self.Data.Chassis.Model:GetChildren() do
					if v.Name == "Nitrous" then
						v.Fire.Transparency = self.Data.Model.Model.Nitrous.Fire.Transparency
						v.Smoke.Transparency = self.Data.Model.Model.Nitrous.Smoke.Transparency
					end
				end
				self.Data.Chassis.Seat.Weld.C0 = self.Data.Chassis.PrimaryPart.CFrame:ToWorldSpace(self.Data.SeatCF):Inverse() * self.Data.Chassis.PrimaryPart.CFrame
			end
			self.Data.Model:Destroy()
			self.Data.Button.Destroy()
			Importer.Data.Packets[self.Data.Key] = nil
			if not Workspace.CurrentCamera.CameraSubject.Parent then
				Workspace.CurrentCamera.CameraSubject = self.Data.Chassis.Parent and self.Data.Chassis.Camera or Players.LocalPlayer.Character.Humanoid
			end
		end
	elseif self.Data.Type == "Helis" then
		if self.Data.Chassis.Model:FindFirstChild("TopDisc") then
			table.insert(self.Data.Connections.Discs, self.Data.Chassis.Model.TopDisc:GetPropertyChangedSignal("Transparency"):Connect(function()
				self.Data.Chassis.Model.TopDisc.Transparency = 1
			end))
		end
		if self.Data.Chassis.Model:FindFirstChild("TailDisc") then
			table.insert(self.Data.Connections.Discs, self.Data.Chassis.Model.TailDisc:GetPropertyChangedSignal("Transparency"):Connect(function()
				self.Data.Chassis.Model.TailDisc.Transparency = 1
			end))
		end

		if self.Data.Model.Preset:FindFirstChild("DoorRight") then
			for i,v in next, self.Data.Model.Preset.DoorRight:GetDescendants() do
				table.insert(self.Data.Calculated, v)
			end
		end
		if self.Data.Model.Preset:FindFirstChild("DoorLeft") and self.Data.Chassis.Preset:FindFirstChild("DoorLeft") then
			for i,v in next, self.Data.Model.Preset.DoorLeft:GetDescendants() do
				table.insert(self.Data.Calculated, v)
			end
		end

		self.Data.Destroy = function()
			self.Data.Update:Disconnect()
			RunService.Heartbeat:Wait()
			if self.Data.Chassis.Parent then
				self.Data.Chassis:SetAttribute("Key", nil)
				CollectionService:RemoveTag(self.Data.Chassis, "Overlayed")
				for i,v in next, self.Data.ChassisTransparency do
					i.Transparency = v
				end
				self.Data.Chassis.Seat.Weld.C0 = self.Data.Chassis.PrimaryPart.CFrame:ToWorldSpace(self.Data.SeatCF):Inverse() * self.Data.Chassis.PrimaryPart.CFrame
			end
			for i,v in next, self.Data.Connections.Misc do
				v:Disconnect()
			end
			for i,v in next, self.Data.Connections.Discs do
				v:Disconnect()
			end
			self.Data.Model:Destroy()
			self.Data.Button.Destroy()
			Importer.Data.Packets[self.Data.Key] = nil
			if not Workspace.CurrentCamera.CameraSubject.Parent then
				Workspace.CurrentCamera.CameraSubject = self.Data.Chassis.Parent and self.Data.Chassis.Camera or Players.LocalPlayer.Character.Humanoid
			end
		end
	end

	for i, v in next, self.Data.Model:GetDescendants() do
		if v:IsA("Weld") then
			v:Destroy()
		end
		if v:IsA("BasePart") then
			v.Anchored = v == self.Data.Model.PrimaryPart
			if v ~= self.Data.Model.PrimaryPart and not table.find(self.Data.Calculated, v) then
				self.Data.LatchCFrames[v] = self.Data.Model.PrimaryPart.CFrame:ToObjectSpace(v.CFrame)
				local Weld = Instance.new("Weld", v)
				Weld.Part0 = self.Data.Model.PrimaryPart
				Weld.Part1 = v
				Weld.C1 = self.Data.LatchCFrames[v]:Inverse()
			end
		end
	end

	Customization.Functions.ConnectModel(self)

	self.Data.Model.Parent = Workspace

	self.Data.Model.PrimaryPart.CFrame = self.Data.Chassis.PrimaryPart.CFrame + Vector3.new(0, self.Settings.Height, 0)
	self.Data.Model.Seat.CFrame = self.Data.Model.PrimaryPart.CFrame:ToWorldSpace(self.Data.LatchCFrames[self.Data.Model.Seat])

	self.Data.Update = RunService.Heartbeat:Connect(function()
		self:Update()
	end)

	Workspace.Vehicles.DescendantRemoving:Connect(function(descendant)
		if descendant == self.Data.Chassis then
			self.Data.Destroy()
		end
	end)

	if Workspace.CurrentCamera.CameraSubject:IsDescendantOf(Workspace.Vehicles) and CollectionService:HasTag(Workspace.CurrentCamera.CameraSubject.Parent, "Overlayed") then
		Workspace.CurrentCamera.CameraSubject = Importer.Data.Packets[Workspace.CurrentCamera.CameraSubject.Parent:GetAttribute("Key")].Data.Model.Camera
	end

	return "Config initialized", Vector2.new(0, 900)
end

Importer.Data.ImportPacket.UpdateTransparency = function(self)
	self.Data.DescendantData[self.Data.Chassis] = self.Data.Chassis:GetDescendants()
	for i, v in next, self.Data.DescendantData[self.Data.Chassis] do
		if (v:IsA("Decal") or v:IsA("BasePart") or v:IsA("TextLabel")) and not (self.Data.Type == "Cars" and self.WheelDescendant(self.Data.RealWheels, v)) then
			v.Transparency = 1
		end
	end
end

Importer.Data.ImportPacket.UpdateACW = function(self)
	self.Data.DescendantData[self.Data.Model] = self.Data.Model:GetDescendants()
	for i, v in next, self.Data.DescendantData[self.Data.Model] do
		if v:IsA("BasePart") then
			v.CanCollide = false
			v.Anchored = v == self.Data.Model.PrimaryPart
		end
	end
end

Importer.Data.ImportPacket.UpdateWheelParts = function(self)
	self.Data.ChildData[self.Data.Model.Preset] = {}
	for i,v in next, self.Data.Model.Preset:GetChildren() do
		if string.find(v.Name, "Wheel") and v:IsA("Model") then
			table.insert(self.Data.ChildData[self.Data.Model.Preset], v)
		end
	end
end

Importer.Data.ImportPacket.Update = function(self)
	local Packet = Importer.Data.Vehicle.GetLocalVehiclePacket()

	local HasPlayer = Packet and Packet.Model == self.Data.Chassis

	self.Data.Model.PrimaryPart.CFrame = self.Data.Chassis.PrimaryPart.CFrame + Vector3.new(0, self.Settings.Height - (self.Data.Type == "Cars" and HasPlayer and not self.Settings.SimulateWheels and self.Data.LargestWheelSize or 0), 0)

	if not self.Data.DescendantData[self.Data.Chassis] then
		self:UpdateTransparency()
		table.insert(self.Data.Connections.Misc, self.Data.Chassis.DescendantAdded:Connect(function(descendant)
			self:UpdateTransparency()
		end))
	end

	if not self.Data.DescendantData[self.Data.Model] then
		self:UpdateACW()
		table.insert(self.Data.Connections.Misc, self.Data.Model.DescendantAdded:Connect(function(descendant)
			self:UpdateACW()
		end))
	end

	if not self.Data.ChildData[self.Data.Model] then
		self:UpdateWheelParts()
		table.insert(self.Data.Connections.Misc, self.Data.Model.ChildAdded:Connect(function(descendant)
			self:UpdateWheelParts()
		end))
	end

	self.Data.Chassis.Seat.Weld.C0 = self.Data.Model.Seat.CFrame:Inverse() * self.Data.Chassis.PrimaryPart.CFrame

	local MeshModel = self.Data.Model.Model

	if self.Data.Type == "Cars" then
		for i,v in next, self.Data.Wheels do
			if not self.Data.ChildData[v.MeshPart] then
				self.Data.ChildData[v.MeshPart] = v.MeshPart:GetChildren() --cba to fix this rn tbh
				v.MeshPart.ChildAdded:Connect(function(child)
					self.Data.ChildData[v.MeshPart] = v.MeshPart:GetChildren()
				end)
				v.MeshPart.ChildRemoved:Connect(function(child)
					self.Data.ChildData[v.MeshPart] = v.MeshPart:GetChildren()
				end)
			end
			for index, value in next, self.Data.ChildData[v.MeshPart] do
				if value:IsA("Decal") then
					value.Transparency = HasPlayer and not self.Settings.SimulateWheels and 0 or 1
				end
			end
			v.MeshPart.Transparency = HasPlayer and not self.Settings.SimulateWheels and 1 or 0
		end
		for i,v in next, self.Data.RealWheels do
			if not self.Data.ChildData[i] then
				self.Data.ChildData[i] = i:GetChildren()
				i.ChildAdded:Connect(function(child)
					self.Data.ChildData[i] = i:GetChildren()
				end)
				i.ChildRemoved:Connect(function(child)
					self.Data.ChildData[i] = i:GetChildren()
				end)
			end
			for index, value in next, self.Data.ChildData[i] do
				if value:IsA("Decal") then
					value.Transparency = HasPlayer and not self.Settings.SimulateWheels and 0 or 1
				end
			end
			i.Transparency = HasPlayer and not self.Settings.SimulateWheels and 0 or 1
		end
		if self.Data.Model:FindFirstChild("Spoiler") and self.Data.Chassis:FindFirstChild("Spoiler") then
			self.Data.Model.Spoiler.CFrame = CFrame.lookAt(self.Data.Model.Spoiler.Position, self.Data.Model.Spoiler.Position + self.Data.Chassis.Spoiler.CFrame.LookVector)
		end
		if self.Data.Chassis.Model:FindFirstChild("SteeringWheel") then
			MeshModel.SteeringWheel.Orientation = Vector3.new(MeshModel.SteeringWheel.Orientation.X, MeshModel.SteeringWheel.Orientation.Y, self.Data.Chassis.Model.SteeringWheel.Orientation.Z)
		end
		for i, v in next, self.Data.ChildData[self.Data.Model.Preset] do
			local Thrust = self.Data.Chassis.Preset[v.Name].Thrust
			local ThrustCF = self.Data.Chassis.PrimaryPart.CFrame:ToWorldSpace(self.Data.RelativeThrust[Thrust])
			local WorldCF = self.Data.Chassis.PrimaryPart.CFrame:ToWorldSpace(self.Data.RelativeWheels[v.Name].Wheel)
			Thrust.Position = HasPlayer and not self.Settings.SimulateWheels and Vector3.new(WorldCF.X, ThrustCF.Position.Y - self.Data.Model.Preset[v.Name].Wheel.Size.Y/2, WorldCF.Z) or ThrustCF.Position

			local RimCFrame, RelativeRim = table.pack(self.Data.Chassis.Preset[v.Name].Rim.CFrame:GetComponents()), self.Data.Model.PrimaryPart.CFrame:ToWorldSpace(self.Data.RelativeWheels[v.Name].Rim)
			local WheelCFrame, RelativeWheel = table.pack(self.Data.Chassis.Preset[v.Name].Wheel.CFrame:GetComponents()), self.Data.Model.PrimaryPart.CFrame:ToWorldSpace(self.Data.RelativeWheels[v.Name].Wheel)

			RimCFrame[1] = RelativeRim.X
			RimCFrame[3] = RelativeRim.Z
			WheelCFrame[1] = RelativeWheel.X
			WheelCFrame[3] = RelativeWheel.Z

			v.Rim.CFrame = CFrame.new(table.unpack(RimCFrame))
			self.Data.Chassis.Preset[v.Name].Rim.Size = v.Rim.Size
			v.Wheel.CFrame = CFrame.new(table.unpack(WheelCFrame))
			self.Data.Chassis.Preset[v.Name].Wheel.Size = v.Wheel.Size
		end
	elseif self.Data.Type == "Helis" then
		if self.Data.Model.Preset:FindFirstChild("TailRotor") and self.Data.Chassis.Preset:FindFirstChild("TailRotor") then
			self.Data.Model.Preset.TailRotor.Orientation = self.Data.Chassis.Preset.TailRotor.Orientation
		end
		if self.Data.Model.Preset:FindFirstChild("TopRotor") and self.Data.Chassis.Preset:FindFirstChild("TopRotor") then
			self.Data.Model.Preset.TopRotor.Orientation = self.Data.Chassis.Preset.TopRotor.Orientation
		end
		if self.Data.Model.Preset:FindFirstChild("Spotlight") and self.Data.Chassis.Preset:FindFirstChild("Spotlight") then
			self.Data.Model.Preset.Spotlight.Model.Light.Material = self.Data.Chassis.Preset.Spotlight.Model.Light.Material
		end
	end

	if self.Data.Model.Preset:FindFirstChild("DoorRight") and self.Data.Chassis.Preset:FindFirstChild("DoorRight") then

	end
	if self.Data.Model.Preset:FindFirstChild("DoorLeft") and self.Data.Chassis.Preset:FindFirstChild("DoorLeft") then

	end

	if Packet and Packet.Model == self.Data.Chassis then
		for i, v in next, self.VehiclePackets do
			if not v.NewValue then
				continue
			end
			local Indexs, NewIndex = string.split(v.Index, "."), Packet or {}
			Indexs[1] = nil
			for index, value in next, Indexs do
				if index == #Indexs then
					break
				end
				if not NewIndex[value] then
					NewIndex[value] = {}
				end
				NewIndex = NewIndex[value]
			end
			print(Indexs[#Indexs], v.NewValue)
			NewIndex[Indexs[#Indexs]] = v.NewValue
		end
	end
end

Importer.Functions.CreateNewSave = function(Data)
	local Packet = Importer.Data.ImportPacket:NewPacket(Data)

	return Packet
end

return Importer