local VehicleChecks, Env = {
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

setmetatable(VehicleChecks.Functions, LMeta)
setmetatable(VehicleChecks.Module.Functions, MMeta)

return VehicleChecks.Module