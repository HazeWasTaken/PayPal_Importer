Vehicle_Importer = {['Modules/ImportChecks/VehicleChecks.lua'] = function()
local VehicleChecks, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
		Checks = {
			WheelFrontLeft = {
				Wheel = {},
				Rim = {}
			},
			WheelFrontRight = {
				Wheel = {},
				Rim = {}
			},
			WheelBackLeft = {
				Wheel = {},
				Rim = {}
			},
			WheelBackRight = {
				Wheel = {},
				Rim = {},
			},
			Model = {
				SteeringWheel = {},
				Nitrous = {},
			},
			Camera = {},
			InsideCamera = {},
			Engine = {},
			Seat = {},
			Steer = {}
		}
	},
	Functions = {}
}, {}

local LMeta = {
	__index = function(self, index)
		return Env[index]
	end
}

local MMeta = {
	__index = function(self, index)
		return Env["M" .. index]
	end
}

setmetatable(VehicleChecks.Functions, LMeta)
setmetatable(VehicleChecks.Module.Functions, MMeta)

Env.CheckTable = function(Output, Check, Model, Path)
	for i, v in next, Check do
		if Model:FindFirstChild(i) then
			VehicleChecks.Functions.CheckTable(Output, v, Model:FindFirstChild(i), Path .."." .. i)
		else
			Output.String = Output.String .. "\n" .. Path .."." .. i .. " Not Found"
		end
	end
end

Env.MRunCheck = function(Data)
	local Success, Response = pcall(function()
		return game:GetObjects(getcustomasset and getcustomasset(Data) or "rbxassetid://" .. Data)[1]
	end)

	if not Success or not Response then
		return (Response or "Failed to load model"), Vector2.new(0, 600)
	end

	local Output = {
		String = ""
	}

	VehicleChecks.Functions.CheckTable(Output, VehicleChecks.Data.Checks, Response, "Model")

    Response:Destroy()

	return Output.String:len() > 0 and Output.String or "Model is valid", Output.String:len() > 0 and Vector2.new(0, 600) or Vector2.new(0, 900)
end

return VehicleChecks.Module
end,
['Modules/Importer/Customization.lua'] = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Customization, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
        Spoiler = require(ReplicatedStorage.Game.Garage.StoreData.Spoiler),
        SpoilerCustomize = require(ReplicatedStorage.Game.Garage.Customize.Spoiler),
    },
	Functions = {}
}, {}

local LMeta = {
	__index = function(self, index)
		return Env[index]
	end
}

local MMeta = {
	__index = function(self, index)
		return Env["M" .. index]
	end
}

setmetatable(Customization.Functions, LMeta)
setmetatable(Customization.Module.Functions, MMeta)

Env.GetSpoilerName = function(MeshId)
    for i,v in next, ReplicatedStorage.Resource.Spoiler:GetChildren() do
        if v.MeshId == MeshId then
            return v.Name
        end
    end
end

Env.BodyColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
    for i, v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Body" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Env.SecondBodyColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "SecondBody" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Env.SeatColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Seats" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Env.HeadlightsColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Headlights" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Env.InteriorMainColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Interior" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Env.InteriorDetailColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "SecondInterior" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Env.WindowColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Windows" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Env.WindowTint = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Windows" and Item < 1 then
            v.Transparency = Item
        end
    end
end

Env.SpoilerColor = function(Packet, Item)
    local SpoilerPart = Packet.Data.Model:FindFirstChild("SpoilerPart")
    if SpoilerPart then
        Packet.Data.Model.SpoilerPart.Color = Item.Color
        Packet.Data.Model.SpoilerPart.Material = Item.Material
        Packet.Data.Model.SpoilerPart.Reflectance = Item.Reflectance
    end
end

Env.Spoiler = function(Packet, Spoiler)
    local SpoilerName, SpoilerData = Customization.Functions.GetSpoilerName(Spoiler.MeshId)
    for i,v in next, Customization.Data.Spoiler.Items do
        if v.Name == SpoilerName then
            SpoilerData = v
        end
    end
    Packet.Data.Model.DescendantAdded:Connect(function(descendant)
        if descendant.Name == "SpoilerPart" then
            Packet.Data.LatchCFrames[descendant] = Packet.Data.Model.PrimaryPart.CFrame:ToObjectSpace(descendant.CFrame)
        end
    end)
    Customization.Data.SpoilerCustomize(SpoilerData, {
        Model = Packet.Data.Model
    })
end

Env.MConnectModel = function(Packet)
    Packet.Data.Chassis.DescendantRemoving:Connect(function(RemovedDescendant)
        if RemovedDescendant.Name == "SpoilerPart" then
            RunService.Heartbeat:Wait()
            local SpoilerPart = Packet.Data.Model:FindFirstChild("SpoilerPart")
            if not Packet.Data.Chassis:FindFirstChild("SpoilerPart") and SpoilerPart then
                SpoilerPart:Destroy()
            end
        end
    end)
    Packet.Data.Chassis.DescendantAdded:Connect(function(descendant)
        if descendant.Name == "SpoilerPart" then
            for i,v in next, Packet.Data.Connections do
                v:Disconnect()
                Packet.Data.Connections[i] = nil
            end
            Customization.Functions.Spoiler(Packet, descendant)
            Customization.Functions.SpoilerColor(Packet, descendant)
            table.insert(Packet.Data.Connections, descendant:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, descendant)
            end))
            table.insert(Packet.Data.Connections, descendant:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, descendant)
            end))
            table.insert(Packet.Data.Connections, descendant:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, descendant)
            end))
        end
    end)
	for i,v in next, Packet.Data.Chassis.Model:GetDescendants() do
        if v.Name == "SpoilerPart" then
            Customization.Functions.Spoiler(Packet, v)
            table.insert(Packet.Data.Connections, v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, v)
            end))
            table.insert(Packet.Data.Connections, v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, v)
            end))
            table.insert(Packet.Data.Connections, v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, v)
            end))
        end
        if v.Name == "Windows" then
            Customization.Functions.WindowTint(Packet, v.Transparency)
            Customization.Functions.WindowColor(Packet, v)
            v:GetPropertyChangedSignal("Transparency"):Connect(function()
                Customization.Functions.WindowTint(Packet, v.Transparency)
            end)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.WindowColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.WindowColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.WindowColor(Packet, v)
            end)
        end
        if v.Name == "SecondInterior" then
            Customization.Functions.InteriorDetailColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.InteriorDetailColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.InteriorDetailColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.InteriorDetailColor(Packet, v)
            end)
        end
        if v.Name == "Interior" then
            Customization.Functions.InteriorMainColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.InteriorMainColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.InteriorMainColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.InteriorMainColor(Packet, v)
            end)
        end
        if v.Name == "Headlights" then
            Customization.Functions.HeadlightsColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.HeadlightsColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.HeadlightsColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.HeadlightsColor(Packet, v)
            end)
        end
        if v.Name == "Seats" then
            Customization.Functions.SeatColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.SeatColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.SeatColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.SeatColor(Packet, v)
            end)
        end
        if v.Name == "SecondBody" then
            Customization.Functions.SecondBodyColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.SecondBodyColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.SecondBodyColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.SecondBodyColor(Packet, v)
            end)
        end
        if v.Name == "Body" then
            Customization.Functions.BodyColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.BodyColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.BodyColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.BodyColor(Packet, v)
            end)
        end
    end
end

return Customization.Module
end,
['Modules/Importer/Importer.lua'] = function()
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local ReadWrite = import("Modules/ReadWrite/ReadWrite.lua")
local Customization = import("Modules/Importer/Customization.lua")

local Importer, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
		AlexChassis = require(ReplicatedStorage.Module.AlexChassis),
        Vehicle = require(ReplicatedStorage.Game.Vehicle),
        ImportPacket = {},
		Packets = {}
    },
	Functions = {
		getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
    }
}, {}

local LMeta = {
	__index = function(self, index)
		return Env[index]
	end
}

