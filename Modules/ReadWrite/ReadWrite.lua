local ReadWrite = {
	Data = {
		GlobalUi = {
			ConfigList = {},
			Manage = {},
			Settings = {}
		}
	},
	Functions = {}
}

ReadWrite.Functions.SetupReadWrite = function()
    if not isfolder("./PayPal") then
        makefolder("./PayPal")
    end
    if not isfolder("./PayPal/Vehicles") then
        makefolder("./PayPal/Vehicles")
    end
	if not isfolder("./PayPal/Vehicles/Cars") then
        makefolder("./PayPal/Vehicles/Cars")
    end
	if not isfolder("./PayPal/Vehicles/Helis") then
        makefolder("./PayPal/Vehicles/Helis")
    end
    if not isfolder("./PayPal/Configs") then
        makefolder("./PayPal/Configs")
    end
end

ReadWrite.Functions.ReadVehicles = function()
	local Vehicles = {}
	for i, v in next, listfiles("./PayPal/Vehicles/Cars") do
		v = string.gsub(v:gsub([[./PayPal]], "PayPal"), "/", [[\]])
		table.insert(Vehicles, {
			Name = string.gsub(string.split(v, [[\]])[4], ".rbxm", ""),
			Data = v,
			Enter = function() end,
			Leave = function() end
		})
	end
	for i, v in next, listfiles("./PayPal/Vehicles/Helis") do
		v = string.gsub(v:gsub([[./PayPal]], "PayPal"), "/", [[\]])
		table.insert(Vehicles, {
			Name = string.gsub(string.split(v, [[\]])[4], ".rbxm", ""),
			Data = v,
			Enter = function() end,
			Leave = function() end
		})
	end
	return Vehicles
end

ReadWrite.Functions.ReadConfigs = function()
    local Configs = {}
    for i, v in next, listfiles("./PayPal/Configs") do
        table.insert(Configs, HttpService:JSONDecode(readfile(v)))
    end
    return Configs
end

ReadWrite.Functions.WriteConfig = function(Config)
	writefile("./PayPal/Configs/" .. Config.Settings.Name .. Config.Data.Key .. ".json", HttpService:JSONEncode({
		Name = Config.Settings.Name,
		Data = Config.Settings.Data,
		Height = Config.Settings.Height,
		SimulateWheels = Config.Settings.SimulateWheels,
		Key = Config.Data.Key
	}))
end

return ReadWrite