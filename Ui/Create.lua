local Library = import("Modules/Ui/Library.lua")

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

-- Env.Create

Env.CreateNewConfigSection = function(Channel: table) -- New Config Section
	local Section = Channel.CreateSection("New Config")

	return Section
end

Env.CreateImportChannel = function(Category: table) -- Importer Channel
	local CreateChannel = Category.CreateChannel("Importer")

	return CreateChannel
end

Env.CreateModsChannel = function(Category: table)
	local CreateChannel = Category.CreateChannel("Modifications")

	return CreateChannel
end

Env.CreateImportCategory = function(Guild: table)
	local Category = Guild.CreateCategory("Importer")

	CreateUi.Functions.CreateImportChannel(Category)
	CreateUi.Functions.CreateModsChannel(Category)

	return Category
end

Env.CreatePacketChannel = function(Category: table)
	local CreateChannel = Category.CreateChannel("Packet")

	return CreateChannel
end

Env.CreateVehcileCategory = function(Guild: table)
	local Category = Guild.CreateCategory("Vehicle")

	CreateUi.Functions.CreatePacketChannel(Category)

	return Category
end

Env.CreateImporterGuild = function(Ui: table)
	local Guild = Ui.CreateGuild("Importer", getsynasset("jailbreak.png"), getsynasset("badimo.webm"))

	CreateUi.Functions.CreateImportCategory(Guild)
	CreateUi.Functions.CreateVehcileCategory(Guild)

	return Guild
end

Env.MCreateUi = function()
	local Ui = Library.Functions.CreateUi("Importer")

	CreateUi.Functions.CreateImporterGuild(Ui)

	return Ui
end

return CreateUi.Module