local MMeta = {
	__index = function(self, index)
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

Env.WheelDescendant = function(Wheels, BasePart)
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

	local Packet = {
		Settings = {
			Name = Data.Name,
			Data = Data.Data,
			Model = nil,
			Height = Data.Height
		},
		VehiclePackets = {},
		Data = {
			Key = Data.Key or math.ceil(os.clock() + math.random(1, 200)),
			Initialized = false,
			Calculated = {},
			LatchCFrames = {},
			ChassisTransparency = {},
			Wheels = {},
			WheelSize = {},
			RealWheels = {},
			RelativeWheels = {},
			RelativeThrust = {},
			Connections = {},
			SeatCF = nil,
			RelativeSteeringWheel = nil,
			LargestWheelSize = 0
		}
	}

	setmetatable(Packet, {
		__index = self
	})

	setmetatable(Packet.Settings, {
		__newindex = function(table, key, value)
			rawset(table, key, value)
			ReadWrite.Functions.WriteConfig(Packet)
		end
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
end

Importer.Data.ImportPacket.LoadModel = function(self)
    local Model = game:GetObjects(getcustomasset and getcustomasset(self.Settings.Data) or "rbxassetid://" .. self.Settings.Data)[1]

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
		Value = Value:lower() == "true" or false
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

	self.Data.WheelSize.Wheel = self.Data.Chassis.WheelFrontLeft.Wheel.Size
	self.Data.WheelSize.Rim = self.Data.Chassis.WheelFrontLeft.Rim.Size

	local ReplicatedStorageClone = self:LoadModel()

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

	local WheelDiff = self.Data.Model.WheelFrontLeft.Wheel.Position - self.Data.Model.WheelBackRight.Wheel.Position
	self.Data.Model.PrimaryPart.Position = WheelDiff.Unit * (WheelDiff.Magnitude/2) + self.Data.Model.WheelBackRight.Wheel.Position

	local CreateRim = function(v)
		local NewRim = self.Data.Chassis[v.Name].Rim:Clone()
		NewRim.Size = Vector3.new(v.Wheel.Size.X, v.Rim.Size.Y, v.Rim.Size.Z)
		NewRim.CFrame = v.Wheel.CFrame:ToWorldSpace(self.Data.Chassis[v.Name].Wheel.CFrame:ToObjectSpace(self.Data.Chassis[v.Name].Rim.CFrame))
		v.Rim:Destroy()
		NewRim.Parent = v
		self.Data.Wheels[v.Name .. "Rim"] = {
			Size = NewRim.Size,
			MeshPart = NewRim
		}
		self.Data.RealWheels[self.Data.Chassis[v.Name].Rim] = self.Data.Chassis[v.Name].Rim.Transparency
		table.insert(self.Data.Calculated, v.Rim)
	end

	local CreateWheel = function(v)
		local NewWheel = self.Data.Chassis[v.Name].Wheel:Clone()
		NewWheel.Size = v.Wheel.Size
		NewWheel.CFrame = v.Rim.CFrame:ToWorldSpace(self.Data.Chassis[v.Name].Rim.CFrame:ToObjectSpace(self.Data.Chassis[v.Name].Wheel.CFrame))
		v.Wheel:Destroy()
		NewWheel.Parent = v
		self.Data.Wheels[v.Name .. "Wheel"] = {
			Size = NewWheel.Size,
			MeshPart = NewWheel
		}
		self.Data.RealWheels[self.Data.Chassis[v.Name].Wheel] = self.Data.Chassis[v.Name].Wheel.Transparency
		self.Data.LargestWheelSize = NewWheel.Size.Y > self.Data.LargestWheelSize and NewWheel.Size.Y/2 or self.Data.LargestWheelSize
		table.insert(self.Data.Calculated, v.Wheel)
	end

	local UpdateRim = function(v)
		self.Data.Chassis[v.Name].Rim.Size = self.Data.Wheels[v.Name .. "Rim"].Size
		self.Data.RealWheels[self.Data.Chassis[v.Name].Rim] = self.Data.Chassis[v.Name].Rim.Transparency
		local NewRim = self.Data.Chassis[v.Name].Rim:Clone()
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

	for i, v in next, self.Data.Model:GetChildren() do
		if string.find(v.Name, "Wheel") and v:IsA("Model") then
			CreateRim(v)
			CreateWheel(v)

			self.Data.RelativeWheels[v.Name] = {
				Rim = self.Data.Model.PrimaryPart.CFrame:ToObjectSpace(v.Rim.CFrame),
				Wheel = self.Data.Model.PrimaryPart.CFrame:ToObjectSpace(v.Wheel.CFrame),
			}

			local Thrust, Connection = Importer.Functions.GetNearestThrust(self.Data.Chassis[v.Name])
			self.Data.RelativeThrust[Thrust] = self.Data.Chassis.PrimaryPart.CFrame:ToObjectSpace(Thrust.CFrame)
			Connection = self.Data.Chassis[v.Name].DescendantAdded:Connect(function(descendant)
                if not self.Data.Model.Parent then
                    return Connection:Disconnect()
                end
				UpdateRim(v)
			end)
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

	for i,v in next, self.Data.Chassis.Model:GetChildren() do
		if v.Name == "Nitrous" then
			v.Fire.Transparency = NumberSequence.new(1)
			v.Smoke.Transparency = NumberSequence.new(1)
		end
	end

	Customization.Functions.ConnectModel(self)

	self.Data.Model.Parent = Workspace

	self.Data.Model.PrimaryPart.CFrame = self.Data.Chassis.PrimaryPart.CFrame + Vector3.new(0, self.Settings.Height, 0)
	self.Data.Model.Seat.CFrame = self.Data.Model.PrimaryPart.CFrame:ToWorldSpace(self.Data.LatchCFrames[self.Data.Model.Seat])

	local Update = RunService.Heartbeat:Connect(function()
		self:Update()
	end)

	self.Data.Destroy = function()
		Update:Disconnect()
		if self.Data.Chassis.Parent then
			self.Data.Chassis:SetAttribute("Key", nil)
			CollectionService:RemoveTag(self.Data.Chassis, "Overlayed")
			for i, v in next, self.Data.Model:GetChildren() do
				if string.find(v.Name, "Wheel") and v:IsA("Model") then
					local Thrust = Importer.Functions.GetNearestThrust(self.Data.Chassis[v.Name])
					local ThrustCF = self.Data.Chassis.PrimaryPart.CFrame:ToWorldSpace(self.Data.RelativeThrust[Thrust])
					Thrust.Position = ThrustCF.Position
					self.Data.Chassis[v.Name].Rim.Size = self.Data.WheelSize.Rim
					self.Data.Chassis[v.Name].Wheel.Size = self.Data.WheelSize.Wheel
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

Importer.Data.ImportPacket.Update = function(self)
	local Packet = Importer.Data.Vehicle.GetLocalVehiclePacket()

	local HasPlayer = self.Data.Chassis:FindFirstChild("Seat") and self.Data.Chassis.Seat:FindFirstChild("PlayerName") and self.Data.Chassis.Seat.PlayerName.Value == Players.LocalPlayer.Name

	for i, v in next, self.Data.Chassis:GetDescendants() do
		if (v:IsA("Decal") or v:IsA("BasePart") or v:IsA("TextLabel")) and not Importer.Functions.WheelDescendant(self.Data.RealWheels, v) then
			v.Transparency = 1
		end
	end
	for i,v in next, self.Data.Wheels do
		for index, value in next, v.MeshPart:GetChildren() do
			if value:IsA("Decal") then
				value.Transparency = HasPlayer and 0 or 1
			end
		end
		v.MeshPart.Transparency = HasPlayer and 1 or 0
	end
	for i,v in next, self.Data.RealWheels do
		for index, value in next, i:GetChildren() do
			if value:IsA("Decal") then
				value.Transparency = HasPlayer and 0 or 1
			end
		end
		i.Transparency = HasPlayer and 0 or 1
	end
	for i, v in next, self.Data.Model:GetDescendants() do
		if v:IsA("Weld") then
			v:Destroy()
		end
		if v:IsA("BasePart") then
			v.CanCollide = false
			v.Anchored = true
		end
	end

	self.Data.Model.PrimaryPart.CFrame = self.Data.Chassis.PrimaryPart.CFrame  + Vector3.new(0, self.Settings.Height - (HasPlayer and self.Data.LargestWheelSize or 0), 0)
	if self.Data.Model:FindFirstChild("Spoiler") then
		self.Data.Model.Spoiler.CFrame = CFrame.lookAt(self.Data.Model.Spoiler.Position, self.Data.Model.Spoiler.Position + self.Data.Chassis.Spoiler.CFrame.LookVector)
	end

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

	for i,v in next, self.Data.Model.Model:GetChildren() do
		if v.Name == "Brakelights" then
			v.Material = self.Data.Chassis.Model.Brakelights.Material
		end
		if v.Name == "Headlights" then
			v.Material = self.Data.Chassis.Model.Headlights.Material
		end
		if v.Name == "Nitrous" then
			v.Fire.Enabled = self.Data.Chassis.Model.Nitrous.Fire.Enabled
			v.Smoke.Enabled = self.Data.Chassis.Model.Nitrous.Smoke.Enabled
		end
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
			NewIndex[Indexs[#Indexs]] = v.NewValue
		end
	end
end

Env.MCreateNewSave = function(Data)
	local Packet = Importer.Data.ImportPacket:NewPacket(Data)

	return Packet
end

return Importer.Module
end,
['Modules/Initialize/Initialize.lua'] = function()
local Initialize, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {},
	Functions = {}
}, {}

local LMeta = {
	__index = function(self, index)
		return Env[index]
	end
}

local MMeta = {
	__index = function(self, index)
		return Env["M" .. index]
	end
}

setmetatable(Initialize.Functions, LMeta)
setmetatable(Initialize.Module.Functions, MMeta)

for i, v in next, getgc(true) do
    if type(v) == "table" and rawget(v, "attemptEquipGarageItem") then
        Env.MSelectItem = v.attemptEquipGarageItem
    end
end

return Initialize.Module
end,
['Modules/Packet/Packet.lua'] = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packet, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
        Vehicle = require(ReplicatedStorage.Game.Vehicle),
        PrevData = {}
    },
	Functions = {}
}, {}

local LMeta = {
	__index = function(self, index)
		return Env[index]
	end
}

local MMeta = {
	__index = function(self, index)
		return Env["M" .. index]
	end
}

setmetatable(Packet.Functions, LMeta)
setmetatable(Packet.Module.Functions, MMeta)

Env.ReadTable = function(Data, PacketData, Original, Dir, Count)
    for i, v in next, PacketData do
        local Type = typeof(v)
        if Type == "table" then
            table.insert(Data, {
                Index = Original .. tostring(i) .. "open",
                Parent = Original,
                Dir = Dir .. "." .. tostring(i),
                Name = string.rep("		", Count) .. tostring(i),
                Type = Type,
                Value = "{...}"
            })
            Packet.Functions.ReadTable(Data, v, Original .. tostring(i) .. "open", Dir .. "." .. tostring(i),Count + 1)
            table.insert(Data, {
                Index = Original .. tostring(i) .. "close",
                Parent = Original .. tostring(i) .. "open",
                Dir = Dir .. "." .. tostring(i),
                Name = string.rep("		", Count) ..  "}",
                Type = Type,
                Value = tostring(i)
            })
        else
            table.insert(Data, {
                Index = Original .. tostring(i),
                Parent = Original,
                Dir = Dir .. "." .. tostring(i),
                Name = string.rep("		", Count) .. tostring(i),
                Type = Type,
                Value = tostring(v) .. " (" .. (Type == "Instance" and v.ClassName or Type) .. ")"
            })
        end
    end
end

Env.MGetPacketData = function()
    local Data, VehiclePacket = {}, Packet.Data.Vehicle.GetLocalVehiclePacket() or {}

    Packet.Functions.ReadTable(Data, VehiclePacket, "", "Packet", 0)

    return Data
end

return Packet.Module
end,
['Modules/ReadWrite/ReadWrite.lua'] = function()
local HttpService = game:GetService("HttpService")
local ReadWrite, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
		GlobalUi = {
			ConfigList = {},
			Manage = {},
			Settings = {}
		}
	},
	Functions = {}
}, {}

local LMeta = {
	__index = function(self, index)
		return Env[index]
	end
}

local MMeta = {
	__index = function(self, index)
		return Env["M" .. index]
	end
}

setmetatable(ReadWrite.Functions, LMeta)
setmetatable(ReadWrite.Module.Functions, MMeta)

Env.MSetupReadWrite = function()
    if not isfolder("./PayPal") then
        makefolder("./PayPal")
    end
    if not isfolder("./PayPal/Vehicles") then
        makefolder("./PayPal/Vehicles")
    end
    if not isfolder("./PayPal/Configs") then
        makefolder("./PayPal/Configs")
    end
end

Env.MReadVehicles = function()
	local Vehicles = {}
	for i,v in next, listfiles("./PayPal/Vehicles") do
		v = string.gsub(v:gsub([[./PayPal]], "PayPal"), "/", [[\]])
		table.insert(Vehicles, {
			Name = string.gsub(string.split(v, [[\]])[3], ".rbxm", ""),
			Data = v,
			Enter = function() end,
			Leave = function() end
		})
	end
	return Vehicles
end

Env.MReadConfigs = function()
    local Configs = {}
    for i, v in next, listfiles("./PayPal/Configs") do
        table.insert(Configs, HttpService:JSONDecode(readfile(v)))
    end
    return Configs
end

Env.MWriteConfig = function(Config)
	writefile("./PayPal/Configs/" .. Config.Settings.Name .. Config.Data.Key .. ".json", HttpService:JSONEncode({
		Name = Config.Settings.Name,
		Data = Config.Settings.Data,
		Height = Config.Settings.Height,
		Key = Config.Data.Key
	}))
end

return ReadWrite.Module
end,
['Modules/Ui/Library.lua'] = function()
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Mouse = Players.LocalPlayer:GetMouse()

local Library, Env = {
    Module = {
        Functions = {},
        Data = {}
    },
    Data = {},
    Functions = {}
}, {}

local LMeta = {
    __index = function(self, index)
        return Env[index]
    end
}

local MMeta = {
    __index = function(self, index)
        return Env["M" .. index]
    end
}

setmetatable(Library.Functions, LMeta)
setmetatable(Library.Module.Functions, MMeta)

Env.dragify = function(Frame) -- stole from v3rm :kek:
    local dragToggle = nil
    local dragSpeed = .25
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function updateInput(input)
        local Delta = input.Position - dragStart
        local Position =
            UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        TweenService:Create(Frame, TweenInfo.new(dragSpeed), {Position = Position}):Play()
    end

    Frame.InputBegan:Connect(
        function(input)
            if
                (input.UserInputType == Enum.UserInputType.MouseButton1 or
                    input.UserInputType == Enum.UserInputType.Touch)
             then
                dragToggle = true
                dragStart = input.Position
                startPos = Frame.Position
                input.Changed:Connect(
                    function()
                        if (input.UserInputState == Enum.UserInputState.End) then
                            dragToggle = false
                        end
                    end
                )
            end
        end
    )

    Frame.InputChanged:Connect(
        function(input)
            if
                (input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch)
             then
                dragInput = input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if (input == dragInput and dragToggle) then
                updateInput(input)
            end
        end
    )
end

