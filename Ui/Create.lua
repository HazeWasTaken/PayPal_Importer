local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Library = import("Modules/Ui/Library.lua")
local VehicleChecks = import("Modules/ImportChecks/VehicleChecks.lua")
local Importer = import("Modules/Importer/Importer.lua")

local CreateUi, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
		GlobalUi = {
			Manage = {},
			Settings = {}
		}
	},
	Functions = {}
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

setmetatable(CreateUi.Functions, LMeta)
setmetatable(CreateUi.Module.Functions, MMeta)

Env.CreateInitConfigButton = function(Section)-- Selected Config Button
	local Button = Section.CreateButton(function() end, {Name = "Initialize"})

	CreateUi.Data.GlobalUi.Manage.Init = Button

	return Button
end

Env.CreateSelectedConfigName = function(Section) -- Selected Config Label
	local Label = Section.CreateLabel({Name = "Selected Config", Text = ""})

	CreateUi.Data.GlobalUi.Manage.Name = Label

	return Label
end

Env.CreateManageConfigSection = function(Channel: table) -- Manage Config Section
	local Section = Channel.CreateSection("Manage Config")

	CreateUi.Functions.CreateSelectedConfigName(Section)
	CreateUi.Functions.CreateInitConfigButton(Section)

	return Section
end

Env.CreateModelHeightTextBox = function(Section)
	local TextBox = Section.CreateTextBox(function() end, {Name = "Height ", Text = "0",NumOnly = true})

	CreateUi.Data.GlobalUi.Settings.Height = TextBox

	return TextBox
end

Env.CreateSelectModelDropdown = function(Section) -- Selected Model
	local Dropdown, Connections, AddVehicle, ReConstruct = Section.CreateDropdown(function() end, {Name = "Selected Model", AltText = "", Options = {}}), {}

	AddVehicle = function(Vehicle)
		local Seat = Vehicle:FindFirstChild("Seat")
		if Seat and Seat:FindFirstChild("PlayerName") then
			if Connections[Seat] then
				Connections[Seat]:Disconnect()
			end
			Connections[Seat] = Seat.PlayerName:GetPropertyChangedSignal("Value"):Connect(function()
				ReConstruct()
			end)
		end
		local PlayerName = Seat and Seat:FindFirstChild("PlayerName") and Seat.PlayerName.Value or ""
		Dropdown.AddOption({
			Name = Vehicle.Name .. (PlayerName ~= "" and " : ".. PlayerName or ""),
			Data = Vehicle,
			Enter = function()
				Vehicle.BoundingBox.Transparency = 0
			end,
			Leave = function()
				Vehicle.BoundingBox.Transparency = 1
			end
		})
	end

	ReConstruct = function()
		Dropdown:ClearOptions()

		for i,v in next, Workspace.Vehicles:GetChildren() do
			AddVehicle(v)
		end
	end

	ReConstruct()

	Workspace.Vehicles.ChildAdded:Connect(ReConstruct)
	Workspace.Vehicles.ChildRemoved:Connect(ReConstruct)

	CreateUi.Data.GlobalUi.Settings.Models = Dropdown

	return Dropdown
end

Env.CreateConfigSettingsSection = function(Channel: table) -- Config Settings Section
	local Section = Channel.CreateSection("Config Settings")

	CreateUi.Functions.CreateSelectModelDropdown(Section)
	CreateUi.Functions.CreateModelHeightTextBox(Section)

	return Section
end

Env.CreateConfigListElement = function(Category, Packet) -- Config List Element
	CreateUi.Data.GlobalUi.ConfigListSection.CreateButton(function()
		CreateUi.Data.GlobalUi.Manage.Name.Update({Name = "Selected Config", Text = Packet.Settings.Name .. " | " ..Packet.Data.Key})
		CreateUi.Data.GlobalUi.Settings.Models.Update(function(Model)
			local Output, Offset = Packet:UpdateModel(Model)
			local Notif = Category.CreateNotif("Model Update", Offset, Output, {
				{
					Text = "Ok",
					Close = true,
					Callback = function() end
				}
			})
		end, {Name = "Selected Model", AltText = Packet.Settings.Model and Packet.Settings.Model.Name or ""})
		CreateUi.Data.GlobalUi.Settings.Height.Update(function(Height: number)
			Packet:UpdateHeight(Height)
		end, {Text = Packet.Settings.Height})
		CreateUi.Data.GlobalUi.Manage.Init.Update(function()
			local Output, Offset =  Packet:InitPacket()
			local Notif = Category.CreateNotif("Initialization", Offset, Output, {
				{
					Text = "Ok",
					Close = true,
					Callback = function() end
				}
			})
		end,{Name = "Initialize"})
	end, {Name = Packet.Settings.Name .. " | " ..Packet.Data.Key})
end

Env.CreateConfigListSection = function(Channel: table) -- Config List Section
	local Section = Channel.CreateSection("Configs")

	CreateUi.Data.GlobalUi.ConfigListSection = Section

	return Section
end

Env.CreateIdTextBox = function(Category: table, Section: table) -- Id TextBox
	local TextBox = Section.CreateTextBox(function(Data: string | number)
		local Output, Offset = VehicleChecks.Functions.RunCheck(Data)

		local Notif = Category.CreateNotif("Model Check", Offset, Output, {
			{
				Text = "Continue",
				Close = true,
				Callback = function()
					local Packet = Importer.Functions.CreateNewSave(Data)
					CreateUi.Functions.CreateConfigListElement(Category, Packet)
				end
			},
			{
				Text = "Cancel",
				Close = true,
				Callback = function() end
			}
		})
	end, {Name = "Model " .. (syn and "File Name" or "Id"), Text = (syn and "File Name" or "Id"), NumOnly = not syn})

	return TextBox
end

Env.CreateNewConfigSection = function(Category: table, Channel: table) -- New Config Section
	local Section: table = Channel.CreateSection("New Config")

	CreateUi.Functions.CreateIdTextBox(Category, Section)

	return Section
end

Env.CreateImportChannel = function(Category: table) -- Importer Channel
	local Channel: table = Category.CreateChannel("Importer")

	CreateUi.Functions.CreateNewConfigSection(Category, Channel)
	CreateUi.Functions.CreateConfigListSection(Channel)
	CreateUi.Functions.CreateManageConfigSection(Channel)
	CreateUi.Functions.CreateConfigSettingsSection(Channel)

	return Channel
end

Env.CreateInitializedChannel = function(Category: table) -- Initialized Channel
	local Channel = Category.CreateChannel("Initialized")

	return Channel
end

Env.CreateImportCategory = function(Guild: table) -- Importer Category
	local Category = Guild.CreateCategory("Importer")

	CreateUi.Functions.CreateImportChannel(Category)
	CreateUi.Functions.CreateInitializedChannel(Category)

	return Category
end

Env.CreatePacketChannel = function(Category: table) -- Packet Channel
	local CreateChannel = Category.CreateChannel("Packet")

	return CreateChannel
end

Env.CreateVehcileCategory = function(Guild: table) -- Vehicle Category
	local Category = Guild.CreateCategory("Vehicle")

	CreateUi.Functions.CreatePacketChannel(Category)

	return Category
end

Env.CreateImporterGuild = function(Ui: table) -- Importer Guild
	local Guild = Ui.CreateGuild("Importer", getsynasset and getsynasset("jailbreak.png") or "", getsynasset and getsynasset("badimo.webm") or "")

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