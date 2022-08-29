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
	__index = function(self: table, index: string)
		return Env[index]
	end
}

local MMeta = {
	__index = function(self: table, index: string)
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