Env.MCreateUi = function(Name)
    local Swift = Instance.new("ScreenGui")
    Swift.Name = "Swift"
    Swift.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Swift.Parent = CoreGui

    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if input.KeyCode == Enum.KeyCode.RightShift then
            Swift.Enabled = not Swift.Enabled
        end
    end)

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 572, 0, 332)
    Frame.Position = UDim2.new(0.2740916, 0, 0.1403888, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.Parent = Swift
    Library.Functions.dragify(Frame)

    local UICorner = Instance.new("UICorner")
    UICorner.Parent = Frame
    UICorner.CornerRadius = UDim.new(0,4)

    local ServerSelectionBg = Instance.new("Frame")
    ServerSelectionBg.Name = "ServerSelectionBg"
    ServerSelectionBg.Size = UDim2.new(0, 44, 0, 310)
    ServerSelectionBg.Position = UDim2.new(0, 0, 0.0662651, 0)
    ServerSelectionBg.BorderSizePixel = 0
    ServerSelectionBg.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    ServerSelectionBg.Parent = Frame

    local UICorner11 = Instance.new("UICorner")
    UICorner11.Parent = ServerSelectionBg

    local RoundHiderTop = Instance.new("Frame")
    RoundHiderTop.Name = "RoundHiderTop"
    RoundHiderTop.Size = UDim2.new(0, 44, 0, 16)
    RoundHiderTop.BorderSizePixel = 0
    RoundHiderTop.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    RoundHiderTop.Parent = ServerSelectionBg

    local RoundHiderRight = Instance.new("Frame")
    RoundHiderRight.Name = "RoundHiderRight"
    RoundHiderRight.Size = UDim2.new(0, 16, 0, 310)
    RoundHiderRight.Position = UDim2.new(0.6363636, 0, 0, 0)
    RoundHiderRight.BorderSizePixel = 0
    RoundHiderRight.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    RoundHiderRight.Parent = ServerSelectionBg

    local ServerSelection = Instance.new("ScrollingFrame")
    ServerSelection.Name = "ServerSelection"
    ServerSelection.Size = UDim2.new(0, 44, 0, 304)
    ServerSelection.BackgroundTransparency = 1
    ServerSelection.Position = UDim2.new(0, 0, 0.0843373, 0)
    ServerSelection.Active = true
    ServerSelection.BorderSizePixel = 0
    ServerSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ServerSelection.CanvasSize = UDim2.new(0, 0, 0, 0)
    ServerSelection.ScrollBarThickness = 3
    ServerSelection.Parent = Frame

    local UIListLayout2 = Instance.new("UIListLayout")
    UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout2.Padding = UDim.new(0, 3)
    UIListLayout2.Parent = ServerSelection

    local MainTitle = Instance.new("TextLabel")
    MainTitle.Name = "MainTitle"
    MainTitle.Size = UDim2.new(0, 558, 0, 22)
    MainTitle.BackgroundTransparency = 1
    MainTitle.Position = UDim2.new(0.0236014, 0, 0, 0)
    MainTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainTitle.FontSize = Enum.FontSize.Size14
    MainTitle.TextSize = 14
    MainTitle.RichText = true
    MainTitle.TextColor3 = Color3.fromRGB(31, 99, 226)
    MainTitle.Text = "<b><i>Pay<font color=\"rgb(12, 150, 255)\">Pal</font> - <font color=\"rgb(255, 255, 255)\">" .. Name .. "</font></i></b>"
    MainTitle.TextWrapped = true
    MainTitle.Font = Enum.Font.SourceSans
    MainTitle.TextWrap = true
    MainTitle.TextXAlignment = Enum.TextXAlignment.Left
    MainTitle.Parent = Frame

    local GuildLibrary = {
        Guilds = {},
        Channels = {},
        Utilities = {},
        Channel_Buttons = {},
    }

    GuildLibrary.CreateGuild = function(Name, Icon, Banner)
        local Guild = {}

        local ServerName = Instance.new("Frame")
        ServerName.Name = "ServerName"
        ServerName.Size = UDim2.new(0, 0, 0, 23)
        ServerName.Position = UDim2.new(0.076, 0, 0.0662651, 0)
        ServerName.BorderSizePixel = 0
        ServerName.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
        ServerName.Parent = Frame
        ServerName.ClipsDescendants = true
        table.insert(GuildLibrary.Guilds, ServerName)
        table.insert(Guild, ServerName)

        local ServerSelected = Instance.new("TextLabel")
        ServerSelected.Name = "ServerSelected"
        ServerSelected.Size = UDim2.new(0, 98, 0, 23)
        ServerSelected.BackgroundTransparency = 1
        ServerSelected.Position = UDim2.new(0.0836759, 0, 0, 0)
        ServerSelected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServerSelected.FontSize = Enum.FontSize.Size12
        ServerSelected.TextSize = 12
        ServerSelected.RichText = true
        ServerSelected.TextColor3 = Color3.fromRGB(255, 255, 255)
        ServerSelected.Text = Name
        ServerSelected.Font = Enum.Font.SourceSansSemibold
        ServerSelected.TextXAlignment = Enum.TextXAlignment.Left
        ServerSelected.Parent = ServerName

        local Server = Instance.new("ImageButton")
        Server.Name = Name
        Server.Size = UDim2.new(0, 34, 0, 34)
        Server.Position = UDim2.new(-0.6363636, 0, 0, 0)
        Server.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
        Server.AutoButtonColor = false
        Server.Parent = ServerSelection
        Server.Image = Icon

        local UICorner12 = Instance.new("UICorner")
        UICorner12.Parent = Server

        local TabSelectionBg = Instance.new("Frame")
        TabSelectionBg.Name = "TabSelectionBg"
        TabSelectionBg.Size = UDim2.new(0, 0, 0, 286)
        TabSelectionBg.Position = UDim2.new(0.076, 0, 0.1355422, 0)
        TabSelectionBg.BorderSizePixel = 0
        TabSelectionBg.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
        TabSelectionBg.Parent = Frame
        table.insert(GuildLibrary.Guilds, TabSelectionBg)
        table.insert(Guild, TabSelectionBg)

        local TabSelection = Instance.new("ScrollingFrame")
        TabSelection.Name = "TabSelection"
        TabSelection.Size = UDim2.new(0, 0, 0, 280)
        TabSelection.BackgroundTransparency = 1
        TabSelection.Position = UDim2.new(0.08, 0, 0.1525125, 0)
        TabSelection.Active = true
        TabSelection.BorderSizePixel = 0
        TabSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabSelection.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabSelection.ScrollBarThickness = 3
        TabSelection.Parent = Frame
        table.insert(GuildLibrary.Guilds, TabSelection)
        table.insert(Guild, TabSelection)

        local UIListLayout3 = Instance.new("UIListLayout")
        UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout3.Padding = UDim.new(0, 3)
        UIListLayout3.Parent = TabSelection

        local ServerBanner = Instance.new("Frame")
        ServerBanner.Name = "ServerBanner"
        ServerBanner.Size = UDim2.new(0, 106, 0, 53)
        ServerBanner.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
        ServerBanner.Parent = TabSelection

        local UICorner13 = Instance.new("UICorner")
        UICorner13.CornerRadius = UDim.new(0, 5)
        UICorner13.Parent = ServerBanner
        UICorner13.CornerRadius = UDim.new(0, 4)

        local VideoFrame = Instance.new("VideoFrame")
        VideoFrame.Name = "VideoFrame"
        VideoFrame.Position = UDim2.new()
        VideoFrame.Size = UDim2.new(1, 0, 1, 0)
        VideoFrame.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
        VideoFrame.Parent = ServerBanner
        VideoFrame.Video = Banner
        VideoFrame.Playing = true
        VideoFrame.Looped = true
        VideoFrame.Volume = 0

        local UICorner14 = Instance.new("UICorner")
        UICorner14.CornerRadius = UDim.new(0, 5)
        UICorner14.Parent = VideoFrame
        UICorner14.CornerRadius = UDim.new(0, 4)

        Server.MouseButton1Down:Connect(function(x, y)
            for i,v in next, GuildLibrary.Guilds do
                TweenService:Create(
                    v,
                    TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
                    {
                        Size = UDim2.new(0, (table.find(Guild, v) and 111 or 0), 0, v.Size.Y.Offset)
                    }
                ):Play()
            end
        end)

        local CategoryLibrary = {}

        CategoryLibrary.CreateCategory = function(Name)
            local Category = Instance.new("Frame")
            Category.Name = "Category"
            Category.Parent = TabSelection
            Category.Size = UDim2.new(0, 106, 0, 14)
            Category.ClipsDescendants = true
            Category.BackgroundTransparency = 1
            Category.Position = UDim2.new(0.0225225, 0, 0.2, 0)
            Category.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 5)
            UICorner.Parent = Category

            local TextChannels = Instance.new("TextButton")
            TextChannels.Name = "TextChannels"
            TextChannels.Size = UDim2.new(0, 106, 0, 14)
            TextChannels.BackgroundTransparency = 1
            TextChannels.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
            TextChannels.AutoButtonColor = false
            TextChannels.FontSize = Enum.FontSize.Size11
            TextChannels.TextSize = 11
            TextChannels.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextChannels.Text = ""
            TextChannels.Font = Enum.Font.Gotham
            TextChannels.Parent = Category

            local UICorner1 = Instance.new("UICorner")
            UICorner1.CornerRadius = UDim.new(0, 5)
            UICorner1.Parent = TextChannels

            local TextChannels_Name = Instance.new("TextLabel")
            TextChannels_Name.Name = "TextChannels_Name"
            TextChannels_Name.Size = UDim2.new(0, 91, 0, 14)
            TextChannels_Name.BackgroundTransparency = 1
            TextChannels_Name.Position = UDim2.new(0.17, 0, 0, 0)
            TextChannels_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextChannels_Name.RichText = true
            TextChannels_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextChannels_Name.Text = "<b>" .. Name .. "</b>"
            TextChannels_Name.Font = Enum.Font.Gotham
            TextChannels_Name.TextXAlignment = Enum.TextXAlignment.Left
            TextChannels_Name.Parent = TextChannels

            local Dropdown = Instance.new("ImageButton")
            Dropdown.Name = "Dropdown"
            Dropdown.ZIndex = 2
            Dropdown.Size = UDim2.new(0, 10, 0, 10)
            Dropdown.Rotation = 0
            Dropdown.BackgroundTransparency = 1
            Dropdown.Position = UDim2.new(0.024, 0, 0.16, 0)
            Dropdown.ImageRectOffset = Vector2.new(444, 844)
            Dropdown.Image = "rbxassetid://3926305904"
            Dropdown.ImageRectSize = Vector2.new(36, 36)
            Dropdown.Parent = TextChannels

            local Dropdown_Content = Instance.new("Frame")
            Dropdown_Content.Name = "Dropdown_Content"
            Dropdown_Content.Size = UDim2.new(0, 106, 0, 0)
            Dropdown_Content.ClipsDescendants = true
            Dropdown_Content.BackgroundTransparency = 1
            Dropdown_Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown_Content.Parent = TextChannels

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 3)
            UIListLayout.Parent = Dropdown_Content

            local UIPadding = Instance.new("UIPadding")
            UIPadding.PaddingTop = UDim.new(0, 16)
            UIPadding.Parent = Dropdown_Content

            local Enabled = false

            TextChannels.MouseButton1Down:Connect(function(x, y)
                Enabled = not Enabled
                TweenService:Create(Dropdown_Content,
                    TweenInfo.new(0.25,
                        Enum.EasingStyle.Exponential,
                        Enum.EasingDirection.InOut
                    ),
                    {
                        Size = UDim2.new(0, 106, 0, Enabled and UIListLayout.AbsoluteContentSize.Y + 21 or 0)
                    }
                ):Play()
                TweenService:Create(Category,
                    TweenInfo.new(0.25,
                        Enum.EasingStyle.Exponential,
                        Enum.EasingDirection.InOut
                    ),
                    {
                        Size = UDim2.new(0, 106, 0, Enabled and UIListLayout.AbsoluteContentSize.Y + 21 or 14)
                    }
                ):Play()
                TweenService:Create(Dropdown,
                    TweenInfo.new(0.25,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.InOut
                    ),
                    {
                        Rotation = Enabled and 90 or 0
                    }
                ):Play()
            end)

            local ChannelLibrary = {}

            ChannelLibrary.CreateChannel = function(Name)
                local Sections = {}
                local Inputs = {}

                local Channel = Instance.new("TextButton")
                Channel.Name = "Channel"
                Channel.Size = UDim2.new(0, 106, 0, 25)
                Channel.Position = UDim2.new(0.0954274, 0, -0.0045181, 0)
                Channel.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                Channel.AutoButtonColor = false
                Channel.FontSize = Enum.FontSize.Size11
                Channel.TextSize = 11
                Channel.TextColor3 = Color3.fromRGB(255, 255, 255)
                Channel.Text = ""
                Channel.Font = Enum.Font.Gotham
                Channel.Parent = Dropdown_Content
                table.insert(GuildLibrary.Channel_Buttons, Channel)

                local UICorner2 = Instance.new("UICorner")
                UICorner2.CornerRadius = UDim.new(0, 5)
                UICorner2.Parent = Channel

                local Bar = Instance.new("Frame")
                Bar.Name = "Bar"
                Bar.Size = UDim2.new(0, 5, 0, 16)
                Bar.Position = UDim2.new(-1, 0, 0.185, 0)
                Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Bar.Parent = Channel

                local UICorner3 = Instance.new("UICorner")
                UICorner3.CornerRadius = UDim.new(0, 5)
                UICorner3.Parent = Bar

                local BarHider = Instance.new("Frame")
                BarHider.Name = "BarHider"
                BarHider.Size = UDim2.new(0, 4, 0, 24)
                BarHider.Position = UDim2.new(0.019, 0, 0, 0)
                BarHider.BorderSizePixel = 0
                BarHider.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                BarHider.Parent = Channel

                local ChannelName = Instance.new("TextLabel")
                ChannelName.Name = "ChannelName"
                ChannelName.Size = UDim2.new(0, 85, 0, 25)
                ChannelName.BackgroundTransparency = 1
                ChannelName.Position = UDim2.new(0.05, 0, 0, 0)
                ChannelName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ChannelName.FontSize = Enum.FontSize.Size10
                ChannelName.TextSize = 10
                ChannelName.TextColor3 = Color3.fromRGB(255, 255, 255)
                ChannelName.Text = "#" .. string.lower(Name)
                ChannelName.Font = Enum.Font.Gotham
                ChannelName.TextXAlignment = Enum.TextXAlignment.Left
                ChannelName.Parent = Channel

                local Content = Instance.new("ScrollingFrame")
                Content.Name = "Content"
                Content.Size = UDim2.new(0, 407, 0, 275)
                Content.BackgroundTransparency = 1
                Content.Position = UDim2.new(0.277972, 0, 0.1525125, 0)
                Content.Active = true
                Content.BorderSizePixel = 0
                Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Content.ScrollBarThickness = 0
                Content.Parent = Frame
                Content.Visible = false
                table.insert(GuildLibrary.Channels, Content)

                local UIPadding = Instance.new("UIPadding")
                UIPadding.PaddingTop = UDim.new(0, 2)
                UIPadding.PaddingLeft = UDim.new(0, 2)
                UIPadding.Parent = Content

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 4)
                UIListLayout.Parent = Content

                local Utility = Instance.new("Frame")
                Utility.Name = "Utility"
                Utility.Size = UDim2.new(0, 417, 0, 23)
                Utility.Position = UDim2.new(0.2700559, 0, 0.0662651, 0)
                Utility.BorderSizePixel = 0
                Utility.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                Utility.Parent = Frame
                Utility.Visible = false
                table.insert(GuildLibrary.Utilities, Utility)

                local TabSelectedName = Instance.new("TextLabel")
                TabSelectedName.Name = "TabSelectedName"
                TabSelectedName.Size = UDim2.new(0, 196, 0, 23)
                TabSelectedName.BackgroundTransparency = 1
                TabSelectedName.Position = UDim2.new(0.0156547, 0, 0, 0)
                TabSelectedName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TabSelectedName.FontSize = Enum.FontSize.Size11
                TabSelectedName.TextSize = 11
                TabSelectedName.RichText = true
                TabSelectedName.TextColor3 = Color3.fromRGB(255, 255, 255)
                TabSelectedName.Text = "#" .. string.lower(Name)
                TabSelectedName.Font = Enum.Font.Gotham
                TabSelectedName.TextXAlignment = Enum.TextXAlignment.Left
                TabSelectedName.Parent = Utility

                local SearchBar = Instance.new("Frame")
                SearchBar.Name = "SearchBar"
                SearchBar.Size = UDim2.new(0, 201, 0, 19)
                SearchBar.Position = UDim2.new(0.4869017, 0, 0.087, 0)
                SearchBar.BorderSizePixel = 0
                SearchBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                SearchBar.Parent = Utility

                local Input1 = Instance.new("TextBox")
                Input1.Name = "Input"
                Input1.Size = UDim2.new(0, 126, 0, 19)
                Input1.BackgroundTransparency = 1
                Input1.Position = UDim2.new(0.1206516, 0, 0, 0)
                Input1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Input1.FontSize = Enum.FontSize.Size11
                Input1.TextSize = 11
                Input1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Input1.Text = ""
                Input1.PlaceholderText = "Search"
                Input1.Font = Enum.Font.Gotham
                Input1.TextXAlignment = Enum.TextXAlignment.Left
                Input1.Parent = SearchBar

                local UICorner19 = Instance.new("UICorner")
                UICorner19.CornerRadius = UDim.new(0, 4)
                UICorner19.Parent = SearchBar

                local SearchIcon = Instance.new("ImageLabel")
                SearchIcon.Name = "SearchIcon"
                SearchIcon.Size = UDim2.new(0, 11, 0, 11)
                SearchIcon.BackgroundTransparency = 1
                SearchIcon.Position = UDim2.new(0.0349751, 0, 0.2105263, 0)
                SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SearchIcon.ImageRectOffset = Vector2.new(964, 324)
                SearchIcon.ImageRectSize = Vector2.new(36, 36)
                SearchIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                SearchIcon.Image = "rbxassetid://3926305904"
                SearchIcon.Parent = SearchBar

                SearchBar.MouseEnter:Connect(function(x, y)
                    TweenService:Create(SearchIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                end)

                SearchBar.MouseLeave:Connect(function(x, y)
                    TweenService:Create(SearchIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                end)

                RunService.Heartbeat:Connect(function()
                    Content.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 4)
                end)

                RunService.Heartbeat:Connect(function()
                    for i,v in next, Inputs do
                        if string.find(v.Name:lower(), Input1.Text:lower()) then
                            v.Visible = true
                        else
                            v.Visible = false
                        end
                    end
                end)

                Channel.MouseButton1Down:Connect(function(x, y)
                    for i,v in next, GuildLibrary.Channel_Buttons do
                        TweenService:Create(v.ChannelName,
                            TweenInfo.new(0.25, Enum.EasingStyle.Exponential,
                                Enum.EasingDirection.InOut
                            ),
                            {
                                Position = UDim2.new(v.ChannelName ~= ChannelName and 0.05 or 0.13, 0, 0, 0),
                                TextColor3 = v.ChannelName ~= ChannelName and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 149, 218)
                            }
                        ):Play()
                        TweenService:Create(v.Bar,
                            TweenInfo.new(0.25, Enum.EasingStyle.Exponential,
                                Enum.EasingDirection.InOut
                            ),
                            {
                                Position = UDim2.new(v.Bar ~= Bar and -1 or 0.025, 0, 0.185, 0)
                            }
                        ):Play()
                    end
                    for i,v in next, GuildLibrary.Channels do
                        v.Visible = v == Content or false
                    end
                    for i,v in next, GuildLibrary.Utilities do
                        v.Visible = v == Utility or false
                    end
                end)

                local SectionLibrary = {}

                SectionLibrary.CreateSection = function(Name)
                    local Section = Instance.new("Frame")
                    Section.Name = "Section"
                    Section.Size = UDim2.new(0, 398, 0, 22)
                    Section.BorderSizePixel = 0
                    Section.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    Section.Parent = Content
                    table.insert(Sections, Section)

                    local UIListLayout1 = Instance.new("UIListLayout")
                    UIListLayout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    UIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
                    UIListLayout1.Padding = UDim.new(0, 3)
                    UIListLayout1.Parent = Section

                    local UICorner1 = Instance.new("UICorner")
                    UICorner1.CornerRadius = UDim.new(0, 5)
                    UICorner1.Parent = Section

                    local UIStroke = Instance.new("UIStroke")
                    UIStroke.Color = Color3.fromRGB(33, 33, 33)
                    UIStroke.Parent = Section

                    local SectionName = Instance.new("TextLabel")
                    SectionName.Name = Name
                    SectionName.Size = UDim2.new(0, 380, 0, 22)
                    SectionName.BackgroundTransparency = 1
                    SectionName.Position = UDim2.new(0.0199961, 0, 0, 0)
                    SectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SectionName.FontSize = Enum.FontSize.Size11
                    SectionName.TextSize = 11
                    SectionName.TextColor3 = Color3.fromRGB(0, 149, 218)
                    SectionName.Text = Name
                    SectionName.Font = Enum.Font.Gotham
                    SectionName.TextXAlignment = Enum.TextXAlignment.Left
                    SectionName.Parent = Section

                    RunService.Heartbeat:Connect(function()
                        Section.Size = UDim2.new(0, 398, 0, UIListLayout1.AbsoluteContentSize.Y + 4)
                    end)

                    local InputLibrary = {}

                    InputLibrary.CreateButton = function(Callback, Data)
                        local Button = Instance.new("TextButton")
                        Button.Name = Data.Name
                        Button.Size = UDim2.new(0, 389, 0, 26)
                        Button.Position = UDim2.new(0.0104167, 0, 0.297619, 0)
                        Button.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Button.AutoButtonColor = false
                        Button.FontSize = Enum.FontSize.Size11
                        Button.TextSize = 11
                        Button.RichText = true
                        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Button.Text = ""
                        Button.Font = Enum.Font.Gotham
                        Button.Parent = Section
                        table.insert(Inputs, Button)

                        local UICorner2 = Instance.new("UICorner")
                        UICorner2.CornerRadius = UDim.new(0, 5)
                        UICorner2.Parent = Button

                        local ButtonName = Instance.new("TextLabel")
                        ButtonName.Name = "ButtonName"
                        ButtonName.Size = UDim2.new(0, 345, 0, 26)
                        ButtonName.BackgroundTransparency = 1
                        ButtonName.Position = UDim2.new(0.0208333, 0, 0, 0)
                        ButtonName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        ButtonName.FontSize = Enum.FontSize.Size11
                        ButtonName.TextSize = 11
                        ButtonName.RichText = true
                        ButtonName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ButtonName.Text = Data.Name
                        ButtonName.Font = Enum.Font.Gotham
                        ButtonName.TextXAlignment = Enum.TextXAlignment.Left
                        ButtonName.Parent = Button

                        local ButtonIcon = Instance.new("ImageLabel")
                        ButtonIcon.Name = "ButtonIcon"
                        ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
                        ButtonIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        ButtonIcon.BackgroundTransparency = 1
                        ButtonIcon.Position = UDim2.new(0.94, 0, 0.125, 0)
                        ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        ButtonIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                        ButtonIcon.ImageRectOffset = Vector2.new(400, 0)
                        ButtonIcon.ImageRectSize = Vector2.new(100, 100)
                        ButtonIcon.Image = "rbxassetid://6764432293"
                        ButtonIcon.Parent = Button

                        Button.MouseEnter:Connect(function(x, y)
                            TweenService:Create(ButtonIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                        end)

                        Button.MouseLeave:Connect(function(x, y)
                            TweenService:Create(ButtonIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                        end)

                        Button.MouseButton1Down:Connect(function(x, y)
                            TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                            task.wait(.126)
                            TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(29, 29, 29)}):Play()
                            Callback()
                        end)

                        local ButtonLibrary = {}

                        ButtonLibrary.Update = function(UpdateCallback, UpdateData)
                            Data.Name = UpdateData.Name or Data.Name
                            Callback = UpdateCallback or Callback
                            Button.Name = Data.Name
                            ButtonName.Text = Data.Name
                            Callback = Callback
                        end

                        ButtonLibrary.Destroy = function()
                            table.remove(Inputs, table.find(Inputs, Button))
                            Button:Destroy()
                        end

                        ButtonLibrary.GetData = function(Key)
                            return Data[Key]
                        end

                        return ButtonLibrary
                    end

                    InputLibrary.CreateLabel = function(Data)
                        local Button = Instance.new("TextButton")
                        Button.Name = Data.Name
                        Button.Size = UDim2.new(0, 389, 0, 26)
                        Button.Position = UDim2.new(0.0104167, 0, 0.297619, 0)
                        Button.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Button.AutoButtonColor = false
                        Button.FontSize = Enum.FontSize.Size11
                        Button.TextSize = 11
                        Button.RichText = true
                        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Button.Text = ""
                        Button.Font = Enum.Font.Gotham
                        Button.Parent = Section
                        table.insert(Inputs, Button)

                        local UICorner2 = Instance.new("UICorner")
                        UICorner2.CornerRadius = UDim.new(0, 5)
                        UICorner2.Parent = Button

                        local LabelName = Instance.new("TextLabel")
                        LabelName.Name = "LabelName"
                        LabelName.Size = UDim2.new(0, 345, 0, 26)
                        LabelName.BackgroundTransparency = 1
                        LabelName.Position = UDim2.new(0.0208333, 0, 0, 0)
                        LabelName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        LabelName.FontSize = Enum.FontSize.Size11
                        LabelName.TextSize = 11
                        LabelName.RichText = true
                        LabelName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        LabelName.Text = Data.Name .. " : " .. Data.Text
                        LabelName.Font = Enum.Font.Gotham
                        LabelName.TextXAlignment = Enum.TextXAlignment.Left
                        LabelName.Parent = Button
                        LabelName.ClipsDescendants = true

                        local LabelIcon = Instance.new("ImageLabel")
                        LabelIcon.Name = "ButtonIcon"
                        LabelIcon.Size = UDim2.new(0, 20, 0, 20)
                        LabelIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        LabelIcon.BackgroundTransparency = 1
                        LabelIcon.Position = UDim2.new(0.94, 0, 0.125, 0)
                        LabelIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        LabelIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                        LabelIcon.ImageRectOffset = Vector2.new(200, 300)
                        LabelIcon.ImageRectSize = Vector2.new(100, 100)
                        LabelIcon.Image = "rbxassetid://6764432293"
                        LabelIcon.Parent = Button

                        Button.MouseEnter:Connect(function(x, y)
                            TweenService:Create(LabelIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                        end)

                        Button.MouseLeave:Connect(function(x, y)
                            TweenService:Create(LabelIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                        end)

                        local LabelLibrary = {}

                        LabelLibrary.Update = function(UpdateData)
                            Data.Name = UpdateData.Name or Data.Name
                            Data.Text = UpdateData.Text or Data.Text
                            Button.Name = UpdateData.Name or Data.Name
                            LabelName.Text = Data.Name .. " : " .. Data.Text
                        end

                        LabelLibrary.Destroy = function()
                            table.remove(Inputs, table.find(Inputs, Button))
                            Button:Destroy()
                        end

                        LabelLibrary.GetData = function(Key)
                            return Data[Key]
                        end

                        return LabelLibrary
                    end

                    InputLibrary.CreateAdvancedDisplay = function(Callback, Data)
                        local Button = Instance.new("TextButton")
                        Button.Name = Data.Name
                        Button.Size = UDim2.new(0, 389, 0, 26)
                        Button.Position = UDim2.new(0.0104167, 0, 0.297619, 0)
                        Button.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Button.AutoButtonColor = false
                        Button.FontSize = Enum.FontSize.Size11
                        Button.TextSize = 11
                        Button.RichText = true
                        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Button.Text = ""
                        Button.Font = Enum.Font.Gotham
                        Button.Parent = Section
                        Button.Visible = not (Data.Parent and Data.Parent.Visible == false)
                        table.insert(Data.Parent and Data.Parent.Children or Inputs, Button)

                        local UICorner2 = Instance.new("UICorner")
                        UICorner2.CornerRadius = UDim.new(0, 5)
                        UICorner2.Parent = Button

                        local DisplayName = Instance.new("TextLabel")
                        DisplayName.Name = "DisplayName"
                        DisplayName.Size = UDim2.new(0, 345, 0, 26)
                        DisplayName.BackgroundTransparency = 1
                        DisplayName.Position = UDim2.new(0.0208333, 0, 0, 0)
                        DisplayName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DisplayName.FontSize = Enum.FontSize.Size11
                        DisplayName.TextSize = 11
                        DisplayName.RichText = true
                        DisplayName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        DisplayName.Text = Data.Name .. " : " .. Data.Text
                        DisplayName.Font = Enum.Font.Gotham
                        DisplayName.TextXAlignment = Enum.TextXAlignment.Left
                        DisplayName.Parent = Button
                        DisplayName.ClipsDescendants = true

                        local DisplayIcon = Instance.new("ImageButton")
                        DisplayIcon.Name = "DisplayIcon"
                        DisplayIcon.Size = UDim2.new(0, 20, 0, 20)
                        DisplayIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        DisplayIcon.BackgroundTransparency = 1
                        DisplayIcon.Position = UDim2.new(0.94, 0, 0.125, 0)
                        DisplayIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DisplayIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                        DisplayIcon.ImageRectOffset = Vector2.new(300, 300)
                        DisplayIcon.ImageRectSize = Vector2.new(100, 100)
                        DisplayIcon.Image = "rbxassetid://6764432293"
                        DisplayIcon.Visible = false
                        DisplayIcon.Parent = Button

                        Button.MouseEnter:Connect(function(x, y)
                            TweenService:Create(DisplayIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                        end)

                        Button.MouseLeave:Connect(function(x, y)
                            TweenService:Create(DisplayIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                        end)

                        Button.MouseButton1Down:Connect(function(x, y)
                            TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                            task.wait(.126)
                            TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(29, 29, 29)}):Play()
                            Callback()
                        end)

                        if Data.Parent then
                            Data.Parent.ChildAdded()
                        else
                            DisplayIcon.Visible = false
                        end

                        local DisplayLibrary = {
                            Visible = false,
                            Children = {}
                        }

                        DisplayLibrary.ChildAdded = function(Update)
                            if not Update then
                                DisplayIcon.Visible = true
                            end
                            local NewName = Data.Name
                            for i, v in next, DisplayLibrary.Children do
                                NewName = NewName .. v.Name
                            end
                            Button.Name = NewName
                            if Data.Parent then
                                Data.Parent.ChildAdded()
                            end
                        end

                        DisplayIcon.MouseButton1Down:Connect(function(x, y)
                            DisplayLibrary.Visible = not DisplayLibrary.Visible
                            DisplayIcon.ImageRectOffset = DisplayLibrary.Visible and Vector2.new(700, 900) or Vector2.new(300, 300)
                            Data.AltCallback(DisplayLibrary.Visible)
                            for i, v in next, DisplayLibrary.Children do
                                v.Visible = DisplayLibrary.Visible
                            end
                        end)

                        Button:GetPropertyChangedSignal("Visible"):Connect(function()
                            if Button.Visible then
                                for i, v in next, DisplayLibrary.Children do
                                    v.Visible = DisplayLibrary.Visible
                                end
                            else
                                for i, v in next, DisplayLibrary.Children do
                                    v.Visible = false
                                end
                            end
                        end)

                        DisplayLibrary.Update = function(UpdateCallback, UpdateData)
                            Data.Name = UpdateData.Name or Data.Name
                            Data.Text = UpdateData.Text or Data.Text
                            Callback = UpdateCallback or Callback
                            Button.Name = UpdateData.Name or Button.Name
                            DisplayName.Text = Data.Name .. " : " .. Data.Text

                            DisplayLibrary.ChildAdded(true)
                        end

                        DisplayLibrary.Destroy = function()
                            table.remove(Inputs, table.find(Inputs, Button))
                            Button:Destroy()
                            if Data.Parent then
                                Data.Parent.ChildAdded()
                            end
                        end

                        DisplayLibrary.GetData = function(Key)
                            return Data[Key]
                        end

                        return DisplayLibrary
                    end

                    InputLibrary.CreateToggle = function(Callback, Data)
                        local Toggle = Instance.new("TextButton")
                        Toggle.Name = Data.Name
                        Toggle.Size = UDim2.new(0, 389, 0, 26)
                        Toggle.Position = UDim2.new(0.0104167, 0, 0.6428571, 0)
                        Toggle.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Toggle.AutoButtonColor = false
                        Toggle.FontSize = Enum.FontSize.Size11
                        Toggle.TextSize = 11
                        Toggle.RichText = true
                        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Toggle.Text = ""
                        Toggle.Font = Enum.Font.Gotham
                        Toggle.Parent = Section
                        table.insert(Inputs, Toggle)

                        local UICorner3 = Instance.new("UICorner")
                        UICorner3.CornerRadius = UDim.new(0, 5)
                        UICorner3.Parent = Toggle

                        local ToggleName = Instance.new("TextLabel")
                        ToggleName.Name = "ToggleName"
                        ToggleName.Size = UDim2.new(0, 345, 0, 26)
                        ToggleName.BackgroundTransparency = 1
                        ToggleName.Position = UDim2.new(0.0208333, 0, 0, 0)
                        ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        ToggleName.FontSize = Enum.FontSize.Size11
                        ToggleName.TextSize = 11
                        ToggleName.RichText = true
                        ToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ToggleName.Text = Data.Name
                        ToggleName.Font = Enum.Font.Gotham
                        ToggleName.TextXAlignment = Enum.TextXAlignment.Left
                        ToggleName.Parent = Toggle
                        
                        local Toggled = Instance.new("Frame")
                        Toggled.Name = "Toggled"
                        Toggled.Size = UDim2.new(0, 20, 0, 20)
                        Toggled.Position = UDim2.new(0.94, 0, 0.1, 0)
                        Toggled.BackgroundColor3 = Data.State and Color3.fromRGB(0, 144, 211) or Color3.fromRGB(0, 0, 0)
                        Toggled.Parent = Toggle
                        
                        local Checked = Instance.new("ImageLabel")
                        Checked.Name = "Checked"
                        Checked.Size = UDim2.new(0, 16, 0, 16)
                        Checked.BackgroundTransparency = 1
                        Checked.Position = UDim2.new(0.083, 0, 0.1, 0)
                        Checked.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Checked.ImageColor3 = Color3.fromRGB(0, 0, 0)
                        Checked.ImageRectOffset = Vector2.new(312, 4)
                        Checked.ImageRectSize = Vector2.new(24, 24)
                        Checked.Image = "rbxassetid://3926305904"
                        Checked.Parent = Toggled
                        
                        local UICorner4 = Instance.new("UICorner")
                        UICorner4.CornerRadius = UDim.new(0, 5)
                        UICorner4.Parent = Toggled
                        
                        local UIStroke1 = Instance.new("UIStroke")
                        UIStroke1.Transparency = 0.2
                        UIStroke1.Color = Color3.fromRGB(0, 0, 0)
                        UIStroke1.Parent = Toggled

                        Toggle.MouseButton1Down:Connect(function(x, y)
                            Data.State = not Data.State
                            TweenService:Create(Toggled, TweenInfo.new(.125), {BackgroundColor3 = Data.State and Color3.fromRGB(0, 144, 211) or Color3.fromRGB(0, 0, 0)}):Play()
                            TweenService:Create(Checked, TweenInfo.new(.25), {ImageColor3 = Data.State and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(0, 144, 211)}):Play()
                            Callback(Data.State)
                        end)

                        Toggle.MouseEnter:Connect(function(x, y)
                            TweenService:Create(Checked, TweenInfo.new(.25), {ImageColor3 = Data.State and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(0, 144, 211)}):Play()
                            TweenService:Create(UIStroke1, TweenInfo.new(.25), {Color = Color3.fromRGB(0, 85, 127)}):Play()
                        end)

                        Toggle.MouseLeave:Connect(function(x, y)
                            TweenService:Create(Checked, TweenInfo.new(.25), {ImageColor3 = Data.State and Color3.fromRGB(0, 144, 211) or Color3.fromRGB(0, 0, 0)}):Play()
                            TweenService:Create(UIStroke1, TweenInfo.new(.25), {Color = Color3.fromRGB(0, 0, 0)}):Play()
                        end)
                    end

                    InputLibrary.CreateDropdown = function(Callback, Data)
                        local Dropdown = Instance.new("TextButton")
                        Dropdown.Name = Data.Name
                        Dropdown.Size = UDim2.new(0, 389, 0, 26)
                        Dropdown.ClipsDescendants = true
                        Dropdown.Position = UDim2.new(0.0113065, 0, 0.4322917, 0)
                        Dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                        Dropdown.AutoButtonColor = false
                        Dropdown.FontSize = Enum.FontSize.Size11
                        Dropdown.TextSize = 11
                        Dropdown.RichText = true
                        Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Dropdown.Text = ""
                        Dropdown.Font = Enum.Font.Gotham
                        Dropdown.Parent = Section
                        table.insert(Inputs, Dropdown)

                        local UICorner = Instance.new("UICorner")
                        UICorner.CornerRadius = UDim.new(0, 5)
                        UICorner.Parent = Dropdown

                        local DropdownName = Instance.new("TextLabel")
                        DropdownName.Name = "DropdownName"
                        DropdownName.Size = UDim2.new(0, 345, 0, 26)
                        DropdownName.BackgroundTransparency = 1
                        DropdownName.Position = UDim2.new(0.0208333, 0, 0, 0)
                        DropdownName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DropdownName.FontSize = Enum.FontSize.Size11
                        DropdownName.TextSize = 11
                        DropdownName.RichText = true
                        DropdownName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        DropdownName.Text = Data.Name .. " : " .. Data.AltText
                        DropdownName.Font = Enum.Font.Gotham
                        DropdownName.TextXAlignment = Enum.TextXAlignment.Left
                        DropdownName.Parent = Dropdown

                        local DropdownIcon = Instance.new("ImageLabel")
                        DropdownIcon.Name = "DropdownIcon"
                        DropdownIcon.Size = UDim2.new(0, 16, 0, 16)
                        DropdownIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        DropdownIcon.BackgroundTransparency = 1
                        DropdownIcon.Position = UDim2.new(0, 367, 0, 5)
                        DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DropdownIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                        DropdownIcon.ImageRectOffset = Vector2.new(200, 550)
                        DropdownIcon.ImageRectSize = Vector2.new(50, 50)
                        DropdownIcon.Image = "rbxassetid://6764432408"
                        DropdownIcon.Parent = Dropdown
                        DropdownIcon.Rotation = 90
                        
                        local Content = Instance.new("Frame")
                        Content.Name = "Content"
                        Content.Size = UDim2.new(0, 371, 0, 30)
                        Content.Position = UDim2.new(0, 9, 0, 30)
                        Content.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Content.Parent = Dropdown
                        
                        local UICorner1 = Instance.new("UICorner")
                        UICorner1.CornerRadius = UDim.new(0, 5)
                        UICorner1.Parent = Content
                        
                        local UIListLayout = Instance.new("UIListLayout")
                        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                        UIListLayout.Padding = UDim.new(0, 3)
                        UIListLayout.Parent = Content
                        
                        local UIPadding = Instance.new("UIPadding")
                        UIPadding.PaddingTop = UDim.new(0, 2)
                        UIPadding.Parent = Content
                        
                        local Line = Instance.new("Frame")
                        Line.Name = "Line"
                        Line.Size = UDim2.new(0, 371, 0, 1)
                        Line.Position = UDim2.new(0, 9, 0, 26)
                        Line.BorderSizePixel = 0
                        Line.BackgroundColor3 = Color3.fromRGB(74, 74, 74)
                        Line.Parent = Dropdown

                        local Options_Instances = {}

                        local Frame = Instance.new("Frame")
                        Frame.Size = UDim2.new(0, 367, 0, 26)
                        Frame.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
                        Frame.Parent = Content

                        local UICorner = Instance.new("UICorner")
                        UICorner.CornerRadius = UDim.new(0, 5)
                        UICorner.Parent = Frame

                        local SearchIcon = Instance.new("ImageLabel")
                        SearchIcon.Name = "SearchIcon"
                        SearchIcon.Size = UDim2.new(0, 16, 0, 16)
                        SearchIcon.BackgroundTransparency = 1
                        SearchIcon.Position = UDim2.new(0.9454496, 0, 0.1634615, 0)
                        SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        SearchIcon.ImageRectOffset = Vector2.new(964, 324)
                        SearchIcon.ImageRectSize = Vector2.new(36, 36)
                        SearchIcon.Image = "rbxassetid://3926305904"
                        SearchIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                        SearchIcon.Parent = Frame

                        local Input = Instance.new("TextBox")
                        Input.Name = "Input"
                        Input.Size = UDim2.new(0, 328, 0, 26)
                        Input.BackgroundTransparency = 1
                        Input.Position = UDim2.new(0.0208333, 0, 0, 0)
                        Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Input.FontSize = Enum.FontSize.Size11
                        Input.TextSize = 11
                        Input.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Input.Text = ""
                        Input.PlaceholderText = "Search"
                        Input.Font = Enum.Font.Gotham
                        Input.TextXAlignment = Enum.TextXAlignment.Left
                        Input.Parent = Frame

                        RunService.Heartbeat:Connect(function()
                            for i,v in next, Options_Instances do
                                if string.find(v.Name:lower(), Input.Text:lower()) then
                                    v.Visible = true
                                else
                                    v.Visible = false
                                end
                            end
                        end)

                        local Enabled, Tweening = false, false

                        RunService.Heartbeat:Connect(function()
                            if not Tweening then
                                Dropdown.Size = Enabled and UDim2.new(0, 389, 0, UIListLayout.AbsoluteContentSize.Y + 35) or UDim2.new(0, 389, 0, 26)
                            end
                        end)

                        Dropdown.MouseButton1Down:Connect(function(x, y)
                            Enabled = not Enabled
                            Tweening = not Tweening
                            TweenService:Create(DropdownIcon, TweenInfo.new(.25), {
                                Rotation = Enabled and 0 or 90
                            }):Play()
                            TweenService:Create(Dropdown, TweenInfo.new(.25), {
                                Size = Enabled and UDim2.new(0, 389, 0, UIListLayout.AbsoluteContentSize.Y + 35) or UDim2.new(0, 389, 0, 26)
                            }):Play()
                            task.wait(.26)
                            Tweening = not Tweening
                        end)

                        Frame.MouseEnter:Connect(function(x, y)
                            TweenService:Create(SearchIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                        end)

                        Frame.MouseLeave:Connect(function(x, y)
                            TweenService:Create(SearchIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                        end)

                        Dropdown.MouseEnter:Connect(function(x, y)
                            TweenService:Create(DropdownIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                        end)

                        Dropdown.MouseLeave:Connect(function(x, y)
                            TweenService:Create(DropdownIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                        end)

                        local DropdownLibrary = {}

                        DropdownLibrary.AddOption = function(OptionData)
                            local Button = Instance.new("TextButton")
                            Button.Name = OptionData.Name
                            Button.Size = UDim2.new(0, 367, 0, 26)
                            Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                            Button.AutoButtonColor = false
                            Button.FontSize = Enum.FontSize.Size11
                            Button.TextSize = 11
                            Button.RichText = true
                            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Button.Text = ""
                            Button.Font = Enum.Font.Gotham
                            Button.Parent = Content
                            table.insert(Options_Instances, Button)

                            local UICorner2 = Instance.new("UICorner")
                            UICorner2.CornerRadius = UDim.new(0, 5)
                            UICorner2.Parent = Button

                            local ButtonName = Instance.new("TextLabel")
                            ButtonName.Name = "ButtonName"
                            ButtonName.Size = UDim2.new(0, 345, 0, 26)
                            ButtonName.BackgroundTransparency = 1
                            ButtonName.Position = UDim2.new(0.0208333, 0, 0, 0)
                            ButtonName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            ButtonName.FontSize = Enum.FontSize.Size11
                            ButtonName.TextSize = 11
                            ButtonName.RichText = true
                            ButtonName.TextColor3 = Color3.fromRGB(255, 255, 255)
                            ButtonName.Text = OptionData.Name
                            ButtonName.Font = Enum.Font.Gotham
                            ButtonName.TextXAlignment = Enum.TextXAlignment.Left
                            ButtonName.Parent = Button

                            local ButtonIcon = Instance.new("ImageLabel")
                            ButtonIcon.Name = "ButtonIcon"
                            ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
                            ButtonIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                            ButtonIcon.BackgroundTransparency = 1
                            ButtonIcon.Position = UDim2.new(0.94, 0, 0.125, 0)
                            ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            ButtonIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                            ButtonIcon.ImageRectOffset = Vector2.new(400, 0)
                            ButtonIcon.ImageRectSize = Vector2.new(100, 100)
                            ButtonIcon.Image = "rbxassetid://6764432293"
                            ButtonIcon.Parent = Button

                            Button.MouseEnter:Connect(function(x, y)
                                TweenService:Create(ButtonIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                                task.wait()
                                OptionData.Enter()
                            end)

                            Button.MouseLeave:Connect(function(x, y)
                                TweenService:Create(ButtonIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                                OptionData.Leave()
                            end)

                            Button.MouseButton1Down:Connect(function(x, y)
                                TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                                task.wait(.126)
                                TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                                Data.AltText = OptionData.Name
                                DropdownName.Text = Data.Name .. " : " .. Data.AltText
                                Callback(OptionData.Data, OptionData.Name)
                            end)
                        end

                        DropdownLibrary.AddOptions = function(Options)
                            for i, v in next, Options do
                                DropdownLibrary.AddOption(v)
                            end
                        end

                        DropdownLibrary.ClearOptions = function()
                            for i,v in next, Options_Instances do
                                v:Destroy()
                            end
                        end

                        DropdownLibrary.Update = function(UpdateCallback, UpdateData)
                            Data.Name = UpdateData.Name or Data.Name
                            Data.AltText = UpdateData.AltText or Data.AltText
                            DropdownName.Text = Data.Name .. " : " .. Data.AltText
                            Dropdown.Name = Data.Name
                            if UpdateData.Options then
                                DropdownLibrary.ClearOptions()
                                DropdownLibrary.AddOptions(UpdateData.Options)
                            end
                            Callback = UpdateCallback or Callback
                        end

                        DropdownLibrary.AddOptions(Data.Options)

                        return DropdownLibrary
                    end

                    InputLibrary.CreateTextBox = function(Callback, Data)
                        local Textbox = Instance.new("Frame")
                        Textbox.Name = Data.Name
                        Textbox.Size = UDim2.new(0, 389, 0, 26)
                        Textbox.Position = UDim2.new(0.0113065, 0, 0.5679013, 0)
                        Textbox.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Textbox.Parent = Section
                        table.insert(Inputs, Textbox)

                        local Input = Instance.new("TextBox")
                        Input.Name = "Input"
                        Input.Size = UDim2.new(0, 348, 0, 21)
                        Input.BackgroundTransparency = 1
                        Input.Position = UDim2.new(0.024, 0, 0.5306122, 0)
                        Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Input.FontSize = Enum.FontSize.Size11
                        Input.TextWrapped = true
                        Input.TextSize = 11
                        Input.TextWrap = true
                        Input.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Input.Text = ""
                        Input.PlaceholderText = Data.Text
                        Input.Font = Enum.Font.Gotham
                        Input.TextXAlignment = Enum.TextXAlignment.Left
                        Input.ClearTextOnFocus = false
                        Input.Parent = Textbox
                        Input.Visible = false
                        Input.TextTransparency = 1
                        
                        local TextboxIcon = Instance.new("ImageLabel")
                        TextboxIcon.Name = "TextboxIcon"
                        TextboxIcon.Size = UDim2.new(0, 20, 0, 20)
                        TextboxIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        TextboxIcon.BackgroundTransparency = 1
                        TextboxIcon.Position = UDim2.new(0.94, 0, 0, 3)
                        TextboxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxIcon.ImageColor3 = Color3.fromRGB(47, 47, 47)
                        TextboxIcon.ImageRectOffset = Vector2.new(100, 0)
                        TextboxIcon.ImageRectSize = Vector2.new(100, 100)
                        TextboxIcon.Image = "rbxassetid://6764432293"
                        TextboxIcon.Parent = Textbox
                        
                        local UICorner = Instance.new("UICorner")
                        UICorner.CornerRadius = UDim.new(0, 5)
                        UICorner.Parent = Textbox
                        
                        local TextboxName = Instance.new("TextLabel")
                        TextboxName.Name = "TextboxName"
                        TextboxName.Size = UDim2.new(0, 258, 0, 26)
                        TextboxName.BackgroundTransparency = 1
                        TextboxName.Position = UDim2.new(0.0208334, 0, 0, 0)
                        TextboxName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxName.FontSize = Enum.FontSize.Size11
                        TextboxName.TextSize = 11
                        TextboxName.RichText = true
                        TextboxName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxName.Text = Data.Name
                        TextboxName.Font = Enum.Font.Gotham
                        TextboxName.TextXAlignment = Enum.TextXAlignment.Left
                        TextboxName.Parent = Textbox
                        
                        local Line = Instance.new("Frame")
                        Line.Name = "Line"
                        Line.Size = UDim2.new(0, 371, 0, 1)
                        Line.Position = UDim2.new(0, 9, 0, 26)
                        Line.BorderSizePixel = 0
                        Line.BackgroundColor3 = Color3.fromRGB(74, 74, 74)
                        Line.Parent = Textbox
                        Line.Visible = false

                        Textbox.MouseEnter:Connect(function(x, y)
                            TweenService:Create(TextboxIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                            TweenService:Create(Textbox, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 51)}):Play()
                            TweenService:Create(Input, TweenInfo.new(.25), {TextTransparency = 0}):Play()
                            Input.Visible = true
                            Line.Visible = true
                        end)

                        Textbox.MouseLeave:Connect(function(x, y)
                            while Input:IsFocused() do
                                task.wait()
                            end
                            TweenService:Create(TextboxIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                            TweenService:Create(Textbox, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 26)}):Play()
                            TweenService:Create(Input, TweenInfo.new(.25), {TextTransparency = 1}):Play()
                            Input.Visible = false
                            Line.Visible = false
                        end)

                        local PrevText = Data.Text

                        Input.FocusLost:Connect(function()
                            local Number = tonumber(Input.Text)
                            if Data.NumOnly and Number then
                                PrevText = Input.Text
                                Callback(Number)
                            elseif Data.NumOnly and not Number then
                                Input.Text = PrevText
                            else
                                PrevText = Input.Text
                                Callback(Input.Text)
                            end
                        end)

                        local TextBoxLibrary = {}

                        TextBoxLibrary.Update = function(UpdateCallback, UpdateData)
                            Callback = UpdateCallback or Callback
                            TextboxName.Text = UpdateData.Name or Data.Name
                            Textbox.Name = UpdateData.Name or Data.Name
                            Input.Text = UpdateData.Text or Data.Text
                        end

                        return TextBoxLibrary
                    end

                    InputLibrary.CreateSlider = function(Callback, Data)
                        local Slider = Instance.new("TextButton")
                        Slider.Name = Data.Name
                        Slider.Size = UDim2.new(0, 389, 0, 26)
                        Slider.Position = UDim2.new(0.024, 0, 0.675, 0)
                        Slider.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Slider.AutoButtonColor = false
                        Slider.FontSize = Enum.FontSize.Size14
                        Slider.TextSize = 14
                        Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
                        Slider.Text = ""
                        Slider.Font = Enum.Font.SourceSans
                        Slider.Parent = Section
                        table.insert(Inputs, Slider)

                        local UICorner = Instance.new("UICorner")
                        UICorner.CornerRadius = UDim.new(0, 5)
                        UICorner.Parent = Slider

                        local SliderIcon = Instance.new("ImageLabel")
                        SliderIcon.Name = "SliderIcon"
                        SliderIcon.Size = UDim2.new(0, 20, 0, 20)
                        SliderIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        SliderIcon.BackgroundTransparency = 1
                        SliderIcon.Position = UDim2.new(0.94, 0, 0, 3)
                        SliderIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        SliderIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                        SliderIcon.ImageRectOffset = Vector2.new(100, 400)
                        SliderIcon.ImageRectSize = Vector2.new(100, 100)
                        SliderIcon.Image = "rbxassetid://6764432293"
                        SliderIcon.Parent = Slider

                        local SliderName = Instance.new("TextLabel")
                        SliderName.Name = "SliderName"
                        SliderName.Size = UDim2.new(0, 258, 0, 26)
                        SliderName.BackgroundTransparency = 1
                        SliderName.Position = UDim2.new(0.0208334, 0, 0, 0)
                        SliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        SliderName.FontSize = Enum.FontSize.Size11
                        SliderName.TextSize = 11
                        SliderName.RichText = true
                        SliderName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        SliderName.Text = Data.Name
                        SliderName.Font = Enum.Font.Gotham
                        SliderName.TextXAlignment = Enum.TextXAlignment.Left
                        SliderName.Parent = Slider

                        local SliderValue = Instance.new("TextLabel")
                        SliderValue.Name = "SliderValue"
                        SliderValue.Size = UDim2.new(0, 96, 0, 26)
                        SliderValue.BackgroundTransparency = 1
                        SliderValue.Position = UDim2.new(0.6840724, 0, 0, 0)
                        SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        SliderValue.FontSize = Enum.FontSize.Size11
                        SliderValue.TextSize = 11
                        SliderValue.RichText = true
                        SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                        SliderValue.Text = tostring(Data.Current) .. "/" .. tostring(Data.Max)
                        SliderValue.Font = Enum.Font.Gotham
                        SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                        SliderValue.Parent = Slider

                        local Bg = Instance.new("Frame")
                        Bg.Name = "Bg"
                        Bg.Size = UDim2.new(0, 370, 0, 4)
                        Bg.Position = UDim2.new(0.024, 0, 0.675, 0)
                        Bg.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                        Bg.Parent = Slider
                        Bg.Visible = false

                        local UICorner1 = Instance.new("UICorner")
                        UICorner1.CornerRadius = UDim.new(0, 5)
                        UICorner1.Parent = Bg

                        local Slide = Instance.new("Frame")
                        Slide.Name = "Slide"
                        Slide.Size = UDim2.new((Data.Current - math.abs(Data.Min))/(Data.Max - math.abs(Data.Min)), 0, 0, 4)
                        Slide.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                        Slide.Parent = Bg
                        Slide.BorderSizePixel = 0

                        local UICorner2 = Instance.new("UICorner")
                        UICorner2.CornerRadius = UDim.new(0, 5)
                        UICorner2.Parent = Slide

                        local MouseDown, Floor, EndInput = false, function(...)
                            return Data.Precise and tonumber(string.format("%.2f", ...)) or math.floor(...)
                        end

                        Slider.MouseButton1Down:Connect(function(x, y)
                            MouseDown = true
                            Slide:TweenSize(
                                UDim2.new(0, math.clamp(Mouse.X - Bg.AbsolutePosition.X, 0, Bg.AbsoluteSize.X), 0, 4),
                                Enum.EasingDirection.InOut,
                                Enum.EasingStyle.Linear,
                                0.1,
                                true, function()
                                    Data.Current = Floor(((Slide.AbsoluteSize.X / Bg.AbsoluteSize.X) * (Data.Max - Data.Min)) + Data.Min)
                                    Callback(Data.Current)
                                    SliderValue.Text = tostring(Data.Current) .. "/" .. tostring(Data.Max)
                                end
                            )
                            local MouseMoved = Mouse.Move:Connect(function()
                                Slide:TweenSize(
                                    UDim2.new(0, math.clamp(Mouse.X - Bg.AbsolutePosition.X, 0, Bg.AbsoluteSize.X), 0, 4),
                                    Enum.EasingDirection.InOut,
                                    Enum.EasingStyle.Linear,
                                    0.1,
                                    true, function()
                                        Data.Current = Floor(((Slide.AbsoluteSize.X / Bg.AbsoluteSize.X) * (Data.Max - Data.Min)) + Data.Min)
                                        Callback(Data.Current)
                                        SliderValue.Text = tostring(Data.Current) .. "/" .. tostring(Data.Max)
                                    end
                                )
                            end)
                            EndInput = UserInputService.InputEnded:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    MouseDown = false
                                    MouseMoved:Disconnect()
                                    EndInput:Disconnect()
                                end
                            end)
                        end)

                        Slider.MouseEnter:Connect(function(x, y)
                            TweenService:Create(SliderIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                            TweenService:Create(Slider, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 46)}):Play()
                            Bg.Visible = true
                        end)

                        Slider.MouseLeave:Connect(function(x, y)
                            while MouseDown do
                                task.wait()
                            end
                            TweenService:Create(SliderIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                            TweenService:Create(Slider, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 26)}):Play()
                            Bg.Visible = false
                        end)
                    end

                    InputLibrary.CreateKeyBind = function(Callback, Data)
                        local Textbox = Instance.new("Frame")
                        Textbox.Name = Data.Name
                        Textbox.Size = UDim2.new(0, 389, 0, 26)
                        Textbox.Position = UDim2.new(0.0113065, 0, 0.5679013, 0)
                        Textbox.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Textbox.Parent = Section
                        table.insert(Inputs, Textbox)
                        
                        local Input = Instance.new("TextBox")
                        Input.Name = "Input"
                        Input.Size = UDim2.new(0, 348, 0, 21)
                        Input.BackgroundTransparency = 1
                        Input.Position = UDim2.new(0.024, 0, 0.5306122, 0)
                        Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Input.FontSize = Enum.FontSize.Size11
                        Input.TextWrapped = true
                        Input.TextSize = 11
                        Input.TextWrap = true
                        Input.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Input.Text = ""
                        Input.PlaceholderText = tostring(Data.KeyBind)
                        Input.Font = Enum.Font.Gotham
                        Input.TextXAlignment = Enum.TextXAlignment.Left
                        Input.ClearTextOnFocus = false
                        Input.Parent = Textbox
                        Input.Visible = false
                        Input.TextTransparency = 1
                        
                        local TextboxIcon = Instance.new("ImageLabel")
                        TextboxIcon.Name = "TextboxIcon"
                        TextboxIcon.Size = UDim2.new(0, 20, 0, 20)
                        TextboxIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        TextboxIcon.BackgroundTransparency = 1
                        TextboxIcon.Position = UDim2.new(0.94, 0, 0, 3)
                        TextboxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxIcon.ImageColor3 = Color3.fromRGB(47, 47, 47)
                        TextboxIcon.ImageRectOffset = Vector2.new(300, 300)
                        TextboxIcon.ImageRectSize = Vector2.new(100, 100)
                        TextboxIcon.Image = "rbxassetid://6764432293"
                        TextboxIcon.Parent = Textbox
                        
                        local UICorner = Instance.new("UICorner")
                        UICorner.CornerRadius = UDim.new(0, 5)
                        UICorner.Parent = Textbox
                        
                        local TextboxName = Instance.new("TextLabel")
                        TextboxName.Name = "TextboxName"
                        TextboxName.Size = UDim2.new(0, 258, 0, 26)
                        TextboxName.BackgroundTransparency = 1
                        TextboxName.Position = UDim2.new(0.0208334, 0, 0, 0)
                        TextboxName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxName.FontSize = Enum.FontSize.Size11
                        TextboxName.TextSize = 11
                        TextboxName.RichText = true
                        TextboxName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxName.Text = Data.Name
                        TextboxName.Font = Enum.Font.Gotham
                        TextboxName.TextXAlignment = Enum.TextXAlignment.Left
                        TextboxName.Parent = Textbox
                        
                        local Line = Instance.new("Frame")
                        Line.Name = "Line"
                        Line.Size = UDim2.new(0, 371, 0, 1)
                        Line.Position = UDim2.new(0, 9, 0, 26)
                        Line.BorderSizePixel = 0
                        Line.BackgroundColor3 = Color3.fromRGB(74, 74, 74)
                        Line.Parent = Textbox
                        Line.Visible = false

                        Textbox.MouseEnter:Connect(function(x, y)
                            TweenService:Create(TextboxIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                            TweenService:Create(Textbox, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 51)}):Play()
                            TweenService:Create(Input, TweenInfo.new(.25), {TextTransparency = 0}):Play()
                            Input.Visible = true
                            Line.Visible = true
                        end)

                        Textbox.MouseLeave:Connect(function(x, y)
                            while Input:IsFocused() do
                                task.wait()
                            end
                            TweenService:Create(TextboxIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                            TweenService:Create(Textbox, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 26)}):Play()
                            TweenService:Create(Input, TweenInfo.new(.25), {TextTransparency = 1}):Play()
                            Input.Visible = false
                            Line.Visible = false
                        end)

                        Input.Focused:Connect(function()
                            Data.Connection = UserInputService.InputEnded:Connect(function(UserInput)
                                if UserInput.KeyCode == Enum.KeyCode.Unknown then return end
                                Data.KeyBind = UserInput.KeyCode
                                Input.Text = tostring(Data.KeyBind)
                            end)
                        end)
        
                        Input.FocusLost:Connect(function()
                            Data.Connection:Disconnect()
                        end)
                        
                        UserInputService.InputBegan:Connect(function(UserInput)
                            if UserInput.KeyCode == Data.KeyBind then
                                Callback()
                                task.wait(1)
                                if UserInputService:IsKeyDown(Data.KeyBind) then
                                    while UserInputService:IsKeyDown(Data.KeyBind) do
                                        Callback()
                                        task.wait()
                                    end
                                end
                            end
                        end)
                    end

                    return InputLibrary
                end

                return SectionLibrary
            end

            ChannelLibrary.CreateNotif = function(Name, ImageRectOffset, TextDescription, Options)
                local Notif = Instance.new("Frame")
                Notif.Name = "Notif"
                Notif.Size = UDim2.new(1, 0, 1, 0)
                Notif.BackgroundTransparency = 0.6
                Notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Notif.Parent = Frame

                local UICorner = Instance.new("UICorner")
                UICorner.Parent = Notif

                local Inner = Instance.new("Frame")
                Inner.Name = "Inner"
                Inner.Size = UDim2.new(0, 380, 0, 242)
                Inner.Position = UDim2.new(0.1678322, 0, 0.1355422, 0)
                Inner.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
                Inner.Parent = Notif

                local UICorner1 = Instance.new("UICorner")
                UICorner1.Parent = Inner

                local Title = Instance.new("TextLabel")
                Title.Name = "Title"
                Title.Size = UDim2.new(0, 380, 0, 29)
                Title.BackgroundTransparency = 1
                Title.Position = UDim2.new(-0.0005889, 0, 0.0281042, 0)
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.FontSize = Enum.FontSize.Size18
                Title.TextSize = 15
                Title.RichText = true
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.Text = Name
                Title.Font = Enum.Font.SourceSansBold
                Title.Parent = Inner

                local Description = Instance.new("TextLabel")
                Description.Name = "Description"
                Description.Size = UDim2.new(0, 342, 0, 87)
                Description.BackgroundTransparency = 1
                Description.Position = UDim2.new(0.0484174, 0, 0.455591, 0)
                Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Description.FontSize = Enum.FontSize.Size18
                Description.TextSize = 15
                Description.RichText = true
                Description.TextColor3 = Color3.fromRGB(255, 255, 255)
                Description.Text = TextDescription
                Description.TextYAlignment = Enum.TextYAlignment.Top
                Description.TextWrapped = true
                Description.Font = Enum.Font.SourceSansBold
                Description.TextWrap = true
                Description.TextXAlignment = Enum.TextXAlignment.Left
                Description.Parent = Inner

                local Buttons = Instance.new("Frame")
                Buttons.Name = "Buttons"
                Buttons.Size = UDim2.new(0, 379, 0, 25)
                Buttons.BackgroundTransparency = 1
                Buttons.Position = UDim2.new(0, 0, 0.8719008, 0)
                Buttons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Buttons.Parent = Inner

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.FillDirection = Enum.FillDirection.Horizontal
                UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 6)
                UIListLayout.Parent = Buttons

                local UIPadding = Instance.new("UIPadding")
                UIPadding.PaddingRight = UDim.new(0, 6)
                UIPadding.Parent = Buttons

                local Warning = Instance.new("ImageLabel")
                Warning.Name = "Warning"
                Warning.Size = UDim2.new(0, 82, 0, 82)
                Warning.BackgroundTransparency = 1
                Warning.Position = UDim2.new(0.39, 0, 0.121, 0)
                Warning.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Warning.ImageColor3 = Color3.fromRGB(155, 250, 255)
                Warning.ImageRectOffset = ImageRectOffset or Vector2.new(0, 600)
                Warning.ImageRectSize = Vector2.new(100, 100)
                Warning.Image = "rbxassetid://6764432293"
                Warning.Parent = Inner

                for i,v in next, Options do
                    local ActionButton = Instance.new("TextButton")
                    ActionButton.Name = "ActionButton"
                    ActionButton.Size = UDim2.new(0, 80, 0, 25)
                    ActionButton.Position = UDim2.new(0.6168845, 0, 0, 0)
                    ActionButton.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                    ActionButton.AutoButtonColor = false
                    ActionButton.FontSize = Enum.FontSize.Size14
                    ActionButton.TextSize = 14
                    ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ActionButton.Text = ""
                    ActionButton.Font = Enum.Font.SourceSansBold
                    ActionButton.Parent = Buttons

                    local UICorner2 = Instance.new("UICorner")
                    UICorner2.CornerRadius = UDim.new(0, 6)
                    UICorner2.Parent = ActionButton

                    local ActionName = Instance.new("TextLabel")
                    ActionName.Name = "ActionName"
                    ActionName.Size = UDim2.new(0, 57, 0, 25)
                    ActionName.BackgroundTransparency = 1
                    ActionName.Position = UDim2.new(0.1232986, 0, 0, 0)
                    ActionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ActionName.FontSize = Enum.FontSize.Size14
                    ActionName.TextSize = 14
                    ActionName.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ActionName.Text = v.Text
                    ActionName.Font = Enum.Font.SourceSansBold
                    ActionName.TextXAlignment = Enum.TextXAlignment.Left
                    ActionName.Parent = ActionButton

                    local Icon = Instance.new("ImageLabel")
                    Icon.Name = "Icon"
                    Icon.Size = UDim2.new(0, 20, 0, 20)
                    Icon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    Icon.BackgroundTransparency = 1
                    Icon.Position = UDim2.new(0.73, 0, 0.1, 0)
                    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Icon.ImageColor3 = Color3.fromRGB(124, 124, 124)
                    Icon.ImageRectOffset = Vector2.new(400, 0)
                    Icon.ImageRectSize = Vector2.new(100, 100)
                    Icon.Image = "rbxassetid://6764432293"
                    Icon.Parent = ActionButton

                    ActionButton.MouseEnter:Connect(function(x, y)
                        TweenService:Create(Icon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                    end)

                    ActionButton.MouseLeave:Connect(function(x, y)
                        TweenService:Create(Icon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(124, 124, 124)}):Play()
                    end)

                    ActionButton.MouseButton1Down:Connect(function(x, y)
                        if v.Close then
                            Notif:Destroy()
                        end
                        v.Callback()
                    end)
                end
            end

            return ChannelLibrary
        end

        return CategoryLibrary
    end

    return GuildLibrary
