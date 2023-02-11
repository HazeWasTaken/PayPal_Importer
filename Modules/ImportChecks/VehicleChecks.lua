local VehicleChecks = {
	Data = {
		Checks = {
			Cars = {
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
			},
			Helis = {
				Preset = {},
				Camera = {},
				-- InsideCamera = {},
				Engine = {},
				Seat = {}
			}
		}
	},
	Functions = {}
}

VehicleChecks.Functions.CheckTable = function(Output, Check, Model, Path)
	for i, v in next, Check do
		if Model:FindFirstChild(i) then
			VehicleChecks.Functions.CheckTable(Output, v, Model:FindFirstChild(i), Path .."." .. i)
		else
			Output.String = Output.String .. "\n" .. Path .."." .. i .. " Not Found"
		end
	end
end

VehicleChecks.Functions.RunCheck = function(Data)
	local Success, Response = pcall(function()
		return game:GetObjects(getcustomasset and getcustomasset(Data) or "rbxassetid://" .. Data)[1]
	end)

	local Type = string.split(Data, "\\")[3]

	if not Success or not Response or typeof(Response) ~= "Instance" then
		return (Response or "Failed to load model"), Vector2.new(0, 600)
	end

	local Output = {
		String = ""
	}

	VehicleChecks.Functions.CheckTable(Output, VehicleChecks.Data.Checks[Type], Response, "Model")

    Response:Destroy()

	return Output.String:len() > 0 and Output.String or "Model is valid", Output.String:len() > 0 and Vector2.new(0, 600) or Vector2.new(0, 900)
end

return VehicleChecks