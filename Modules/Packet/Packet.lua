local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packet, Env = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {
        Vehicle = require(ReplicatedStorage.Game.Vehicle),
        PrevData = {}
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

setmetatable(Packet.Functions, LMeta)
setmetatable(Packet.Module.Functions, MMeta)

Env.ReadTable = function(Data, PacketData, Original, Count)
    for i, v in next, PacketData do
        if type(v) == "table" then
            table.insert(Data, {
                Index = Original .. " " .. tostring(i) .. " open",
                Name = string.rep("		", Count) .. tostring(i),
                Value = "{"
            })
            Packet.Functions.ReadTable(Data, v, tostring(i), Count + 1)
            table.insert(Data, {
                Index = Original .. " " .. tostring(i) .. " close",
                Name = string.rep("		", Count) ..  "}",
                Value = tostring(i)
            })
        else
            table.insert(Data, {
                Index = Original .. tostring(i),
                Name = string.rep("		", Count) .. tostring(i),
                Value = tostring(v) .. " (" .. type(v) .. ")"
            })
        end
    end
end

Env.MGetPacketData = function()
    local Data, VehiclePacket = {}, Packet.Data.Vehicle.GetLocalVehiclePacket() or {}

    Packet.Functions.ReadTable(Data, VehiclePacket, "", 0)

    return Data
end

return Packet.Module