end

return Library.Module
end,
['Ui/Create.lua'] = function()
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Library = import("Modules/Ui/Library.lua")
local VehicleChecks = import("Modules/ImportChecks/VehicleChecks.lua")
local ReadWrite = import("Modules/ReadWrite/ReadWrite.lua")
local Importer = import("Modules/Importer/Importer.lua")
local Packet = import("Modules/Packet/Packet.lua")

local CreateUi, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
		GlobalUi = {
			ConfigList = {},
			Packets = {},
			Manage = {},
			Settings = {}
		}
	},
	Functions = {}
}, {}

local LMeta = {
	__index = function(self, index)
		return Env[index]
	end
}

local MMeta = {
	__index = function(self, index)
		return Env["M" .. index]
	end
}

setmetatable(CreateUi.Functions, LMeta)
setmetatable(CreateUi.Module.Functions, MMeta)

Env.ResetSelector = function()
	CreateUi.Data.GlobalUi.ConfigList.Name.Update({Name = "Selected Config", Text = ""})
	CreateUi.Data.GlobalUi.Settings.Models.Update(function() end, {Name = "Base Chassis", AltText = ""})
	CreateUi.Data.GlobalUi.Settings.Height.Update(function() end, {Text = "0"})
	CreateUi.Data.GlobalUi.Packets.Dropdown.ClearOptions()
	CreateUi.Data.GlobalUi.Packets.Dropdown.Update(function() end, {Text = "Packet", AltText = ""})
	Env.GetConfig = function()
		return
	end
	CreateUi.Data.GlobalUi.Packets.NewValueTextBox.Update(function() end, {Text = ""})
	CreateUi.Data.GlobalUi.Manage.Init.Update(function() end,{Name = "Initialize"})
