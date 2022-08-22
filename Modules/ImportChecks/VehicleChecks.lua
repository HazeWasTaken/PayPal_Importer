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
			InsideCamera = {
				Required = true
			},
			Engine = {
				Required = true,
			},
			Seat = {
				Required = true,
			},
			Steer = {
				Required = true,
			},
			SteeringWheel = {
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

Env.MRunCheck = function(Data)
	local Success, Response = pcall(function()
		return game:GetObjects(syn and getsynasset("./Vehicles/" .. Data .. ".rbxm") or "rbxassetid://" .. Data)[1]
	end)

	if not Success or not Response then
		return (Response or "Failed to load model"), Vector2.new(0, 600)
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

	return ((String:len() > 0 and String) or "Model is valid"), Vector2.new(0, 900)
end

return VehicleChecks.Module