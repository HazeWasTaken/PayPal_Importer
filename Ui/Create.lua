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

Env.ResetSelector = function()
	CreateUi.Data.GlobalUi.ConfigList.Name.Update({Name = "Selected Config", Text = ""})
	CreateUi.Data.GlobalUi.Settings.Models.Update(function() end, {Name = "Base Chassis", AltText = ""})
	CreateUi.Data.GlobalUi.Settings.Height.Update(function() end, {Text = "0"})
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

Env.UpdatePacket = function(Section)
	local Labels = {}
	RunService.Heartbeat:Connect(function()
		local Data = Packet.Functions.GetPacketData()
		for i, v in next, Data do
			if Labels[v.Index] and Labels[v.Index].GetData("Text") ~= v.Value  then
				Labels[v.Index].Update({Text = v.Value})
			end
			if not Labels[v.Index] then
				Labels[v.Index] = Section.CreateLabel({
					Name = v.Name,
					Index = v.Index,
					Text = v.Value
				})
			end
		end
		for i,v in next, Labels do
			if not CreateUi.Functions.FindInPacket(Data, v.GetData("Index")) then
				v.Destroy()
				Labels[i] = nil
			end
		end
	end)
end

Env.CreatePacketSection = function(Channel)
	local Section = Channel.CreateSection("Packet")

	CreateUi.Functions.UpdatePacket(Section)

	return Section
end

Env.CreatePacketChannel = function(Category) -- Packet Channel
	local Channel = Category.CreateChannel("Packet")

	CreateUi.Functions.CreatePacketSection(Channel)

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