end

Env.CreateInitConfigButton = function(Section)-- Selected Config Button
	local Button = Section.CreateButton(function() end, {Name = "Initialize"})

	CreateUi.Data.GlobalUi.Manage.Init = Button

	return Button
end

Env.CreateManageConfigSection = function(Channel) -- Manage Config Section
	local Section = Channel.CreateSection("Manage Config")

	CreateUi.Functions.CreateInitConfigButton(Section)

	return Section
end

Env.CreateNewPacketValue = function(Section)
	local TextBox = Section.CreateTextBox(function(Text) end, {Name = "New Packet Value", Text = ""})

	CreateUi.Data.GlobalUi.Packets.NewValueTextBox = TextBox

	return TextBox
end

Env.CreateSelectedPacketType = function(Section) -- Config Packet Type Label
	local Lable = Section.CreateLabel({
		Name = "Selected Packet Type",
		Text = ""
	})

	CreateUi.Data.GlobalUi.Packets.TypeLabel = Lable

	return Lable
end

Env.CreatePacketListDropDown = function(Section) -- Config Packet Dropdown
	local Dropdown = Section.CreateDropdown(function() end, {Name = "Packet", AltText = "", Options = {}})

	CreateUi.Data.GlobalUi.Packets.Dropdown = Dropdown

	return Dropdown
