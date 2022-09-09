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
	__index = function(self, index)
		return Env[index]
	end
}

local MMeta = {
	__index = function(self, index)
		return Env["M" .. index]
	end
}

setmetatable(Packet.Functions, LMeta)
setmetatable(Packet.Module.Functions, MMeta)

Env.ReadTable = function(Data, PacketData, Original, Dir, Count)
    for i, v in next, PacketData do
        local Type = typeof(v)
        if Type == "table" then
            table.insert(Data, {
                Index = Original .. tostring(i) .. "open",
                Parent = Original,
                Dir = Dir .. "." .. tostring(i),
                Name = string.rep("		", Count) .. tostring(i),
                Type = Type,
                Value = "{...}"
            })
            Packet.Functions.ReadTable(Data, v, Original .. tostring(i) .. "open", Dir .. "." .. tostring(i),Count + 1)
            table.insert(Data, {
                Index = Original .. tostring(i) .. "close",
                Parent = Original .. tostring(i) .. "open",
                Dir = Dir .. "." .. tostring(i),
                Name = string.rep("		", Count) ..  "}",
                Type = Type,
                Value = tostring(i)
            })
        else
            table.insert(Data, {
                Index = Original .. tostring(i),
                Parent = Original,
                Dir = Dir .. "." .. tostring(i),
                Name = string.rep("		", Count) .. tostring(i),
                Type = Type,
                Value = tostring(v) .. " (" .. (Type == "Instance" and v.ClassName or Type) .. ")"
            })
        end
    end
end

Env.MGetPacketData = function()
    local Data, VehiclePacket = {}, Packet.Data.Vehicle.GetLocalVehiclePacket() or {}

    Packet.Functions.ReadTable(Data, VehiclePacket, "", "Packet", 0)

    return Data
end

return Packet.Module