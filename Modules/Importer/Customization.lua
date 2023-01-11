local Customization = {
	Data = {
        Spoiler = require(ReplicatedStorage.Game.Garage.StoreData.Spoiler),
        SpoilerCustomize = require(ReplicatedStorage.Game.Garage.Customize.Spoiler),
    },
	Functions = {}
}

Customization.Functions.GetSpoilerName = function(MeshId)
    for i,v in next, ReplicatedStorage.Resource.Spoiler:GetChildren() do
        if v.MeshId == MeshId then
            return v.Name
        end
    end
end

Customization.Functions.BodyColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
    for i, v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Body" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Customization.Functions.SecondBodyColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "SecondBody" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Customization.Functions.SeatColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Seats" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Customization.Functions.HeadlightsColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Headlights" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Customization.Functions.InteriorMainColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Interior" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Customization.Functions.InteriorDetailColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "SecondInterior" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Customization.Functions.WindowColor = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Windows" then
            v.Color = Item.Color
            v.Material = Item.Material
            v.Reflectance = Item.Reflectance
        end
    end
end

Customization.Functions.WindowTint = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") then
        return
    end
	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == "Windows" and Item < 1 then
            v.Transparency = Item
        end
    end
end

Customization.Functions.SpoilerColor = function(Packet, Item)
    local SpoilerPart = Packet.Data.Model:FindFirstChild("SpoilerPart")
    if SpoilerPart then
        Packet.Data.Model.SpoilerPart.Color = Item.Color
        Packet.Data.Model.SpoilerPart.Material = Item.Material
        Packet.Data.Model.SpoilerPart.Reflectance = Item.Reflectance
    end
end

Customization.Functions.Spoiler = function(Packet, Spoiler)
    local SpoilerName, SpoilerData = Customization.Functions.GetSpoilerName(Spoiler.MeshId)
    for i,v in next, Customization.Data.Spoiler.Items do
        if v.Name == SpoilerName then
            SpoilerData = v
        end
    end
    Packet.Data.Model.DescendantAdded:Connect(function(descendant)
        if descendant.Name == "SpoilerPart" then
            Packet.Data.LatchCFrames[descendant] = Packet.Data.Model.PrimaryPart.CFrame:ToObjectSpace(descendant.CFrame)
        end
    end)
    Customization.Data.SpoilerCustomize(SpoilerData, {
        Model = Packet.Data.Model
    })

    Spoiler.Destroying:Connect(function()
        RunService.Heartbeat:Wait()
        local SpoilerPart = Packet.Data.Model:FindFirstChild("SpoilerPart")
        if not Packet.Data.Chassis:FindFirstChild("SpoilerPart") and SpoilerPart then
            SpoilerPart:Destroy()
        end
    end)
end

Customization.Functions.HyperChrome = function(Packet, Item)
    if not Packet.Data.Model:FindFirstChild("Model") or not Item:IsA("Texture") then
        return
    end

    local NewItem = Item:Clone()

	for i,v in next, Packet.Data.Model.Model:GetDescendants() do
        if v.Name == Item.Parent.Name then
            NewItem.Parent = v
        end
    end

    local Connection = Item:GetPropertyChangedSignal("Color3"):Connect(function()
        NewItem.Color3 = Item.Color3
    end)

    Item.Destroying:Connect(function()
        Connection:Disconnect()
        NewItem:Destroy()
    end)
end

Customization.Functions.ConnectModel = function(Packet)
    Packet.Data.Chassis.DescendantAdded:Connect(function(descendant)
        if descendant.Name == "SpoilerPart" then
            for i,v in next, Packet.Data.Connections.Spoiler do
                v:Disconnect()
                Packet.Data.Connections.Spoiler[i] = nil
            end
            Customization.Functions.Spoiler(Packet, descendant)
            Customization.Functions.SpoilerColor(Packet, descendant)
            table.insert(Packet.Data.Connections.Spoiler, descendant:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, descendant)
            end))
            table.insert(Packet.Data.Connections.Spoiler, descendant:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, descendant)
            end))
            table.insert(Packet.Data.Connections.Spoiler, descendant:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, descendant)
            end))
        end
        if string.find(descendant.Name:lower(), "hyperchrome") then
            Customization.Functions.HyperChrome(Packet, descendant)
        end
    end)
	for i,v in next, Packet.Data.Chassis.Model:GetDescendants() do
        if string.find(v.Name:lower(), "hyperchrome") then
            Customization.Functions.HyperChrome(Packet, v)
        end
        if v.Name == "SpoilerPart" then
            Customization.Functions.Spoiler(Packet, v)
            table.insert(Packet.Data.Connections.Spoiler, v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, v)
            end))
            table.insert(Packet.Data.Connections.Spoiler, v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, v)
            end))
            table.insert(Packet.Data.Connections.Spoiler, v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.SpoilerColor(Packet, v)
            end))
        end
        if v.Name == "Windows" then
            Customization.Functions.WindowTint(Packet, v.Transparency)
            Customization.Functions.WindowColor(Packet, v)
            v:GetPropertyChangedSignal("Transparency"):Connect(function()
                Customization.Functions.WindowTint(Packet, v.Transparency)
            end)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.WindowColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.WindowColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.WindowColor(Packet, v)
            end)
        end
        if v.Name == "SecondInterior" then
            Customization.Functions.InteriorDetailColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.InteriorDetailColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.InteriorDetailColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.InteriorDetailColor(Packet, v)
            end)
        end
        if v.Name == "Interior" then
            Customization.Functions.InteriorMainColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.InteriorMainColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.InteriorMainColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.InteriorMainColor(Packet, v)
            end)
        end
        if v.Name == "Headlights" then
            Customization.Functions.HeadlightsColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.HeadlightsColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.HeadlightsColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.HeadlightsColor(Packet, v)
            end)
        end
        if v.Name == "Seats" then
            Customization.Functions.SeatColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.SeatColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.SeatColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.SeatColor(Packet, v)
            end)
        end
        if v.Name == "SecondBody" then
            Customization.Functions.SecondBodyColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.SecondBodyColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.SecondBodyColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.SecondBodyColor(Packet, v)
            end)
        end
        if v.Name == "Body" then
            Customization.Functions.BodyColor(Packet, v)
            v:GetPropertyChangedSignal("Color"):Connect(function()
                Customization.Functions.BodyColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Material"):Connect(function()
                Customization.Functions.BodyColor(Packet, v)
            end)
            v:GetPropertyChangedSignal("Reflectance"):Connect(function()
                Customization.Functions.BodyColor(Packet, v)
            end)
        end
    end
end

return Customization