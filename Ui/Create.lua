local Library = import("Modules/Ui/Library.lua")
local VehicleChecks = import("Modules/ImportChecks/VehicleChecks.lua")
local ReadWrite = import("Modules/ReadWrite/ReadWrite.lua")
local Importer = import("Modules/Importer/Importer.lua")
local Packet = import("Modules/Packet/Packet.lua")

local CreateUi = {
	Data = {
		GlobalUi = {
			ConfigList = {},
			Packets = {},
			Manage = {},
			Settings = {}
		}
	},
	Functions = {}
}

CreateUi.Functions.ResetSelector = function()
	CreateUi.Data.GlobalUi.ConfigList.Name.Update({Name = "Selected Config", Text = ""})
	CreateUi.Data.GlobalUi.Settings.Models.Update(function() end, {Name = "Base Chassis", Text = ""})
	CreateUi.Data.GlobalUi.Settings.Height.Update(function() end, {Text = "0"})
	CreateUi.Data.GlobalUi.Settings.SimulateWheels.Update(function() end, {State = false})
	CreateUi.Data.GlobalUi.Packets.Dropdown.ClearOptions()
	CreateUi.Data.GlobalUi.Packets.Dropdown.Update(function() end, {Name = "Packet", Text = ""})
	CreateUi.Functions.GetConfig = function()
		return
	end
	CreateUi.Data.GlobalUi.Packets.NewValueTextBox.Update(function() end, {Text = ""})
	CreateUi.Data.GlobalUi.Manage.Init.Update(function() end,{Name = "Initialize"})
end

CreateUi.Functions.CreateInitConfigButton = function(Section)-- Selected Config Button
	local Button = Section.CreateButton(function() end, {Name = "Initialize"})

	CreateUi.Data.GlobalUi.Manage.Init = Button

	return Button
end

CreateUi.Functions.CreateManageConfigSection = function(Channel) -- Manage Config Section
	local Section = Channel.CreateSection("Manage Config")

	CreateUi.Functions.CreateInitConfigButton(Section)

	return Section
end

CreateUi.Functions.CreateNewPacketValue = function(Section)
	local TextBox = Section.CreateTextBox(function(Text) end, {Name = "New Packet Value", Text = ""})

	CreateUi.Data.GlobalUi.Packets.NewValueTextBox = TextBox

	return TextBox
end

CreateUi.Functions.CreateSelectedPacketType = function(Section) -- Config Packet Type Label
	local Lable = Section.CreateLabel({
		Name = "Selected Packet Type",
		Text = ""
	})

	CreateUi.Data.GlobalUi.Packets.TypeLabel = Lable

	return Lable
end

CreateUi.Functions.CreatePacketListDropDown = function(Section) -- Config Packet Dropdown
	local Dropdown = Section.CreateDropdown(function() end, {Name = "Packet", Text = "", Options = {}})

	CreateUi.Data.GlobalUi.Packets.Dropdown = Dropdown

	return Dropdown
end

CreateUi.Functions.CreateConfigPacketsSection = function(Channel) -- Config Packets Section
	local Section = Channel.CreateSection("Config Packets")

	CreateUi.Functions.CreatePacketListDropDown(Section)
	CreateUi.Functions.CreateSelectedPacketType(Section)
	CreateUi.Functions.CreateNewPacketValue(Section)

	return Section
end

CreateUi.Functions.CreateWheelSimulationToggle = function(Section)
	local Toggle = Section.CreateToggle(function() end, {Name = "Simulate Wheels ", State = false})

	CreateUi.Data.GlobalUi.Settings.SimulateWheels = Toggle

	return Toggle
end

CreateUi.Functions.CreateModelHeightTextBox = function(Section)
	local TextBox = Section.CreateTextBox(function() end, {Name = "Height ", Text = "0",NumOnly = true})

	CreateUi.Data.GlobalUi.Settings.Height = TextBox

	return TextBox
end

CreateUi.Functions.CreateSelectModelDropdown = function(Section) -- Selected Model
	local AddVehicle = function(Data, Vehicle)
		local Seat = Vehicle:FindFirstChild("Seat")
		local BoundingBox = Vehicle:FindFirstChild("BoundingBox")
		local PlayerName = Seat and Seat:FindFirstChild("PlayerName") and Seat.PlayerName.Value or ""
		if BoundingBox then
			BoundingBox.Transparency = 1
		end
		table.insert(Data, {
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


	local Dropdown, Connections, AddVehicle, ReConstruct = Section.CreateDropdown(function() end, {Name = "Base Chassis", Text = "", Options = {}, UpdateData = function()
		local Data = {}

		for i,v in next, Workspace.Vehicles:GetChildren() do
			AddVehicle(Data, v)
		end

		return Data
	end}), {}

	CreateUi.Data.GlobalUi.Settings.Models = Dropdown

	return Dropdown
end

CreateUi.Functions.CreateConfigSettingsSection = function(Channel) -- Config Settings Section
	local Section = Channel.CreateSection("Config Settings")

	CreateUi.Functions.CreateSelectModelDropdown(Section)
	CreateUi.Functions.CreateModelHeightTextBox(Section)
	CreateUi.Functions.CreateWheelSimulationToggle(Section)

	return Section
end

CreateUi.Functions.CreateConfigListElement = function(Category, Packet) -- Config List Element
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
		end, {Name = "Base Chassis", Text = Packet.Settings.Model and Packet.Settings.Model.Name or ""})
		CreateUi.Data.GlobalUi.Settings.Height.Update(function(Height)
			Packet:UpdateHeight(Height)
		end, {Text = Packet.Settings.Height})
		CreateUi.Data.GlobalUi.Settings.SimulateWheels.Update(function(Bool)
			Packet:UpdateWheelSimulation(Bool)
		end, {State = Packet.Settings.SimulateWheels})
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
		CreateUi.Functions.GetConfig = function()
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
	end, {Name = Packet.Settings.Name .. " | " .. Packet.Data.Key})
