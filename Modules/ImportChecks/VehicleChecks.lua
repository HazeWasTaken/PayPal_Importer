local VehicleChecks, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
		Checks = {
			WheelFrontLeft = {
				Wheel = {},
				Rim = {}
			},
			WheelFrontRight = {
				Wheel = {},
				Rim = {}
			},
			WheelBackLeft = {
				Wheel = {},
				Rim = {}
			},
			WheelBackRight = {
				Wheel = {},
				Rim = {},
			},
			Model = {
				SteeringWheel = {},
				Nitrous = {
					Smoke = {},
					Fire = {}
				},
			},
			Camera = {},
			InsideCamera = {},
			Engine = {},
			Seat = {},
			Steer = {}
		}
	},
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

setmetatable(VehicleChecks.Functions, LMeta)
setmetatable(VehicleChecks.Module.Functions, MMeta)

Env.CheckTable = function(Output, Check, Model, Path)
	for i, v in next, Check do
		if Model:FindFirstChild(i) then
			VehicleChecks.Functions.CheckTable(Output, v, Model:FindFirstChild(i), Path .."." .. i)
		else
			Output.String = Output.String .. "\n" .. Path .."." .. i .. " Not Found"
		end
	end
end

Env.MRunCheck = function(Data)
	local Success, Response = pcall(function()
		return game:GetObjects(getcustomasset and getcustomasset(Data) or "rbxassetid://" .. Data)[1]
	end)

	if not Success or not Response then
		return (Response or "Failed to load model"), Vector2.new(0, 600)
	end

	local Output = {
		String = ""
	}

	VehicleChecks.Functions.CheckTable(Output, VehicleChecks.Data.Checks, Response, "Model")

    Response:Destroy()

	return Output.String:len() > 0 and Output.String or "Model is valid", Output.String:len() > 0 and Vector2.new(0, 600) or Vector2.new(0, 900)
end

return VehicleChecks.Module