end

Env.CreateConfigPacketsSection = function(Channel) -- Config Packets Section
	local Section = Channel.CreateSection("Config Packets")

	CreateUi.Functions.CreatePacketListDropDown(Section)
	CreateUi.Functions.CreateSelectedPacketType(Section)
	CreateUi.Functions.CreateNewPacketValue(Section)

	return Section
end

Env.CreateModelHeightTextBox = function(Section)
	local TextBox = Section.CreateTextBox(function() end, {Name = "Height ", Text = "0",NumOnly = true})

	CreateUi.Data.GlobalUi.Settings.Height = TextBox

	return TextBox
end

Env.CreateSelectModelDropdown = function(Section) -- Selected Model
	local Dropdown, Connections, AddVehicle, ReConstruct = Section.CreateDropdown(function() end, {Name = "Base Chassis", AltText = "", Options = {}}), {}

	AddVehicle = function(Vehicle)
		local Seat = Vehicle:FindFirstChild("Seat")
		local BoundingBox = Vehicle:FindFirstChild("BoundingBox")
		local PlayerName = Seat and Seat:FindFirstChild("PlayerName") and Seat.PlayerName.Value or ""
		if BoundingBox then
			BoundingBox.Transparency = 1
		end
		Dropdown.AddOption({
			Name = Vehicle.Name .. (PlayerName ~= "" and " : ".. PlayerName or ""),
			Data = Vehicle,
			Enter = function()
				if BoundingBox then
					Vehicle.BoundingBox.Transparency = 0
				end
			end,
			Leave = function()
				if BoundingBox then
					Vehicle.BoundingBox.Transparency = 1
				end
			end
		})
	end

	ReConstruct = function()
		Dropdown:ClearOptions()

		for i,v in next, Workspace.Vehicles:GetChildren() do
			AddVehicle(v)
		end

		task.wait(5)
		ReConstruct()
	end
	coroutine.wrap(function()
		ReConstruct()
	end)()

	CreateUi.Data.GlobalUi.Settings.Models = Dropdown

	return Dropdown
