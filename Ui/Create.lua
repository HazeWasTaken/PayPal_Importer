local Library = import("Modules/Ui/Library.lua")
local VehicleChecks = import("Modules/ImportChecks/VehicleChecks.lua")

local CreateUi, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {},
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

Env.CreateIdTextBox = function(Category: table, Section: table) -- Id TextBox
	local TextBox = Section.CreateTextBox(function(Number)
		local Output = VehicleChecks.Functions.RunCheck(Number)
		local Notif = Category.CreateNotif("Model Check", nil, Output, {
			{
				Text = "Continue",
				Close = true,
				Callback = function()
					print("Config")
				end
			},
			{
				Text = "Cancel",
				Close = true,
				Callback = function() end
			}
		})
	end, {Name = "Model Id", Text = "", NumOnly = true})

	return TextBox
end

Env.CreateNewConfigSection = function(Category: table, Channel: table) -- New Config Section
	local Section = Channel.CreateSection("New Config")

	CreateUi.Functions.CreateIdTextBox(Category, Section)

	return Section
end

Env.CreateImportChannel = function(Category: table) -- Importer Channel
	local Channel = Category.CreateChannel("Importer")

	CreateUi.Functions.CreateNewConfigSection(Category, Channel)

	return Channel
end

Env.CreateModsChannel = function(Category: table) -- Modifications Channel
	local Channel = Category.CreateChannel("Modifications")

	return Channel
end

Env.CreateImportCategory = function(Guild: table) -- Importer Category
	local Category = Guild.CreateCategory("Importer")

	CreateUi.Functions.CreateImportChannel(Category)
	CreateUi.Functions.CreateModsChannel(Category)

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
	local Ui = Library.Functions.CreateUi("Importer") -- mporter Ui

	CreateUi.Functions.CreateImporterGuild(Ui)

	return Ui
end

return CreateUi.Module