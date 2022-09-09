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