end

Env.CreateConfigSettingsSection = function(Channel) -- Config Settings Section
	local Section = Channel.CreateSection("Config Settings")

	CreateUi.Functions.CreateSelectModelDropdown(Section)
	CreateUi.Functions.CreateModelHeightTextBox(Section)

	return Section
end

Env.CreateConfigListElement = function(Category, Packet) -- Config List Element
	Packet.Data.Button = CreateUi.Data.GlobalUi.ConfigListSection.CreateButton(function()
		CreateUi.Data.GlobalUi.ConfigList.Name.Update({Name = "Selected Config", Text = Packet.Settings.Name .. " | " ..Packet.Data.Key})
		CreateUi.Data.GlobalUi.Settings.Models.Update(function(Model)
			local Output, Offset = Packet:UpdateModel(Model)
			local Notif = Category.CreateNotif("Model Update", Offset, Output, {
				(Offset == Vector2.new(600, 800) and {
					Text = "Reload",
					Close = true,
					Callback = function()
						Packet.Data.Destroy()
						CreateUi.Functions.ResetSelector()
					end
				} or nil),
				{
					Text = Offset == Vector2.new(600, 800) and "Cancel" or "Ok",
					Close = true,
					Callback = function() end
				}
			})
		end, {Name = "Base Chassis", AltText = Packet.Settings.Model and Packet.Settings.Model.Name or ""})
		CreateUi.Data.GlobalUi.Settings.Height.Update(function(Height)
			Packet:UpdateHeight(Height)
		end, {Text = Packet.Settings.Height})
		local Options = {}
		for i, v in next, Packet.VehiclePackets do
			local Name = string.split(v.Index, ".")
			Name = Name[#Name]
			table.insert(Options, {
				Name = Name,
				Data = v,
				Enter = function() end,
				Leave = function() end
			})
		end
		CreateUi.Data.GlobalUi.Packets.Dropdown.ClearOptions()
		CreateUi.Data.GlobalUi.Packets.Dropdown.AddOptions(Options)
		CreateUi.Data.GlobalUi.Packets.Dropdown.Update(function(Data)
			CreateUi.Data.GlobalUi.Packets.TypeLabel.Update({Text = Data.Type})
			CreateUi.Data.GlobalUi.Packets.NewValueTextBox.Update(function(Text)
				Packet:NewPacketValue(Data, Text)
			end, {})
		end, {})
		Env.GetConfig = function()
			return Packet
		end
		CreateUi.Data.GlobalUi.Manage.Init.Update(function()
			local Output, Offset =  Packet:InitPacket()
			local Notif = Category.CreateNotif("Initialization", Offset, Output, {
				{
					Text = "Ok",
					Close = true,
					Callback = function() end
				}
			})
			CreateUi.Functions.ResetSelector()
		end,{Name = "Initialize"})
	end, {Name = Packet.Settings.Name .. " | " ..Packet.Data.Key})
end

Env.CreateSelectedConfigName = function(Section) -- Selected Config Label
	local Label = Section.CreateLabel({Name = "Selected Config", Text = ""})

	CreateUi.Data.GlobalUi.ConfigList.Name = Label

	return Label
end

Env.CreateConfigListSection = function(Channel) -- Config List Section
	local Section = Channel.CreateSection("Configs")

	CreateUi.Functions.CreateSelectedConfigName(Section)

	CreateUi.Data.GlobalUi.ConfigListSection = Section

	return Section
end

Env.CreateModelLoad = function(Category, Section) -- Model Load
	local Check = function(Data)
		local Output, Offset = VehicleChecks.Functions.RunCheck(Data)

		local Notif = Category.CreateNotif("Model Check", Offset, Output, {
			(Offset == Vector2.new(0, 900) and {
				Text = "Continue",
				Close = true,
				Callback = function()
					local Packet = Importer.Functions.CreateNewSave({
						Name = getcustomasset and string.gsub(string.split(Data, [[\]])[3], ".rbxm", "") or MarketplaceService:GetProductInfo(Data).Name,
						Data = Data,
						Height = 0
					})
					CreateUi.Functions.CreateConfigListElement(Category, Packet)
				end
			} or nil),
			{
				Text = "Cancel",
				Close = true,
				Callback = function() end
			}
		})
	end
	local Dropdown = getcustomasset and Section.CreateDropdown(Check, {Name = "Model File", AltText = "", Options = {}}) or Section.CreateTextBox(Check, {Name = "Model Id", Text = "Id", NumOnly = true})

	if getcustomasset then
		coroutine.wrap(function()
			while true do
				Dropdown:ClearOptions()
				for i, v in next, ReadWrite.Functions.ReadVehicles() do
					Dropdown.AddOption(v)
				end
				task.wait(5)
			end
		end)()
	end

	coroutine.wrap(function()
		while true do
			if CreateUi.Data.GlobalUi.ConfigListSection then
                for i, v in next, ReadWrite.Functions.ReadConfigs() do
                    local Packet = Importer.Functions.CreateNewSave(v)
					if Packet then
                    	CreateUi.Functions.CreateConfigListElement(Category, Packet)
					end
                end
            end
			task.wait()
		end
	end)()

	return Dropdown
end

Env.CreateNewConfigSection = function(Category, Channel) -- New Config Section
	local Section = Channel.CreateSection("New Config")

	CreateUi.Functions.CreateModelLoad(Category, Section)

	return Section
end

Env.CreateImportChannel = function(Category) -- Importer Channel
	local Channel = Category.CreateChannel("Importer")

	CreateUi.Functions.CreateNewConfigSection(Category, Channel)
	CreateUi.Functions.CreateConfigListSection(Channel)
	CreateUi.Functions.CreateConfigSettingsSection(Channel)
	CreateUi.Functions.CreateConfigPacketsSection(Channel)
	CreateUi.Functions.CreateManageConfigSection(Channel)

	return Channel
end

Env.CreateImportCategory = function(Guild) -- Importer Category
	local Category = Guild.CreateCategory("Importer")

	CreateUi.Functions.CreateImportChannel(Category)

	return Category
end

Env.FindInPacket = function(Data, Index)
	for i, v in next, Data do
		if v.Index == Index then
			return true
		end
	end
end

Env.GetConfig = function()
	return
end

Env.ModiyPacket = function(Category, v)
	local Config = CreateUi.Functions.GetConfig()
	local Notif = Category.CreateNotif(not Config and "No config selected" or "Model Update", Vector2.new(200, 300), not Config and "Please select a config" or v.Type == "Instance" and "Modifying this type is not supported" or "Would you like to modify:\n\n" .. v.Dir, {
		{
			Text = "Ok",
			Close = true,
			Callback = Config and function()
				if v.Type == "Instance" then
					return
				end
				Config:PacketValue(v.Dir, v.Type)
				local Options = {}
				for index, value in next, Config.VehiclePackets do
					local Name = string.split(value.Index, ".")
					Name = Name[#Name]
					table.insert(Options, {
						Name = Name,
						Data = value,
						Enter = function() end,
						Leave = function() end
					})
				end
				CreateUi.Data.GlobalUi.Packets.Dropdown.ClearOptions()
				CreateUi.Data.GlobalUi.Packets.Dropdown.AddOptions(Options)
			end or function() end
		} or nil,
		v.Type ~= "Instance" and {
			Text = "Cancel",
			Close = true,
			Callback = function() end
		} or nil
	})
end

Env.UpdatePacket = function(Category, Section)
	local Displays = {}
	RunService.Heartbeat:Connect(function()
		local Data = Packet.Functions.GetPacketData()
		for i, v in next, Data do
			local Text = Displays[v.Index] and Displays[v.Index].GetData("Text")
			if Displays[v.Index] and Text ~= v.Value and Text ~= "{" then
				Displays[v.Index].Update(nil, {Text = v.Value})
			end
			if not Displays[v.Index] then
				Displays[v.Index] = Section.CreateAdvancedDisplay(function()
					CreateUi.Functions.ModiyPacket(Category, v)
				end,
				{
					Name = v.Name,
					Index = v.Index,
					Text = v.Value,
					Parent = Displays[v.Parent],
					AltCallback = function(Open)
						Displays[v.Index].Update(nil, {Text = Open and "{" or "{...}"})
					end
				})
			end
		end
		for i,v in next, Displays do
			if not CreateUi.Functions.FindInPacket(Data, v.GetData("Index")) then
				v.Destroy()
				Displays[i] = nil
			end
		end
	end)
end

Env.CreatePacketSection = function(Category, Channel)
	local Section = Channel.CreateSection("Packet")

	CreateUi.Functions.UpdatePacket(Category, Section)

	return Section
end

Env.CreatePacketChannel = function(Category) -- Packet Channel
	local Channel = Category.CreateChannel("Packet")

	CreateUi.Functions.CreatePacketSection(Category, Channel)

	return Channel
end

Env.CreateVehcileCategory = function(Guild) -- Vehicle Category
	local Category = Guild.CreateCategory("Vehicle")

	CreateUi.Functions.CreatePacketChannel(Category)

	return Category
end

Env.CreateImporterGuild = function(Ui) -- Importer Guild
	local Guild = Ui.CreateGuild("Importer", getcustomasset and getcustomasset("jailbreak.png") or "", getcustomasset and getcustomasset("badimo.webm") or "")

	CreateUi.Functions.CreateImportCategory(Guild)
	CreateUi.Functions.CreateVehcileCategory(Guild)

	return Guild
end

Env.MCreateUi = function()
	local Ui = Library.Functions.CreateUi("Importer") -- Importer Ui

	CreateUi.Functions.CreateImporterGuild(Ui)

	return Ui
end

return CreateUi.Module
end,
}
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