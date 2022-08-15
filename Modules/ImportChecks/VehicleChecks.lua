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

Env.MRunCheck = function(Id: number)
	local Success: boolean, Response: Instance | string = pcall(function()
		return game:GetObjects("rbxassetid://" .. Id)[1]
	end)

	if not Success then
		return Response
	end

	local Output = {}
	for index, instance in next, Response:GetDescendants() do
		if VehicleChecks.Data.Checks[instance.Name] then
			Output[#Output + 1] = instance.Name
		end
	end

    Response:Destroy()

	local String = ""
	for i,v in next, VehicleChecks.Data.Checks do
		if not table.find(Output, i) then
			String = String .. "\n" .. i .. " Not Found"
		end
	end

	return String:len() > 0 and String or "Model is valid"
end

return VehicleChecks.Module