end

CreateUi.Functions.CreateSelectedConfigName = function(Section) -- Selected Config Label
	local Label = Section.CreateLabel({Name = "Selected Config", Text = ""})

	CreateUi.Data.GlobalUi.ConfigList.Name = Label

	return Label
end

CreateUi.Functions.CreateConfigListSection = function(Channel) -- Config List Section
	local Section = Channel.CreateSection("Configs")

	CreateUi.Functions.CreateSelectedConfigName(Section)

	CreateUi.Data.GlobalUi.ConfigListSection = Section

	return Section
end

CreateUi.Functions.CreateModelLoad = function(Category, Section) -- Model Load
	local Type = "Cars"
	local Check = function(Data)
		local Output, Offset = VehicleChecks.Functions.RunCheck(getcustomasset and Data or string.rep("\\", 2) .. Type .. "\\" .. Data)

		local Notif = Category.CreateNotif("Model Check", Offset, Output, {
			(Offset == Vector2.new(0, 900) and {
				Text = "Continue",
				Close = true,
				Callback = function()
					local Packet = Importer.Functions.CreateNewSave({
						Name = getcustomasset and string.gsub(string.split(Data, [[\]])[4], ".rbxm", "") or MarketplaceService:GetProductInfo(Data).Name,
						Data = getcustomasset and Data or string.rep("\\", 2) .. Type .. "\\" .. Data,
						Height = 0,
						SimulateWheels = false
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
	local Dropdown = getcustomasset and Section.CreateDropdown(Check, {Name = "Model File", Text = "", Options = {}, UpdateData = ReadWrite.Functions.ReadVehicles}) or Section.CreateDropdown(function(Data)
		Type = Data
	end, {Name = "Model Type", Text = "Car", Options = {
		{Name = "Car", Data = "Cars"}, {Name = "Heli", Data = "Helis"}
	}}) and Section.CreateTextBox(Check, {Name = "Model Id", Text = "Id", NumOnly = true})

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

CreateUi.Functions.CreateNewConfigSection = function(Category, Channel) -- New Config Section
	local Section = Channel.CreateSection("New Config")

	CreateUi.Functions.CreateModelLoad(Category, Section)

	return Section
end

CreateUi.Functions.CreateImportChannel = function(Category) -- Importer Channel
	local Channel = Category.CreateChannel("Importer")

	CreateUi.Functions.CreateNewConfigSection(Category, Channel)
	CreateUi.Functions.CreateConfigListSection(Channel)
	CreateUi.Functions.CreateConfigSettingsSection(Channel)
	CreateUi.Functions.CreateConfigPacketsSection(Channel)
	CreateUi.Functions.CreateManageConfigSection(Channel)

	return Channel
end

CreateUi.Functions.CreateImportCategory = function(Guild) -- Importer Category
	local Category = Guild.CreateCategory("Importer")

	CreateUi.Functions.CreateImportChannel(Category)

	return Category
end

CreateUi.Functions.FindInPacket = function(Data, Index)
	for i, v in next, Data do
		if v.Index == Index then
			return true
		end
	end
end

CreateUi.Functions.GetConfig = function()
	return
end

CreateUi.Functions.ModiyPacket = function(Category, v)
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

CreateUi.Functions.UpdatePacket = function(Category, Section)
	local Displays = {}
	RunService.Heartbeat:Connect(function()
		if not Section.Content.Visible then
			return
		end
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

CreateUi.Functions.CreatePacketSection = function(Category, Channel)
	local Section = Channel.CreateSection("Packet")

	CreateUi.Functions.UpdatePacket(Category, Section)

	return Section
end

CreateUi.Functions.CreatePacketChannel = function(Category) -- Packet Channel
	local Channel = Category.CreateChannel("Packet")

	CreateUi.Functions.CreatePacketSection(Category, Channel)

	return Channel
end

CreateUi.Functions.CreateVehcileCategory = function(Guild) -- Vehicle Category
	local Category = Guild.CreateCategory("Vehicle")

	CreateUi.Functions.CreatePacketChannel(Category)

	return Category
end

CreateUi.Functions.CreateImporterGuild = function(Ui) -- Importer Guild
	local Guild = Ui.CreateGuild("Importer", getcustomasset and isfile("jailbreak.png") and getcustomasset("jailbreak.png") or "", getcustomasset and isfile("badimo.webm") and getcustomasset("badimo.webm") or "")

	CreateUi.Functions.CreateImportCategory(Guild)
	CreateUi.Functions.CreateVehcileCategory(Guild)

	return Guild
end

CreateUi.Functions.CreateUi = function()
	local Ui = Library.Functions.CreateUi("Importer") -- Importer Ui

	CreateUi.Functions.CreateImporterGuild(Ui)

	return Ui
end

return CreateUi
