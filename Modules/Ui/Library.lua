local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Mouse = Players.LocalPlayer:GetMouse()

local Library, Env = {
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

setmetatable(Library.Functions, LMeta)
setmetatable(Library.Module.Functions, MMeta)

Env.dragify = function(Frame) -- stole from v3rm :kek:
    local dragToggle = nil
    local dragSpeed = .25
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function updateInput(input)
        local Delta = input.Position - dragStart
        local Position =
            UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        TweenService:Create(Frame, TweenInfo.new(dragSpeed), {Position = Position}):Play()
    end

    Frame.InputBegan:Connect(
        function(input)
            if
                (input.UserInputType == Enum.UserInputType.MouseButton1 or
                    input.UserInputType == Enum.UserInputType.Touch)
             then
                dragToggle = true
                dragStart = input.Position
                startPos = Frame.Position
                input.Changed:Connect(
                    function()
                        if (input.UserInputState == Enum.UserInputState.End) then
                            dragToggle = false
                        end
                    end
                )
            end
        end
    )

    Frame.InputChanged:Connect(
        function(input)
            if
                (input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch)
             then
                dragInput = input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if (input == dragInput and dragToggle) then
                updateInput(input)
            end
        end
    )
end

Env.MCreateUi = function(Name: string)
    local Swift = Instance.new("ScreenGui")
    Swift.Name = "Swift"
    Swift.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Swift.Parent = CoreGui

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 572, 0, 332)
    Frame.Position = UDim2.new(0.2740916, 0, 0.1403888, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.Parent = Swift
    Library.Functions.dragify(Frame)

    local UICorner = Instance.new("UICorner")
    UICorner.Parent = Frame
    UICorner.CornerRadius = UDim.new(0,4)

    local ServerSelectionBg = Instance.new("Frame")
    ServerSelectionBg.Name = "ServerSelectionBg"
    ServerSelectionBg.Size = UDim2.new(0, 44, 0, 310)
    ServerSelectionBg.Position = UDim2.new(0, 0, 0.0662651, 0)
    ServerSelectionBg.BorderSizePixel = 0
    ServerSelectionBg.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    ServerSelectionBg.Parent = Frame

    local UICorner11 = Instance.new("UICorner")
    UICorner11.Parent = ServerSelectionBg

    local RoundHiderTop = Instance.new("Frame")
    RoundHiderTop.Name = "RoundHiderTop"
    RoundHiderTop.Size = UDim2.new(0, 44, 0, 16)
    RoundHiderTop.BorderSizePixel = 0
    RoundHiderTop.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    RoundHiderTop.Parent = ServerSelectionBg

    local RoundHiderRight = Instance.new("Frame")
    RoundHiderRight.Name = "RoundHiderRight"
    RoundHiderRight.Size = UDim2.new(0, 16, 0, 310)
    RoundHiderRight.Position = UDim2.new(0.6363636, 0, 0, 0)
    RoundHiderRight.BorderSizePixel = 0
    RoundHiderRight.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    RoundHiderRight.Parent = ServerSelectionBg

    local ServerSelection = Instance.new("ScrollingFrame")
    ServerSelection.Name = "ServerSelection"
    ServerSelection.Size = UDim2.new(0, 44, 0, 304)
    ServerSelection.BackgroundTransparency = 1
    ServerSelection.Position = UDim2.new(0, 0, 0.0843373, 0)
    ServerSelection.Active = true
    ServerSelection.BorderSizePixel = 0
    ServerSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ServerSelection.CanvasSize = UDim2.new(0, 0, 0, 0)
    ServerSelection.ScrollBarThickness = 3
    ServerSelection.Parent = Frame

    local UIListLayout2 = Instance.new("UIListLayout")
    UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout2.Padding = UDim.new(0, 3)
    UIListLayout2.Parent = ServerSelection

    local MainTitle = Instance.new("TextLabel")
    MainTitle.Name = "MainTitle"
    MainTitle.Size = UDim2.new(0, 558, 0, 22)
    MainTitle.BackgroundTransparency = 1
    MainTitle.Position = UDim2.new(0.0236014, 0, 0, 0)
    MainTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainTitle.FontSize = Enum.FontSize.Size14
    MainTitle.TextSize = 14
    MainTitle.RichText = true
    MainTitle.TextColor3 = Color3.fromRGB(31, 99, 226)
    MainTitle.Text = "<b><i>Pay<font color=\"rgb(12, 150, 255)\">Pal</font> - <font color=\"rgb(255, 255, 255)\">" .. Name .. "</font></i></b>"
    MainTitle.TextWrapped = true
    MainTitle.Font = Enum.Font.SourceSans
    MainTitle.TextWrap = true
    MainTitle.TextXAlignment = Enum.TextXAlignment.Left
    MainTitle.Parent = Frame

    local GuildLibrary = {
        Guilds = {},
        Channels = {},
        Utilities = {},
        Channel_Buttons = {},
    }

    GuildLibrary.CreateGuild = function(Name: string, Icon: string, Banner: string)
        local Guild = {}

        local ServerName = Instance.new("Frame")
        ServerName.Name = "ServerName"
        ServerName.Size = UDim2.new(0, 0, 0, 23)
        ServerName.Position = UDim2.new(0.076, 0, 0.0662651, 0)
        ServerName.BorderSizePixel = 0
        ServerName.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
        ServerName.Parent = Frame
        ServerName.ClipsDescendants = true
        table.insert(GuildLibrary.Guilds, ServerName)
        table.insert(Guild, ServerName)

        local ServerSelected = Instance.new("TextLabel")
        ServerSelected.Name = "ServerSelected"
        ServerSelected.Size = UDim2.new(0, 98, 0, 23)
        ServerSelected.BackgroundTransparency = 1
        ServerSelected.Position = UDim2.new(0.0836759, 0, 0, 0)
        ServerSelected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServerSelected.FontSize = Enum.FontSize.Size12
        ServerSelected.TextSize = 12
        ServerSelected.RichText = true
        ServerSelected.TextColor3 = Color3.fromRGB(255, 255, 255)
        ServerSelected.Text = Name
        ServerSelected.Font = Enum.Font.SourceSansSemibold
        ServerSelected.TextXAlignment = Enum.TextXAlignment.Left
        ServerSelected.Parent = ServerName

        local Server = Instance.new("ImageButton")
        Server.Name = Name
        Server.Size = UDim2.new(0, 34, 0, 34)
        Server.Position = UDim2.new(-0.6363636, 0, 0, 0)
        Server.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
        Server.AutoButtonColor = false
        Server.Parent = ServerSelection
        Server.Image = Icon

        local UICorner12 = Instance.new("UICorner")
        UICorner12.Parent = Server

        local TabSelectionBg = Instance.new("Frame")
        TabSelectionBg.Name = "TabSelectionBg"
        TabSelectionBg.Size = UDim2.new(0, 0, 0, 286)
        TabSelectionBg.Position = UDim2.new(0.076, 0, 0.1355422, 0)
        TabSelectionBg.BorderSizePixel = 0
        TabSelectionBg.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
        TabSelectionBg.Parent = Frame
        table.insert(GuildLibrary.Guilds, TabSelectionBg)
        table.insert(Guild, TabSelectionBg)

        local TabSelection = Instance.new("ScrollingFrame")
        TabSelection.Name = "TabSelection"
        TabSelection.Size = UDim2.new(0, 0, 0, 280)
        TabSelection.BackgroundTransparency = 1
        TabSelection.Position = UDim2.new(0.08, 0, 0.1525125, 0)
        TabSelection.Active = true
        TabSelection.BorderSizePixel = 0
        TabSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabSelection.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabSelection.ScrollBarThickness = 3
        TabSelection.Parent = Frame
        table.insert(GuildLibrary.Guilds, TabSelection)
        table.insert(Guild, TabSelection)

        local UIListLayout3 = Instance.new("UIListLayout")
        UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout3.Padding = UDim.new(0, 3)
        UIListLayout3.Parent = TabSelection

        local ServerBanner = Instance.new("Frame")
        ServerBanner.Name = "ServerBanner"
        ServerBanner.Size = UDim2.new(0, 106, 0, 53)
        ServerBanner.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
        ServerBanner.Parent = TabSelection

        local UICorner13 = Instance.new("UICorner")
        UICorner13.CornerRadius = UDim.new(0, 5)
        UICorner13.Parent = ServerBanner
        UICorner13.CornerRadius = UDim.new(0, 4)

        local VideoFrame = Instance.new("VideoFrame")
        VideoFrame.Name = "VideoFrame"
        VideoFrame.Position = UDim2.new()
        VideoFrame.Size = UDim2.new(1, 0, 1, 0)
        VideoFrame.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
        VideoFrame.Parent = ServerBanner
        VideoFrame.Video = Banner
        VideoFrame.Playing = true
        VideoFrame.Looped = true
        VideoFrame.Volume = 0

        local UICorner14 = Instance.new("UICorner")
        UICorner14.CornerRadius = UDim.new(0, 5)
        UICorner14.Parent = VideoFrame
        UICorner14.CornerRadius = UDim.new(0, 4)

        Server.MouseButton1Down:Connect(function(x, y)
            for i,v in next, GuildLibrary.Guilds do
                TweenService:Create(
                    v,
                    TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
                    {
                        Size = UDim2.new(0, (table.find(Guild, v) and 111 or 0), 0, v.Size.Y.Offset)
                    }
                ):Play()
            end
        end)

        local CategoryLibrary = {}

        CategoryLibrary.CreateCategory = function(Name: string)
            local Category = Instance.new("Frame")
            Category.Name = "Category"
            Category.Parent = TabSelection
            Category.Size = UDim2.new(0, 106, 0, 14)
            Category.ClipsDescendants = true
            Category.BackgroundTransparency = 1
            Category.Position = UDim2.new(0.0225225, 0, 0.2, 0)
            Category.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 5)
            UICorner.Parent = Category

            local TextChannels = Instance.new("TextButton")
            TextChannels.Name = "TextChannels"
            TextChannels.Size = UDim2.new(0, 106, 0, 14)
            TextChannels.BackgroundTransparency = 1
            TextChannels.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
            TextChannels.AutoButtonColor = false
            TextChannels.FontSize = Enum.FontSize.Size11
            TextChannels.TextSize = 11
            TextChannels.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextChannels.Text = ""
            TextChannels.Font = Enum.Font.Gotham
            TextChannels.Parent = Category

            local UICorner1 = Instance.new("UICorner")
            UICorner1.CornerRadius = UDim.new(0, 5)
            UICorner1.Parent = TextChannels

            local TextChannels_Name = Instance.new("TextLabel")
            TextChannels_Name.Name = "TextChannels_Name"
            TextChannels_Name.Size = UDim2.new(0, 91, 0, 14)
            TextChannels_Name.BackgroundTransparency = 1
            TextChannels_Name.Position = UDim2.new(0.17, 0, 0, 0)
            TextChannels_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextChannels_Name.RichText = true
            TextChannels_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextChannels_Name.Text = "<b>" .. Name .. "</b>"
            TextChannels_Name.Font = Enum.Font.Gotham
            TextChannels_Name.TextXAlignment = Enum.TextXAlignment.Left
            TextChannels_Name.Parent = TextChannels

            local Dropdown = Instance.new("ImageButton")
            Dropdown.Name = "Dropdown"
            Dropdown.ZIndex = 2
            Dropdown.Size = UDim2.new(0, 10, 0, 10)
            Dropdown.Rotation = 0
            Dropdown.BackgroundTransparency = 1
            Dropdown.Position = UDim2.new(0.024, 0, 0.16, 0)
            Dropdown.ImageRectOffset = Vector2.new(444, 844)
            Dropdown.Image = "rbxassetid://3926305904"
            Dropdown.ImageRectSize = Vector2.new(36, 36)
            Dropdown.Parent = TextChannels

            local Dropdown_Content = Instance.new("Frame")
            Dropdown_Content.Name = "Dropdown_Content"
            Dropdown_Content.Size = UDim2.new(0, 106, 0, 0)
            Dropdown_Content.ClipsDescendants = true
            Dropdown_Content.BackgroundTransparency = 1
            Dropdown_Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown_Content.Parent = TextChannels

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 3)
            UIListLayout.Parent = Dropdown_Content

            local UIPadding = Instance.new("UIPadding")
            UIPadding.PaddingTop = UDim.new(0, 16)
            UIPadding.Parent = Dropdown_Content

            local Enabled = false

            TextChannels.MouseButton1Down:Connect(function(x, y)
                Enabled = not Enabled
                TweenService:Create(Dropdown_Content,
                    TweenInfo.new(0.25,
                        Enum.EasingStyle.Exponential,
                        Enum.EasingDirection.InOut
                    ),
                    {
                        Size = UDim2.new(0, 106, 0, Enabled and UIListLayout.AbsoluteContentSize.Y + 21 or 0)
                    }
                ):Play()
                TweenService:Create(Category,
                    TweenInfo.new(0.25,
                        Enum.EasingStyle.Exponential,
                        Enum.EasingDirection.InOut
                    ),
                    {
                        Size = UDim2.new(0, 106, 0, Enabled and UIListLayout.AbsoluteContentSize.Y + 21 or 14)
                    }
                ):Play()
                TweenService:Create(Dropdown,
                    TweenInfo.new(0.25,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.InOut
                    ),
                    {
                        Rotation = Enabled and 90 or 0
                    }
                ):Play()
            end)

            local ChannelLibrary = {}

            ChannelLibrary.CreateChannel = function(Name: string)
                local Sections = {}
                local Inputs = {}

                local Channel = Instance.new("TextButton")
                Channel.Name = "Channel"
                Channel.Size = UDim2.new(0, 106, 0, 25)
                Channel.Position = UDim2.new(0.0954274, 0, -0.0045181, 0)
                Channel.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                Channel.AutoButtonColor = false
                Channel.FontSize = Enum.FontSize.Size11
                Channel.TextSize = 11
                Channel.TextColor3 = Color3.fromRGB(255, 255, 255)
                Channel.Text = ""
                Channel.Font = Enum.Font.Gotham
                Channel.Parent = Dropdown_Content
                table.insert(GuildLibrary.Channel_Buttons, Channel)

                local UICorner2 = Instance.new("UICorner")
                UICorner2.CornerRadius = UDim.new(0, 5)
                UICorner2.Parent = Channel

                local Bar = Instance.new("Frame")
                Bar.Name = "Bar"
                Bar.Size = UDim2.new(0, 5, 0, 16)
                Bar.Position = UDim2.new(-1, 0, 0.185, 0)
                Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Bar.Parent = Channel

                local UICorner3 = Instance.new("UICorner")
                UICorner3.CornerRadius = UDim.new(0, 5)
                UICorner3.Parent = Bar

                local BarHider = Instance.new("Frame")
                BarHider.Name = "BarHider"
                BarHider.Size = UDim2.new(0, 4, 0, 24)
                BarHider.Position = UDim2.new(0.019, 0, 0, 0)
                BarHider.BorderSizePixel = 0
                BarHider.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                BarHider.Parent = Channel

                local ChannelName = Instance.new("TextLabel")
                ChannelName.Name = "ChannelName"
                ChannelName.Size = UDim2.new(0, 85, 0, 25)
                ChannelName.BackgroundTransparency = 1
                ChannelName.Position = UDim2.new(0.05, 0, 0, 0)
                ChannelName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ChannelName.FontSize = Enum.FontSize.Size10
                ChannelName.TextSize = 10
                ChannelName.TextColor3 = Color3.fromRGB(255, 255, 255)
                ChannelName.Text = "#" .. string.lower(Name)
                ChannelName.Font = Enum.Font.Gotham
                ChannelName.TextXAlignment = Enum.TextXAlignment.Left
                ChannelName.Parent = Channel

                local Content = Instance.new("ScrollingFrame")
                Content.Name = "Content"
                Content.Size = UDim2.new(0, 407, 0, 275)
                Content.BackgroundTransparency = 1
                Content.Position = UDim2.new(0.277972, 0, 0.1525125, 0)
                Content.Active = true
                Content.BorderSizePixel = 0
                Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Content.ScrollBarThickness = 0
                Content.Parent = Frame
                Content.Visible = false
                table.insert(GuildLibrary.Channels, Content)

                local UIPadding = Instance.new("UIPadding")
                UIPadding.PaddingTop = UDim.new(0, 2)
                UIPadding.PaddingLeft = UDim.new(0, 2)
                UIPadding.Parent = Content

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 4)
                UIListLayout.Parent = Content

                local Utility = Instance.new("Frame")
                Utility.Name = "Utility"
                Utility.Size = UDim2.new(0, 417, 0, 23)
                Utility.Position = UDim2.new(0.2700559, 0, 0.0662651, 0)
                Utility.BorderSizePixel = 0
                Utility.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                Utility.Parent = Frame
                Utility.Visible = false
                table.insert(GuildLibrary.Utilities, Utility)

                local TabSelectedName = Instance.new("TextLabel")
                TabSelectedName.Name = "TabSelectedName"
                TabSelectedName.Size = UDim2.new(0, 196, 0, 23)
                TabSelectedName.BackgroundTransparency = 1
                TabSelectedName.Position = UDim2.new(0.0156547, 0, 0, 0)
                TabSelectedName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TabSelectedName.FontSize = Enum.FontSize.Size11
                TabSelectedName.TextSize = 11
                TabSelectedName.RichText = true
                TabSelectedName.TextColor3 = Color3.fromRGB(255, 255, 255)
                TabSelectedName.Text = "#" .. string.lower(Name)
                TabSelectedName.Font = Enum.Font.Gotham
                TabSelectedName.TextXAlignment = Enum.TextXAlignment.Left
                TabSelectedName.Parent = Utility

                local SearchBar = Instance.new("Frame")
                SearchBar.Name = "SearchBar"
                SearchBar.Size = UDim2.new(0, 201, 0, 19)
                SearchBar.Position = UDim2.new(0.4869017, 0, 0.087, 0)
                SearchBar.BorderSizePixel = 0
                SearchBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                SearchBar.Parent = Utility

                local Input1 = Instance.new("TextBox")
                Input1.Name = "Input"
                Input1.Size = UDim2.new(0, 126, 0, 19)
                Input1.BackgroundTransparency = 1
                Input1.Position = UDim2.new(0.1206516, 0, 0, 0)
                Input1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Input1.FontSize = Enum.FontSize.Size11
                Input1.TextSize = 11
                Input1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Input1.Text = ""
                Input1.PlaceholderText = "Search"
                Input1.Font = Enum.Font.Gotham
                Input1.TextXAlignment = Enum.TextXAlignment.Left
                Input1.Parent = SearchBar

                local UICorner19 = Instance.new("UICorner")
                UICorner19.CornerRadius = UDim.new(0, 4)
                UICorner19.Parent = SearchBar

                local SearchIcon = Instance.new("ImageLabel")
                SearchIcon.Name = "SearchIcon"
                SearchIcon.Size = UDim2.new(0, 11, 0, 11)
                SearchIcon.BackgroundTransparency = 1
                SearchIcon.Position = UDim2.new(0.0349751, 0, 0.2105263, 0)
                SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SearchIcon.ImageRectOffset = Vector2.new(964, 324)
                SearchIcon.ImageRectSize = Vector2.new(36, 36)
                SearchIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                SearchIcon.Image = "rbxassetid://3926305904"
                SearchIcon.Parent = SearchBar

                SearchBar.MouseEnter:Connect(function(x, y)
                    TweenService:Create(SearchIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                end)

                SearchBar.MouseLeave:Connect(function(x, y)
                    TweenService:Create(SearchIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                end)

                RunService.Heartbeat:Connect(function()
                    Content.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 4)
                end)

                Input1.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
                    for i,v in next, Sections do
                        v.Visible = false
                    end
                    for i,v in next, Inputs do
                        if string.find(v.Name, Input1.Text) then
                            v.Parent.Visible = true
                            v.Visible = true
                        else
                            v.Visible = false
                        end
                    end
                end)

                Channel.MouseButton1Down:Connect(function(x, y)
                    for i,v in next, GuildLibrary.Channel_Buttons do
                        TweenService:Create(v.ChannelName,
                            TweenInfo.new(0.25, Enum.EasingStyle.Exponential,
                                Enum.EasingDirection.InOut
                            ),
                            {
                                Position = UDim2.new(v.ChannelName ~= ChannelName and 0.05 or 0.13, 0, 0, 0),
                                TextColor3 = v.ChannelName ~= ChannelName and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 149, 218)
                            }
                        ):Play()
                        TweenService:Create(v.Bar,
                            TweenInfo.new(0.25, Enum.EasingStyle.Exponential,
                                Enum.EasingDirection.InOut
                            ),
                            {
                                Position = UDim2.new(v.Bar ~= Bar and -1 or 0.025, 0, 0.185, 0)
                            }
                        ):Play()
                    end
                    for i,v in next, GuildLibrary.Channels do
                        v.Visible = v == Content or false
                    end
                    for i,v in next, GuildLibrary.Utilities do
                        v.Visible = v == Utility or false
                    end
                end)

                local SectionLibrary = {}

                SectionLibrary.CreateSection = function(Name: string)
                    local Section = Instance.new("Frame")
                    Section.Name = "Section"
                    Section.Size = UDim2.new(0, 398, 0, 22)
                    Section.BorderSizePixel = 0
                    Section.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    Section.Parent = Content
                    table.insert(Sections, Section)

                    local UIListLayout1 = Instance.new("UIListLayout")
                    UIListLayout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    UIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
                    UIListLayout1.Padding = UDim.new(0, 3)
                    UIListLayout1.Parent = Section

                    local UICorner1 = Instance.new("UICorner")
                    UICorner1.CornerRadius = UDim.new(0, 5)
                    UICorner1.Parent = Section

                    local UIStroke = Instance.new("UIStroke")
                    UIStroke.Color = Color3.fromRGB(33, 33, 33)
                    UIStroke.Parent = Section

                    local SectionName = Instance.new("TextLabel")
                    SectionName.Name = Name
                    SectionName.Size = UDim2.new(0, 380, 0, 22)
                    SectionName.BackgroundTransparency = 1
                    SectionName.Position = UDim2.new(0.0199961, 0, 0, 0)
                    SectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SectionName.FontSize = Enum.FontSize.Size11
                    SectionName.TextSize = 11
                    SectionName.TextColor3 = Color3.fromRGB(0, 149, 218)
                    SectionName.Text = Name
                    SectionName.Font = Enum.Font.Gotham
                    SectionName.TextXAlignment = Enum.TextXAlignment.Left
                    SectionName.Parent = Section

                    RunService.Heartbeat:Connect(function()
                        Section.Size = UDim2.new(0, 398, 0, UIListLayout1.AbsoluteContentSize.Y + 4)
                    end)

                    local InputLibrary = {}

                    InputLibrary.CreateButton = function(Callback, Data: table)
                        local Button = Instance.new("TextButton")
                        Button.Name = Data.Name
                        Button.Size = UDim2.new(0, 389, 0, 26)
                        Button.Position = UDim2.new(0.0104167, 0, 0.297619, 0)
                        Button.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Button.AutoButtonColor = false
                        Button.FontSize = Enum.FontSize.Size11
                        Button.TextSize = 11
                        Button.RichText = true
                        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Button.Text = ""
                        Button.Font = Enum.Font.Gotham
                        Button.Parent = Section
                        table.insert(Inputs, Button)

                        local UICorner2 = Instance.new("UICorner")
                        UICorner2.CornerRadius = UDim.new(0, 5)
                        UICorner2.Parent = Button

                        local ButtonName = Instance.new("TextLabel")
                        ButtonName.Name = "ButtonName"
                        ButtonName.Size = UDim2.new(0, 345, 0, 26)
                        ButtonName.BackgroundTransparency = 1
                        ButtonName.Position = UDim2.new(0.0208333, 0, 0, 0)
                        ButtonName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        ButtonName.FontSize = Enum.FontSize.Size11
                        ButtonName.TextSize = 11
                        ButtonName.RichText = true
                        ButtonName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ButtonName.Text = Data.Name
                        ButtonName.Font = Enum.Font.Gotham
                        ButtonName.TextXAlignment = Enum.TextXAlignment.Left
                        ButtonName.Parent = Button

                        local ButtonIcon = Instance.new("ImageLabel")
                        ButtonIcon.Name = "ButtonIcon"
                        ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
                        ButtonIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        ButtonIcon.BackgroundTransparency = 1
                        ButtonIcon.Position = UDim2.new(0.94, 0, 0.125, 0)
                        ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        ButtonIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                        ButtonIcon.ImageRectOffset = Vector2.new(400, 0)
                        ButtonIcon.ImageRectSize = Vector2.new(100, 100)
                        ButtonIcon.Image = "rbxassetid://6764432293"
                        ButtonIcon.Parent = Button

                        Button.MouseEnter:Connect(function(x, y)
                            TweenService:Create(ButtonIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                        end)

                        Button.MouseLeave:Connect(function(x, y)
                            TweenService:Create(ButtonIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                        end)

                        Button.MouseButton1Down:Connect(function(x, y)
                            TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                            task.wait(.126)
                            TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(29, 29, 29)}):Play()
                            Callback()
                        end)
                    end

                    InputLibrary.CreateToggle = function(Callback, Data: table)
                        local Toggle = Instance.new("TextButton")
                        Toggle.Name = Data.Name
                        Toggle.Size = UDim2.new(0, 389, 0, 26)
                        Toggle.Position = UDim2.new(0.0104167, 0, 0.6428571, 0)
                        Toggle.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Toggle.AutoButtonColor = false
                        Toggle.FontSize = Enum.FontSize.Size11
                        Toggle.TextSize = 11
                        Toggle.RichText = true
                        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Toggle.Text = ""
                        Toggle.Font = Enum.Font.Gotham
                        Toggle.Parent = Section
                        table.insert(Inputs, Toggle)
                        
                        local UICorner3 = Instance.new("UICorner")
                        UICorner3.CornerRadius = UDim.new(0, 5)
                        UICorner3.Parent = Toggle
                        
                        local ToggleName = Instance.new("TextLabel")
                        ToggleName.Name = "ToggleName"
                        ToggleName.Size = UDim2.new(0, 345, 0, 26)
                        ToggleName.BackgroundTransparency = 1
                        ToggleName.Position = UDim2.new(0.0208333, 0, 0, 0)
                        ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        ToggleName.FontSize = Enum.FontSize.Size11
                        ToggleName.TextSize = 11
                        ToggleName.RichText = true
                        ToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ToggleName.Text = Data.Name
                        ToggleName.Font = Enum.Font.Gotham
                        ToggleName.TextXAlignment = Enum.TextXAlignment.Left
                        ToggleName.Parent = Toggle
                        
                        local Toggled = Instance.new("Frame")
                        Toggled.Name = "Toggled"
                        Toggled.Size = UDim2.new(0, 20, 0, 20)
                        Toggled.Position = UDim2.new(0.94, 0, 0.1, 0)
                        Toggled.BackgroundColor3 = Data.State and Color3.fromRGB(0, 144, 211) or Color3.fromRGB(0, 0, 0)
                        Toggled.Parent = Toggle
                        
                        local Checked = Instance.new("ImageLabel")
                        Checked.Name = "Checked"
                        Checked.Size = UDim2.new(0, 16, 0, 16)
                        Checked.BackgroundTransparency = 1
                        Checked.Position = UDim2.new(0.083, 0, 0.1, 0)
                        Checked.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Checked.ImageColor3 = Color3.fromRGB(0, 0, 0)
                        Checked.ImageRectOffset = Vector2.new(312, 4)
                        Checked.ImageRectSize = Vector2.new(24, 24)
                        Checked.Image = "rbxassetid://3926305904"
                        Checked.Parent = Toggled
                        
                        local UICorner4 = Instance.new("UICorner")
                        UICorner4.CornerRadius = UDim.new(0, 5)
                        UICorner4.Parent = Toggled
                        
                        local UIStroke1 = Instance.new("UIStroke")
                        UIStroke1.Transparency = 0.2
                        UIStroke1.Color = Color3.fromRGB(0, 0, 0)
                        UIStroke1.Parent = Toggled

                        Toggle.MouseButton1Down:Connect(function(x, y)
                            Data.State = not Data.State
                            TweenService:Create(Toggled, TweenInfo.new(.125), {BackgroundColor3 = Data.State and Color3.fromRGB(0, 144, 211) or Color3.fromRGB(0, 0, 0)}):Play()
                            TweenService:Create(Checked, TweenInfo.new(.25), {ImageColor3 = Data.State and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(0, 144, 211)}):Play()
                            Callback(Data.State)
                        end)

                        Toggle.MouseEnter:Connect(function(x, y)
                            TweenService:Create(Checked, TweenInfo.new(.25), {ImageColor3 = Data.State and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(0, 144, 211)}):Play()
                            TweenService:Create(UIStroke1, TweenInfo.new(.25), {Color = Color3.fromRGB(0, 85, 127)}):Play()
                        end)

                        Toggle.MouseLeave:Connect(function(x, y)
                            TweenService:Create(Checked, TweenInfo.new(.25), {ImageColor3 = Data.State and Color3.fromRGB(0, 144, 211) or Color3.fromRGB(0, 0, 0)}):Play()
                            TweenService:Create(UIStroke1, TweenInfo.new(.25), {Color = Color3.fromRGB(0, 0, 0)}):Play()
                        end)
                    end

                    InputLibrary.CreateDropdown = function(Callback, Data: table)
                        local Dropdown = Instance.new("TextButton")
                        Dropdown.Name = Data.Name
                        Dropdown.Size = UDim2.new(0, 389, 0, 26)
                        Dropdown.ClipsDescendants = true
                        Dropdown.Position = UDim2.new(0.0113065, 0, 0.4322917, 0)
                        Dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                        Dropdown.AutoButtonColor = false
                        Dropdown.FontSize = Enum.FontSize.Size11
                        Dropdown.TextSize = 11
                        Dropdown.RichText = true
                        Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Dropdown.Text = ""
                        Dropdown.Font = Enum.Font.Gotham
                        Dropdown.Parent = Section
                        table.insert(Inputs, Dropdown)
                        
                        local UICorner = Instance.new("UICorner")
                        UICorner.CornerRadius = UDim.new(0, 5)
                        UICorner.Parent = Dropdown
                        
                        local DropdownName = Instance.new("TextLabel")
                        DropdownName.Name = "DropdownName"
                        DropdownName.Size = UDim2.new(0, 345, 0, 26)
                        DropdownName.BackgroundTransparency = 1
                        DropdownName.Position = UDim2.new(0.0208333, 0, 0, 0)
                        DropdownName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DropdownName.FontSize = Enum.FontSize.Size11
                        DropdownName.TextSize = 11
                        DropdownName.RichText = true
                        DropdownName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        DropdownName.Text = Data.Name
                        DropdownName.Font = Enum.Font.Gotham
                        DropdownName.TextXAlignment = Enum.TextXAlignment.Left
                        DropdownName.Parent = Dropdown
                        
                        local DropdownIcon = Instance.new("ImageLabel")
                        DropdownIcon.Name = "DropdownIcon"
                        DropdownIcon.Size = UDim2.new(0, 16, 0, 16)
                        DropdownIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        DropdownIcon.BackgroundTransparency = 1
                        DropdownIcon.Position = UDim2.new(0, 367, 0, 5)
                        DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DropdownIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                        DropdownIcon.ImageRectOffset = Vector2.new(200, 550)
                        DropdownIcon.ImageRectSize = Vector2.new(50, 50)
                        DropdownIcon.Image = "rbxassetid://6764432408"
                        DropdownIcon.Parent = Dropdown
                        DropdownIcon.Rotation = 90
                        
                        local Content = Instance.new("Frame")
                        Content.Name = "Content"
                        Content.Size = UDim2.new(0, 371, 0, 30)
                        Content.Position = UDim2.new(0, 9, 0, 30)
                        Content.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Content.Parent = Dropdown
                        
                        local UICorner1 = Instance.new("UICorner")
                        UICorner1.CornerRadius = UDim.new(0, 5)
                        UICorner1.Parent = Content
                        
                        local UIListLayout = Instance.new("UIListLayout")
                        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                        UIListLayout.Padding = UDim.new(0, 3)
                        UIListLayout.Parent = Content
                        
                        local UIPadding = Instance.new("UIPadding")
                        UIPadding.PaddingTop = UDim.new(0, 2)
                        UIPadding.Parent = Content
                        
                        local Line = Instance.new("Frame")
                        Line.Name = "Line"
                        Line.Size = UDim2.new(0, 371, 0, 1)
                        Line.Position = UDim2.new(0, 9, 0, 26)
                        Line.BorderSizePixel = 0
                        Line.BackgroundColor3 = Color3.fromRGB(74, 74, 74)
                        Line.Parent = Dropdown

                        local Options_Instances = {}

                        local Frame = Instance.new("Frame")
                        Frame.Size = UDim2.new(0, 367, 0, 26)
                        Frame.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
                        Frame.Parent = Content

                        local UICorner = Instance.new("UICorner")
                        UICorner.CornerRadius = UDim.new(0, 5)
                        UICorner.Parent = Frame

                        local SearchIcon = Instance.new("ImageLabel")
                        SearchIcon.Name = "SearchIcon"
                        SearchIcon.Size = UDim2.new(0, 16, 0, 16)
                        SearchIcon.BackgroundTransparency = 1
                        SearchIcon.Position = UDim2.new(0.9454496, 0, 0.1634615, 0)
                        SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        SearchIcon.ImageRectOffset = Vector2.new(964, 324)
                        SearchIcon.ImageRectSize = Vector2.new(36, 36)
                        SearchIcon.Image = "rbxassetid://3926305904"
                        SearchIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                        SearchIcon.Parent = Frame

                        local Input = Instance.new("TextBox")
                        Input.Name = "Input"
                        Input.Size = UDim2.new(0, 328, 0, 26)
                        Input.BackgroundTransparency = 1
                        Input.Position = UDim2.new(0.0208333, 0, 0, 0)
                        Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Input.FontSize = Enum.FontSize.Size11
                        Input.TextSize = 11
                        Input.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Input.Text = ""
                        Input.PlaceholderText = "Search"
                        Input.Font = Enum.Font.Gotham
                        Input.TextXAlignment = Enum.TextXAlignment.Left
                        Input.Parent = Frame

                        Input.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
                            for i,v in next, Options_Instances do
                                if string.find(v.Name, Input.Text) then
                                    v.Visible = true
                                else
                                    v.Visible = false
                                end
                            end
                        end)

                        local Enabled, Tweening = false, false

                        RunService.Heartbeat:Connect(function()
                            if not Tweening then
                                Dropdown.Size = Enabled and UDim2.new(0, 389, 0, UIListLayout.AbsoluteContentSize.Y + 35) or UDim2.new(0, 389, 0, 26)
                            end
                        end)

                        Dropdown.MouseButton1Down:Connect(function(x, y)
                            Enabled = not Enabled
                            Tweening = not Tweening
                            TweenService:Create(DropdownIcon, TweenInfo.new(.25), {
                                Rotation = Enabled and 0 or 90
                            }):Play()
                            TweenService:Create(Dropdown, TweenInfo.new(.25), {
                                Size = Enabled and UDim2.new(0, 389, 0, UIListLayout.AbsoluteContentSize.Y + 35) or UDim2.new(0, 389, 0, 26)
                            }):Play()
                            task.wait(.26)
                            Tweening = not Tweening
                        end)

                        Frame.MouseEnter:Connect(function(x, y)
                            TweenService:Create(SearchIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                        end)

                        Frame.MouseLeave:Connect(function(x, y)
                            TweenService:Create(SearchIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                        end)

                        Dropdown.MouseEnter:Connect(function(x, y)
                            TweenService:Create(DropdownIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                        end)

                        Dropdown.MouseLeave:Connect(function(x, y)
                            TweenService:Create(DropdownIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                        end)

                        for i,v in next, Data.Options do
                            v = type(v) == "table" and rawget(v, "Name") and rawget(v, "Data") and v or {
                                Name = v,
                                Data = v
                            }

                            local Button = Instance.new("TextButton")
                            Button.Name = v.Name
                            Button.Size = UDim2.new(0, 367, 0, 26)
                            Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                            Button.AutoButtonColor = false
                            Button.FontSize = Enum.FontSize.Size11
                            Button.TextSize = 11
                            Button.RichText = true
                            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Button.Text = ""
                            Button.Font = Enum.Font.Gotham
                            Button.Parent = Content
                            table.insert(Options_Instances, Button)
                            
                            local UICorner2 = Instance.new("UICorner")
                            UICorner2.CornerRadius = UDim.new(0, 5)
                            UICorner2.Parent = Button
                            
                            local ButtonName = Instance.new("TextLabel")
                            ButtonName.Name = "ButtonName"
                            ButtonName.Size = UDim2.new(0, 345, 0, 26)
                            ButtonName.BackgroundTransparency = 1
                            ButtonName.Position = UDim2.new(0.0208333, 0, 0, 0)
                            ButtonName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            ButtonName.FontSize = Enum.FontSize.Size11
                            ButtonName.TextSize = 11
                            ButtonName.RichText = true
                            ButtonName.TextColor3 = Color3.fromRGB(255, 255, 255)
                            ButtonName.Text = v.Name
                            ButtonName.Font = Enum.Font.Gotham
                            ButtonName.TextXAlignment = Enum.TextXAlignment.Left
                            ButtonName.Parent = Button
                            
                            local ButtonIcon = Instance.new("ImageLabel")
                            ButtonIcon.Name = "ButtonIcon"
                            ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
                            ButtonIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                            ButtonIcon.BackgroundTransparency = 1
                            ButtonIcon.Position = UDim2.new(0.94, 0, 0.125, 0)
                            ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            ButtonIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                            ButtonIcon.ImageRectOffset = Vector2.new(400, 0)
                            ButtonIcon.ImageRectSize = Vector2.new(100, 100)
                            ButtonIcon.Image = "rbxassetid://6764432293"
                            ButtonIcon.Parent = Button

                            Button.MouseEnter:Connect(function(x, y)
                                TweenService:Create(ButtonIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                            end)
    
                            Button.MouseLeave:Connect(function(x, y)
                                TweenService:Create(ButtonIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                            end)
    
                            Button.MouseButton1Down:Connect(function(x, y)
                                TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                                task.wait(.126)
                                TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                                Callback(v.Data, v.Name)
                            end)
                        end

                        local DropdownLibrary = {}

                        DropdownLibrary.ClearOptions = function()
                            for i,v in next, Options_Instances do
                                v:Destroy()
                            end
                        end

                        DropdownLibrary.AddOption = function(Name, Data)
                            local Button = Instance.new("TextButton")
                            Button.Name = Name
                            Button.Size = UDim2.new(0, 367, 0, 26)
                            Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                            Button.AutoButtonColor = false
                            Button.FontSize = Enum.FontSize.Size11
                            Button.TextSize = 11
                            Button.RichText = true
                            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Button.Text = ""
                            Button.Font = Enum.Font.Gotham
                            Button.Parent = Content
                            table.insert(Options_Instances, Button)
                            
                            local UICorner2 = Instance.new("UICorner")
                            UICorner2.CornerRadius = UDim.new(0, 5)
                            UICorner2.Parent = Button
                            
                            local ButtonName = Instance.new("TextLabel")
                            ButtonName.Name = "ButtonName"
                            ButtonName.Size = UDim2.new(0, 345, 0, 26)
                            ButtonName.BackgroundTransparency = 1
                            ButtonName.Position = UDim2.new(0.0208333, 0, 0, 0)
                            ButtonName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            ButtonName.FontSize = Enum.FontSize.Size11
                            ButtonName.TextSize = 11
                            ButtonName.RichText = true
                            ButtonName.TextColor3 = Color3.fromRGB(255, 255, 255)
                            ButtonName.Text = Name
                            ButtonName.Font = Enum.Font.Gotham
                            ButtonName.TextXAlignment = Enum.TextXAlignment.Left
                            ButtonName.Parent = Button
                            
                            local ButtonIcon = Instance.new("ImageLabel")
                            ButtonIcon.Name = "ButtonIcon"
                            ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
                            ButtonIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                            ButtonIcon.BackgroundTransparency = 1
                            ButtonIcon.Position = UDim2.new(0.94, 0, 0.125, 0)
                            ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            ButtonIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                            ButtonIcon.ImageRectOffset = Vector2.new(400, 0)
                            ButtonIcon.ImageRectSize = Vector2.new(100, 100)
                            ButtonIcon.Image = "rbxassetid://6764432293"
                            ButtonIcon.Parent = Button

                            Button.MouseEnter:Connect(function(x, y)
                                TweenService:Create(ButtonIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                            end)
    
                            Button.MouseLeave:Connect(function(x, y)
                                TweenService:Create(ButtonIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                            end)
    
                            Button.MouseButton1Down:Connect(function(x, y)
                                TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                                task.wait(.126)
                                TweenService:Create(Button, TweenInfo.new(.125), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                                Callback(Data, Name)
                            end)
                        end

                        return DropdownLibrary
                    end

                    InputLibrary.CreateTextBox = function(Callback, Data: table)
                        local Textbox = Instance.new("Frame")
                        Textbox.Name = Data.Name
                        Textbox.Size = UDim2.new(0, 389, 0, 26)
                        Textbox.Position = UDim2.new(0.0113065, 0, 0.5679013, 0)
                        Textbox.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Textbox.Parent = Section
                        table.insert(Inputs, Textbox)
                        
                        local Input = Instance.new("TextBox")
                        Input.Name = "Input"
                        Input.Size = UDim2.new(0, 348, 0, 21)
                        Input.BackgroundTransparency = 1
                        Input.Position = UDim2.new(0.024, 0, 0.5306122, 0)
                        Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Input.FontSize = Enum.FontSize.Size11
                        Input.TextWrapped = true
                        Input.TextSize = 11
                        Input.TextWrap = true
                        Input.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Input.Text = ""
                        Input.PlaceholderText = Data.Text
                        Input.Font = Enum.Font.Gotham
                        Input.TextXAlignment = Enum.TextXAlignment.Left
                        Input.ClearTextOnFocus = false
                        Input.Parent = Textbox
                        Input.Visible = false
                        Input.TextTransparency = 1
                        
                        local TextboxIcon = Instance.new("ImageLabel")
                        TextboxIcon.Name = "TextboxIcon"
                        TextboxIcon.Size = UDim2.new(0, 20, 0, 20)
                        TextboxIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        TextboxIcon.BackgroundTransparency = 1
                        TextboxIcon.Position = UDim2.new(0.94, 0, 0, 3)
                        TextboxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxIcon.ImageColor3 = Color3.fromRGB(47, 47, 47)
                        TextboxIcon.ImageRectOffset = Vector2.new(100, 0)
                        TextboxIcon.ImageRectSize = Vector2.new(100, 100)
                        TextboxIcon.Image = "rbxassetid://6764432293"
                        TextboxIcon.Parent = Textbox
                        
                        local UICorner = Instance.new("UICorner")
                        UICorner.CornerRadius = UDim.new(0, 5)
                        UICorner.Parent = Textbox
                        
                        local TextboxName = Instance.new("TextLabel")
                        TextboxName.Name = "TextboxName"
                        TextboxName.Size = UDim2.new(0, 258, 0, 26)
                        TextboxName.BackgroundTransparency = 1
                        TextboxName.Position = UDim2.new(0.0208334, 0, 0, 0)
                        TextboxName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxName.FontSize = Enum.FontSize.Size11
                        TextboxName.TextSize = 11
                        TextboxName.RichText = true
                        TextboxName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxName.Text = Data.Name
                        TextboxName.Font = Enum.Font.Gotham
                        TextboxName.TextXAlignment = Enum.TextXAlignment.Left
                        TextboxName.Parent = Textbox
                        
                        local Line = Instance.new("Frame")
                        Line.Name = "Line"
                        Line.Size = UDim2.new(0, 371, 0, 1)
                        Line.Position = UDim2.new(0, 9, 0, 26)
                        Line.BorderSizePixel = 0
                        Line.BackgroundColor3 = Color3.fromRGB(74, 74, 74)
                        Line.Parent = Textbox
                        Line.Visible = false

                        Textbox.MouseEnter:Connect(function(x, y)
                            TweenService:Create(TextboxIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                            TweenService:Create(Textbox, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 51)}):Play()
                            TweenService:Create(Input, TweenInfo.new(.25), {TextTransparency = 0}):Play()
                            Input.Visible = true
                            Line.Visible = true
                        end)

                        Textbox.MouseLeave:Connect(function(x, y)
                            while Input:IsFocused() do
                                task.wait()
                            end
                            TweenService:Create(TextboxIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                            TweenService:Create(Textbox, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 26)}):Play()
                            TweenService:Create(Input, TweenInfo.new(.25), {TextTransparency = 1}):Play()
                            Input.Visible = false
                            Line.Visible = false
                        end)

                        local PrevText = Data.Text

                        Input.FocusLost:Connect(function()
                            local Number = tonumber(Input.Text)
                            if Data.NumOnly and Number then
                                PrevText = Input.Text
                                Callback(Number)
                            elseif Data.NumOnly and not Number then
                                Input.Text = PrevText
                            else
                                PrevText = Input.Text
                                Callback(Input.Text)
                            end
                        end)
                    end

                    InputLibrary.CreateSlider = function(Callback, Data: table)
                        local Slider = Instance.new("TextButton")
                        Slider.Name = Data.Name
                        Slider.Size = UDim2.new(0, 389, 0, 26)
                        Slider.Position = UDim2.new(0.024, 0, 0.675, 0)
                        Slider.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Slider.AutoButtonColor = false
                        Slider.FontSize = Enum.FontSize.Size14
                        Slider.TextSize = 14
                        Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
                        Slider.Text = ""
                        Slider.Font = Enum.Font.SourceSans
                        Slider.Parent = Section
                        table.insert(Inputs, Slider)

                        local UICorner = Instance.new("UICorner")
                        UICorner.CornerRadius = UDim.new(0, 5)
                        UICorner.Parent = Slider

                        local SliderIcon = Instance.new("ImageLabel")
                        SliderIcon.Name = "SliderIcon"
                        SliderIcon.Size = UDim2.new(0, 20, 0, 20)
                        SliderIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        SliderIcon.BackgroundTransparency = 1
                        SliderIcon.Position = UDim2.new(0.94, 0, 0, 3)
                        SliderIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        SliderIcon.ImageColor3 = Color3.fromRGB(74, 74, 74)
                        SliderIcon.ImageRectOffset = Vector2.new(100, 400)
                        SliderIcon.ImageRectSize = Vector2.new(100, 100)
                        SliderIcon.Image = "rbxassetid://6764432293"
                        SliderIcon.Parent = Slider

                        local SliderName = Instance.new("TextLabel")
                        SliderName.Name = "SliderName"
                        SliderName.Size = UDim2.new(0, 258, 0, 26)
                        SliderName.BackgroundTransparency = 1
                        SliderName.Position = UDim2.new(0.0208334, 0, 0, 0)
                        SliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        SliderName.FontSize = Enum.FontSize.Size11
                        SliderName.TextSize = 11
                        SliderName.RichText = true
                        SliderName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        SliderName.Text = Data.Name
                        SliderName.Font = Enum.Font.Gotham
                        SliderName.TextXAlignment = Enum.TextXAlignment.Left
                        SliderName.Parent = Slider

                        local SliderValue = Instance.new("TextLabel")
                        SliderValue.Name = "SliderValue"
                        SliderValue.Size = UDim2.new(0, 96, 0, 26)
                        SliderValue.BackgroundTransparency = 1
                        SliderValue.Position = UDim2.new(0.6840724, 0, 0, 0)
                        SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        SliderValue.FontSize = Enum.FontSize.Size11
                        SliderValue.TextSize = 11
                        SliderValue.RichText = true
                        SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                        SliderValue.Text = tostring(Data.Current) .. "/" .. tostring(Data.Max)
                        SliderValue.Font = Enum.Font.Gotham
                        SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                        SliderValue.Parent = Slider

                        local Bg = Instance.new("Frame")
                        Bg.Name = "Bg"
                        Bg.Size = UDim2.new(0, 370, 0, 4)
                        Bg.Position = UDim2.new(0.024, 0, 0.675, 0)
                        Bg.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                        Bg.Parent = Slider
                        Bg.Visible = false

                        local UICorner1 = Instance.new("UICorner")
                        UICorner1.CornerRadius = UDim.new(0, 5)
                        UICorner1.Parent = Bg

                        local Slide = Instance.new("Frame")
                        Slide.Name = "Slide"
                        Slide.Size = UDim2.new((Data.Current - math.abs(Data.Min))/(Data.Max - math.abs(Data.Min)), 0, 0, 4)
                        Slide.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                        Slide.Parent = Bg
                        Slide.BorderSizePixel = 0

                        local UICorner2 = Instance.new("UICorner")
                        UICorner2.CornerRadius = UDim.new(0, 5)
                        UICorner2.Parent = Slide

                        local MouseDown, Floor, EndInput = false, function(...)
                            return Data.Precise and tonumber(string.format("%.2f", ...)) or math.floor(...)
                        end

                        Slider.MouseButton1Down:Connect(function(x, y)
                            MouseDown = true
                            Slide:TweenSize(
                                UDim2.new(0, math.clamp(Mouse.X - Bg.AbsolutePosition.X, 0, Bg.AbsoluteSize.X), 0, 4),
                                Enum.EasingDirection.InOut,
                                Enum.EasingStyle.Linear,
                                0.1,
                                true, function()
                                    Data.Current = Floor(((Slide.AbsoluteSize.X / Bg.AbsoluteSize.X) * (Data.Max - Data.Min)) + Data.Min)
                                    Callback(Data.Current)
                                    SliderValue.Text = tostring(Data.Current) .. "/" .. tostring(Data.Max)
                                end
                            )
                            local MouseMoved = Mouse.Move:Connect(function()
                                Slide:TweenSize(
                                    UDim2.new(0, math.clamp(Mouse.X - Bg.AbsolutePosition.X, 0, Bg.AbsoluteSize.X), 0, 4),
                                    Enum.EasingDirection.InOut,
                                    Enum.EasingStyle.Linear,
                                    0.1,
                                    true, function()
                                        Data.Current = Floor(((Slide.AbsoluteSize.X / Bg.AbsoluteSize.X) * (Data.Max - Data.Min)) + Data.Min)
                                        Callback(Data.Current)
                                        SliderValue.Text = tostring(Data.Current) .. "/" .. tostring(Data.Max)
                                    end
                                )
                            end)
                            EndInput = UserInputService.InputEnded:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    MouseDown = false
                                    MouseMoved:Disconnect()
                                    EndInput:Disconnect()
                                end
                            end)
                        end)

                        Slider.MouseEnter:Connect(function(x, y)
                            TweenService:Create(SliderIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                            TweenService:Create(Slider, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 46)}):Play()
                            Bg.Visible = true
                        end)

                        Slider.MouseLeave:Connect(function(x, y)
                            while MouseDown do
                                task.wait()
                            end
                            TweenService:Create(SliderIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                            TweenService:Create(Slider, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 26)}):Play()
                            Bg.Visible = false
                        end)
                    end

                    InputLibrary.CreateKeyBind = function(Callback, Data: table)
                        local Textbox = Instance.new("Frame")
                        Textbox.Name = Data.Name
                        Textbox.Size = UDim2.new(0, 389, 0, 26)
                        Textbox.Position = UDim2.new(0.0113065, 0, 0.5679013, 0)
                        Textbox.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                        Textbox.Parent = Section
                        table.insert(Inputs, Textbox)
                        
                        local Input = Instance.new("TextBox")
                        Input.Name = "Input"
                        Input.Size = UDim2.new(0, 348, 0, 21)
                        Input.BackgroundTransparency = 1
                        Input.Position = UDim2.new(0.024, 0, 0.5306122, 0)
                        Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Input.FontSize = Enum.FontSize.Size11
                        Input.TextWrapped = true
                        Input.TextSize = 11
                        Input.TextWrap = true
                        Input.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Input.Text = ""
                        Input.PlaceholderText = tostring(Data.KeyBind)
                        Input.Font = Enum.Font.Gotham
                        Input.TextXAlignment = Enum.TextXAlignment.Left
                        Input.ClearTextOnFocus = false
                        Input.Parent = Textbox
                        Input.Visible = false
                        Input.TextTransparency = 1
                        
                        local TextboxIcon = Instance.new("ImageLabel")
                        TextboxIcon.Name = "TextboxIcon"
                        TextboxIcon.Size = UDim2.new(0, 20, 0, 20)
                        TextboxIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                        TextboxIcon.BackgroundTransparency = 1
                        TextboxIcon.Position = UDim2.new(0.94, 0, 0, 3)
                        TextboxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxIcon.ImageColor3 = Color3.fromRGB(47, 47, 47)
                        TextboxIcon.ImageRectOffset = Vector2.new(300, 300)
                        TextboxIcon.ImageRectSize = Vector2.new(100, 100)
                        TextboxIcon.Image = "rbxassetid://6764432293"
                        TextboxIcon.Parent = Textbox
                        
                        local UICorner = Instance.new("UICorner")
                        UICorner.CornerRadius = UDim.new(0, 5)
                        UICorner.Parent = Textbox
                        
                        local TextboxName = Instance.new("TextLabel")
                        TextboxName.Name = "TextboxName"
                        TextboxName.Size = UDim2.new(0, 258, 0, 26)
                        TextboxName.BackgroundTransparency = 1
                        TextboxName.Position = UDim2.new(0.0208334, 0, 0, 0)
                        TextboxName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxName.FontSize = Enum.FontSize.Size11
                        TextboxName.TextSize = 11
                        TextboxName.RichText = true
                        TextboxName.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextboxName.Text = Data.Name
                        TextboxName.Font = Enum.Font.Gotham
                        TextboxName.TextXAlignment = Enum.TextXAlignment.Left
                        TextboxName.Parent = Textbox
                        
                        local Line = Instance.new("Frame")
                        Line.Name = "Line"
                        Line.Size = UDim2.new(0, 371, 0, 1)
                        Line.Position = UDim2.new(0, 9, 0, 26)
                        Line.BorderSizePixel = 0
                        Line.BackgroundColor3 = Color3.fromRGB(74, 74, 74)
                        Line.Parent = Textbox
                        Line.Visible = false

                        Textbox.MouseEnter:Connect(function(x, y)
                            TweenService:Create(TextboxIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(31, 96, 166)}):Play()
                            TweenService:Create(Textbox, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 51)}):Play()
                            TweenService:Create(Input, TweenInfo.new(.25), {TextTransparency = 0}):Play()
                            Input.Visible = true
                            Line.Visible = true
                        end)

                        Textbox.MouseLeave:Connect(function(x, y)
                            while Input:IsFocused() do
                                task.wait()
                            end
                            TweenService:Create(TextboxIcon, TweenInfo.new(.25), {ImageColor3 = Color3.fromRGB(74, 74, 74)}):Play()
                            TweenService:Create(Textbox, TweenInfo.new(.25), {Size = UDim2.new(0, 389, 0, 26)}):Play()
                            TweenService:Create(Input, TweenInfo.new(.25), {TextTransparency = 1}):Play()
                            Input.Visible = false
                            Line.Visible = false
                        end)

                        Input.Focused:Connect(function()
                            Data.Connection = UserInputService.InputEnded:Connect(function(UserInput)
                                if UserInput.KeyCode == Enum.KeyCode.Unknown then return end
                                Data.KeyBind = UserInput.KeyCode
                                Input.Text = tostring(Data.KeyBind)
                            end)
                        end)
        
                        Input.FocusLost:Connect(function()
                            Data.Connection:Disconnect()
                        end)
                        
                        UserInputService.InputBegan:Connect(function(UserInput)
                            if UserInput.KeyCode == Data.KeyBind then
                                Callback()
                                task.wait(1)
                                if UserInputService:IsKeyDown(Data.KeyBind) then
                                    while UserInputService:IsKeyDown(Data.KeyBind) do
                                        Callback()
                                        task.wait()
                                    end
                                end
                            end
                        end)
                    end

                    return InputLibrary
                end

                return SectionLibrary
            end

            ChannelLibrary.CreateNotif = function(Name: string, ImageRectOffset: Vector2, TextDescription: string, Options: string)
                local Notif = Instance.new("Frame")
                Notif.Name = "Notif"
                Notif.Size = UDim2.new(1, 0, 1, 0)
                Notif.BackgroundTransparency = 0.6
                Notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Notif.Parent = Frame

                local UICorner = Instance.new("UICorner")
                UICorner.Parent = Notif

                local Inner = Instance.new("Frame")
                Inner.Name = "Inner"
                Inner.Size = UDim2.new(0, 380, 0, 242)
                Inner.Position = UDim2.new(0.1678322, 0, 0.1355422, 0)
                Inner.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
                Inner.Parent = Notif

                local UICorner1 = Instance.new("UICorner")
                UICorner1.Parent = Inner

                local Title = Instance.new("TextLabel")
                Title.Name = "Title"
                Title.Size = UDim2.new(0, 380, 0, 29)
                Title.BackgroundTransparency = 1
                Title.Position = UDim2.new(-0.0005889, 0, 0.0281042, 0)
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.FontSize = Enum.FontSize.Size18
                Title.TextSize = 15
                Title.RichText = true
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.Text = Name
                Title.Font = Enum.Font.SourceSansBold
                Title.Parent = Inner

                local Description = Instance.new("TextLabel")
                Description.Name = "Description"
                Description.Size = UDim2.new(0, 342, 0, 87)
                Description.BackgroundTransparency = 1
                Description.Position = UDim2.new(0.0484174, 0, 0.455591, 0)
                Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Description.FontSize = Enum.FontSize.Size18
                Description.TextSize = 15
                Description.RichText = true
                Description.TextColor3 = Color3.fromRGB(255, 255, 255)
                Description.Text = TextDescription
                Description.TextYAlignment = Enum.TextYAlignment.Top
                Description.TextWrapped = true
                Description.Font = Enum.Font.SourceSansBold
                Description.TextWrap = true
                Description.TextXAlignment = Enum.TextXAlignment.Left
                Description.Parent = Inner

                local Buttons = Instance.new("Frame")
                Buttons.Name = "Buttons"
                Buttons.Size = UDim2.new(0, 379, 0, 25)
                Buttons.BackgroundTransparency = 1
                Buttons.Position = UDim2.new(0, 0, 0.8719008, 0)
                Buttons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Buttons.Parent = Inner

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.FillDirection = Enum.FillDirection.Horizontal
                UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 6)
                UIListLayout.Parent = Buttons

                local UIPadding = Instance.new("UIPadding")
                UIPadding.PaddingRight = UDim.new(0, 6)
                UIPadding.Parent = Buttons

                local Warning = Instance.new("ImageLabel")
                Warning.Name = "Warning"
                Warning.Size = UDim2.new(0, 82, 0, 82)
                Warning.BackgroundTransparency = 1
                Warning.Position = UDim2.new(0.39, 0, 0.121, 0)
                Warning.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Warning.ImageColor3 = Color3.fromRGB(155, 250, 255)
                Warning.ImageRectOffset = ImageRectOffset or Vector2.new(0, 600)
                Warning.ImageRectSize = Vector2.new(100, 100)
                Warning.Image = "rbxassetid://6764432293"
                Warning.Parent = Inner

                for i,v in next, Options do
                    local ActionButton = Instance.new("TextButton")
                    ActionButton.Name = "ActionButton"
                    ActionButton.Size = UDim2.new(0, 80, 0, 25)
                    ActionButton.Position = UDim2.new(0.6168845, 0, 0, 0)
                    ActionButton.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                    ActionButton.AutoButtonColor = false
                    ActionButton.FontSize = Enum.FontSize.Size14
                    ActionButton.TextSize = 14
                    ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ActionButton.Text = ""
                    ActionButton.Font = Enum.Font.SourceSansBold
                    ActionButton.Parent = Buttons

                    local UICorner2 = Instance.new("UICorner")
                    UICorner2.CornerRadius = UDim.new(0, 6)
                    UICorner2.Parent = ActionButton

                    local ActionName = Instance.new("TextLabel")
                    ActionName.Name = "ActionName"
                    ActionName.Size = UDim2.new(0, 57, 0, 25)
                    ActionName.BackgroundTransparency = 1
                    ActionName.Position = UDim2.new(0.1232986, 0, 0, 0)
                    ActionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ActionName.FontSize = Enum.FontSize.Size14
                    ActionName.TextSize = 14
                    ActionName.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ActionName.Text = v.Text
                    ActionName.Font = Enum.Font.SourceSansBold
                    ActionName.TextXAlignment = Enum.TextXAlignment.Left
                    ActionName.Parent = ActionButton

                    local Icon = Instance.new("ImageLabel")
                    Icon.Name = "Icon"
                    Icon.Size = UDim2.new(0, 20, 0, 20)
                    Icon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    Icon.BackgroundTransparency = 1
                    Icon.Position = UDim2.new(0.73, 0, 0.1, 0)
                    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Icon.ImageColor3 = Color3.fromRGB(124, 124, 124)
                    Icon.ImageRectOffset = Vector2.new(400, 0)
                    Icon.ImageRectSize = Vector2.new(100, 100)
                    Icon.Image = "rbxassetid://6764432293"
                    Icon.Parent = ActionButton

                    ActionButton.MouseButton1Down:Connect(function(x, y)
                        if v.Close then
                            Notif:Destroy()
                        end
                        v.Callback()
                    end)
                end
            end

            return ChannelLibrary
        end

        return CategoryLibrary
    end

    return GuildLibrary
end

return Library.Module