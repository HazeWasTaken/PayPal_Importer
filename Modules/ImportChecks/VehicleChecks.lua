local VehicleChecks, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
		Checks = {
			WheelFrontLeft = {
				Required = true,
			},
			WheelFrontRight = {
				Required = true,
			},
			WheelBackLeft = {
				Required = true,
			},
			WheelBackRight = {
				Required = true,
			},
			Camera = {
				Required = true,
			},
			Engine = {
				Required = true,
			},
			Seat = {
				Required = true,
			}
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

setmetatable(VehicleChecks.Functions, LMeta)
setmetatable(VehicleChecks.Module.Functions, MMeta)

Env.MRunCheck = function(Id: string)
	local Model = game:GetObjects("rbxassetid://" .. Id)[1]

	local Output = {}
    table.foreach(VehicleChecks.Data.Checks, function(i, v)
        for index, value in next, Model:GetDescendants() do
            if value.Name == i then
                Output[i] = true
            end
        end
    end)

    Model:Destroy()

	local String = #Output > 0 and ""
	for i,v in next, Output do
		String = String .. "\n" .. i .. " Not Found"
	end

	return String
end

return VehicleChecks.Module