local ImporterUi, Env = {
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

setmetatable(ImporterUi.Functions, LMeta)
setmetatable(ImporterUi.Module.Functions, MMeta)

Env.CreateTab = function(Gui)
    local Tab = Gui:CreateTab("Importer")
end

Env.CreateSaveList = function(Tab)
    local List = Tab:CreateList({Name = "Saves"})
end