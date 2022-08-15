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

Env.CreateIdTextBox = function(Channel: table, Section: table) -- Id TextBox
	local TextBox = Section.CreateTextBox(function(Number)
		local Output = VehicleChecks.RunCheck(Number)
		local Notif = Channel.CreateNotif("Model Check", nil, Output, {
			{
				Text = "Create Config",
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

Env.CreateNewConfigSection = function(Channel: table) -- New Config Section
	local Section = Channel.CreateSection("New Config")

	return Section
end

Env.CreateImportChannel = function(Category: table) -- Importer Channel
	local CreateChannel = Category.CreateChannel("Importer")

	return CreateChannel
end

Env.CreateModsChannel = function(Category: table) -- Modifications Channel
	local CreateChannel = Category.CreateChannel("Modifications")

	return CreateChannel
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
	local Guild = Ui.CreateGuild("Importer", getsynasset("jailbreak.png"), getsynasset("badimo.webm"))

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