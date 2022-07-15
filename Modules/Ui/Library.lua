local Themes = import("Ui/Themes.lua")

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local Library = {
    Tabs = {},
    LayoutOrder = 0
}

getgenv().iuaghsf = 1

local function dragify(Frame)
    local dragToggle = nil
    local dragSpeed = .25
    local dragInput = nil
    local dragStart = nil
    local dragPos = nil
    local startPos = nil

    local function updateInput(input)
        local Delta = input.Position - dragStart
        local Position =
            UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        TweenService:Create(Frame, TweenInfo.new(.25), {Position = Position}):Play()
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

Library.CreateGui = function(self, UiName)
    local LibraryGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    dragify(Main)
    local Main_UICorner = Instance.new("UICorner")
    local Tabs = Instance.new("Frame")
    local Tabs_UICorner = Instance.new("UICorner")
    local Main_UIStroke = Instance.new("UIStroke")
    local Separator = Instance.new("Frame")
    local Black = Instance.new("Frame")
    local Black_UICorner = Instance.new("UICorner")
    local TabSelection = Instance.new("Frame")
    local Selection_Darker = Instance.new("Frame")
    local TabSelection_UICorner = Instance.new("UICorner")
    local Tab_Selection = Instance.new("Frame")
    local Selection_UIListLayout = Instance.new("UIListLayout")
    local Selection_UIPadding = Instance.new("UIPadding")
    local Selection_UICorner = Instance.new("UICorner")
    local TabSelectionOpener = Instance.new("ImageButton")
    local Name = Instance.new("TextLabel")
    local TabName = Instance.new("TextLabel")

    LibraryGui.Name = "LibraryGui"
    LibraryGui.Parent = game:GetService("CoreGui")
    LibraryGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Main.Name = "Main"
    Main.Size = UDim2.new(0, 360, 0, 335)
    Main.Position = UDim2.new(0.5985599, 0, 0.2883009, 0)
    Main.BackgroundColor3 = Themes.FindColor(30, 30, 30)
    Main.Parent = LibraryGui
    Main.ClipsDescendants = true

    Main_UICorner.Name = "Main_UICorner"
    Main_UICorner.Parent = Main

    Main_UIStroke.Name = "Main_UIStroke"
    Main_UIStroke.Color = Color3.fromRGB(75, 75, 75)
    Main_UIStroke.Parent = Main

    Tabs.Name = "Tabs"
    Tabs.Size = UDim2.new(0, 343, 0, 296)
    Tabs.Position = UDim2.new(0.0269999, 0, 0.085, 0)
    Tabs.BackgroundColor3 = Themes.FindColor(25, 25, 25)
    Tabs.Parent = Main

    Tabs_UICorner.Name = "Tabs_UICorner"
    Tabs_UICorner.CornerRadius = UDim.new(0, 6)
    Tabs_UICorner.Parent = Tabs

    Separator.Name = "Separator "
    Separator.Size = UDim2.new(0, 340, 0, 1)
    Separator.Position = UDim2.new(0.0272222, 0, 0.0580597, 0)
    Separator.BorderSizePixel = 0
    Separator.BackgroundColor3 = Themes.FindColor(45, 45, 45)
    Separator.Parent = Main

    Black.Name = "Black"
    Black.Size = UDim2.new(0, 360, 0, 335)
    Black.BackgroundTransparency = 0.7
    Black.BackgroundColor3 = Themes.FindColor(0, 0, 0)
    Black.Parent = Main
    Black.ZIndex = 11

    Black_UICorner.Name = "Black_UICorner"
    Black_UICorner.Parent = Black

    TabSelection.Name = "TabSelection"
    TabSelection.Size = UDim2.new(0, 0, 0, 335)
    TabSelection.BorderSizePixel = 0
    TabSelection.BackgroundColor3 = Themes.FindColor(35, 35, 35)
    TabSelection.Parent = Main
    TabSelection.ClipsDescendants = true
    TabSelection.ZIndex = 10

    Selection_Darker.Name = "Selection_Darker"
    Selection_Darker.Size = UDim2.new(0, 10, 0, 335)
    Selection_Darker.Position = UDim2.new(0.9230769, 0, 0, 0)
    Selection_Darker.BorderSizePixel = 0
    Selection_Darker.BackgroundColor3 = Themes.FindColor(35, 35, 35)
    Selection_Darker.Parent = TabSelection

    TabSelection_UICorner.Name = "TabSelection_UICorner"
    TabSelection_UICorner.Parent = TabSelection

    Tab_Selection.Name = "Tab_Selection"
    Tab_Selection.Size = UDim2.new(0, 111, 0, 299)
    Tab_Selection.Position = UDim2.new(0.0692308, 0, 0.0841221, 0)
    Tab_Selection.BackgroundColor3 = Themes.FindColor(40, 40, 40)
    Tab_Selection.Parent = TabSelection

    Selection_UIListLayout.Name = "Selection_UIListLayout"
    Selection_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Selection_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    Selection_UIListLayout.Padding = UDim.new(0, 3)
    Selection_UIListLayout.Parent = Tab_Selection

    Selection_UIPadding.Name = "Selection_UIPadding"
    Selection_UIPadding.PaddingTop = UDim.new(0, 3)
    Selection_UIPadding.Parent = Tab_Selection

    Selection_UICorner.Name = "Selection_UICorner"
    Selection_UICorner.CornerRadius = UDim.new(0, 5)
    Selection_UICorner.Parent = Tab_Selection

    TabSelectionOpener.Name = "TabSelectionOpener"
    TabSelectionOpener.LayoutOrder = 6
    TabSelectionOpener.ZIndex = 2
    TabSelectionOpener.Size = UDim2.new(0, 18, 0, 18)
    TabSelectionOpener.BackgroundTransparency = 1
    TabSelectionOpener.Position = UDim2.new(0.025, 0, 0.005, 0)
    TabSelectionOpener.ImageColor3 = Color3.fromRGB(155, 155, 155)
    TabSelectionOpener.ImageRectOffset = Vector2.new(604, 684)
    TabSelectionOpener.Image = "rbxassetid://3926305904"
    TabSelectionOpener.ImageRectSize = Vector2.new(36, 36)
    TabSelectionOpener.Parent = Main
    TabSelectionOpener.ZIndex = 11

    Name.Name = "Name"
    Name.Size = UDim2.new(0, 259, 0, 20)
    Name.BackgroundTransparency = 1
    Name.Position = UDim2.new(0.0944444, 0, 0, 0)
    Name.BackgroundColor3 = Themes.FindColor(255, 255, 255)
    Name.FontSize = Enum.FontSize.Size12
    Name.TextSize = 12
    Name.TextColor3 = Color3.fromRGB(255, 255, 255)
    Name.Text = Themes.Logo()
    Name.Font = Enum.Font.Gotham
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.Parent = Main

    TabName.Name = "TabName"
    TabName.Size = UDim2.new(0, 116, 0, 20)
    TabName.BackgroundTransparency = 1
    TabName.Position = UDim2.new(0.625, 0, 0, 0)
    TabName.BackgroundColor3 = Themes.FindColor(255, 255, 255)
    TabName.FontSize = Enum.FontSize.Size11
    TabName.TextSize = 11
    TabName.TextColor3 = Color3.fromRGB(155, 155, 155)
    TabName.Text = "Tab"
    TabName.Font = Enum.Font.Gotham
    TabName.TextXAlignment = Enum.TextXAlignment.Right
    TabName.Parent = Main

    local TabSelectorOpen = false

    TabSelectionOpener.MouseButton1Down:Connect(function()
        TabSelectorOpen = not TabSelectorOpen
        TabSelection:TweenSize(
            TabSelectorOpen and UDim2.new(0, 130 * iuaghsf, 0, 335 * iuaghsf) or UDim2.new(0, 0, 0, 335 * iuaghsf),
            Enum.EasingDirection.InOut,
            Enum.EasingStyle.Linear,
            0.2
        )
    end)

    local LibraryTabs = {}

    LibraryTabs.CreateTab = function(self, Name)
        local Tab_Button_UICorner = Instance.new("UICorner")
        local Tab_Button = Instance.new("TextButton")
        local Tab_Button_TextLabel = Instance.new("TextLabel")
        local Tab = Instance.new("ScrollingFrame")
        local Tab_UIListLayout = Instance.new("UIListLayout")
        local Tab_UIPadding = Instance.new("UIPadding")

        Tab_Button.Name = "Tab_Button"
        Tab_Button.Size = UDim2.new(0, 106, 0, 18)
        Tab_Button.Position = UDim2.new(0.045045, 0, 0, 0)
        Tab_Button.BackgroundColor3 = Themes.FindColor(45, 45, 45)
        Tab_Button.FontSize = Enum.FontSize.Size14
        Tab_Button.TextSize = 14
        Tab_Button.TextColor3 = Color3.fromRGB(0, 0, 0)
        Tab_Button.Text = ""
        Tab_Button.Font = Enum.Font.SourceSans
        Tab_Button.Parent = Tab_Selection

        Tab_Button_UICorner.Name = "Tab_Button_UICorner"
        Tab_Button_UICorner.CornerRadius = UDim.new(0, 5)
        Tab_Button_UICorner.Parent = Tab_Button

        Tab_Button_TextLabel.Name = "Tab_Button_TextLabel"
        Tab_Button_TextLabel.Size = UDim2.new(0, 99, 0, 18)
        Tab_Button_TextLabel.BackgroundTransparency = 1
        Tab_Button_TextLabel.Position = UDim2.new(0.0641508, 0, 0, 0)
        Tab_Button_TextLabel.BackgroundColor3 = Themes.FindColor(255, 255, 255)
        Tab_Button_TextLabel.FontSize = Enum.FontSize.Size10
        Tab_Button_TextLabel.TextSize = 10
        Tab_Button_TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab_Button_TextLabel.Text = Name
        Tab_Button_TextLabel.Font = Enum.Font.Gotham
        Tab_Button_TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        Tab_Button_TextLabel.Parent = Tab_Button

        Tab.Name = "Tab"
        Tab.Size = UDim2.new(0, 343, 0, 0)
        Tab.BackgroundTransparency = 1
        Tab.Active = true
        Tab.Visible = false
        Tab.BorderSizePixel = 0
        Tab.BackgroundColor3 = Themes.FindColor(255, 255, 255)
        Tab.ScrollBarThickness = 3
        Tab.Parent = Tabs

        Tab_UIListLayout.Name = "Tab_UIListLayout"
        Tab_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        Tab_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        Tab_UIListLayout.Padding = UDim.new(0, 5)
        Tab_UIListLayout.Parent = Tab

        Tab_UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Tab.CanvasSize = UDim2.new(0, 0 * iuaghsf, 0, Tab_UIListLayout.AbsoluteContentSize.Y + 6)
        end)

        Tab_UIPadding.Name = "Tab_UIPadding"
        Tab_UIPadding.PaddingTop = UDim.new(0, 5)
        Tab_UIPadding.Parent = Tab

        table.insert(Library.Tabs, Tab)

        Tab_Button.MouseButton1Down:Connect(function()
            TabSelectorOpen = not TabSelectorOpen
            TabSelection:TweenSize(
                TabSelectorOpen and UDim2.new(0, 130 * iuaghsf, 0, 335 * iuaghsf) or UDim2.new(0, 0, 0, 335 * iuaghsf),
                Enum.EasingDirection.InOut,
                Enum.EasingStyle.Linear,
                0.2
            )
            table.foreach(Library.Tabs, function(i, v)
                coroutine.resume(coroutine.create(function()
                    v:TweenSize(
                        UDim2.new(0, 0, 0, 0),
                        Enum.EasingDirection.InOut,
                        Enum.EasingStyle.Linear,
                        0.2
                    )
                    task.wait(0.2)
                    v.Visible = false
                end))
            end)
            task.wait(0.22)
            Tab.Visible = true
            Tab:TweenSize(
                UDim2.new(0, 343 * iuaghsf, 0, 296 * iuaghsf),
                Enum.EasingDirection.InOut,
                Enum.EasingStyle.Linear,
                0.2
            )
            TabName.Text = Name
        end)

        local LibrarySections = {}

        LibrarySections.CreateSection = function(self, Name)
            local Section_Name = Instance.new("TextLabel")
            local Section = Instance.new("Frame")
            local Section_UICorner = Instance.new("UICorner")
            local Section_UIStroke = Instance.new("UIStroke")
            local Section_UIListLayout = Instance.new("UIListLayout")
            local Section_UIPadding = Instance.new("UIPadding")

            Section_Name.Name = "Section_Name"
            Section_Name.Size = UDim2.new(0, 326, 0, 11)
            Section_Name.BackgroundTransparency = 1
            Section_Name.Position = UDim2.new(0.0247813, 0, 0, 0)
            Section_Name.BackgroundColor3 = Themes.FindColor(255, 255, 255)
            Section_Name.FontSize = Enum.FontSize.Size10
            Section_Name.TextSize = 10
            Section_Name.TextColor3 = Color3.fromRGB(185, 185, 185)
            Section_Name.Text = Name
            Section_Name.Font = Enum.Font.Gotham
            Section_Name.TextXAlignment = Enum.TextXAlignment.Left
            Section_Name.Parent = Tab

            Section.Name = "Section"
            Section.Size = UDim2.new(0, 332, 0, 0)
            Section.Position = UDim2.new(0.016035, 0, 0.0549828, 0)
            Section.BackgroundColor3 = Themes.FindColor(22, 22, 22)
            Section.Parent = Tab

            Section_UICorner.Name = "Section_UICorner"
            Section_UICorner.CornerRadius = UDim.new(0, 6)
            Section_UICorner.Parent = Section

            Section_UIStroke.Name = "Section_UIStroke"
            Section_UIStroke.Color = Color3.fromRGB(40, 40, 40)
            Section_UIStroke.Parent = Section

            Section_UIListLayout.Name = "Section_UIListLayout"
            Section_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            Section_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            Section_UIListLayout.Padding = UDim.new(0, 5)
            Section_UIListLayout.Parent = Section

            Section_UIPadding.Name = "Section_UIPadding"
            Section_UIPadding.PaddingTop = UDim.new(0, 3)
            Section_UIPadding.Parent = Section

            Section_UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                Section.Size = UDim2.new(0, 332 * iuaghsf, 0, Section_UIListLayout.AbsoluteContentSize.Y + 6)
            end)

            local LibraryFunctions = {}

            LibraryFunctions.CreateButton = function(self, callback, data)
                local Section_Button = Instance.new("Frame")
                local Section_Button_UICorner = Instance.new("UICorner")
                local Section_Button_TextButton = Instance.new("TextButton")
                local Section_Button_UIStroke = Instance.new("UIStroke")

                Section_Button.Name = "Section_Button"
                Section_Button.Size = UDim2.new(0, 326, 0, 23)
                Section_Button.BackgroundTransparency = 1
                Section_Button.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Button.Parent = Section
                Section_Button.LayoutOrder = Library.LayoutOrder
                Library.LayoutOrder = Library.LayoutOrder + 1

                Section_Button_UICorner.Name = "Section_Button_UICorner"
                Section_Button_UICorner.CornerRadius = UDim.new(0, 6)
                Section_Button_UICorner.Parent = Section_Button

                Section_Button_UIStroke.Name = "Section_Button_UIStroke"
                Section_Button_UIStroke.Color = Color3.fromRGB(50, 50, 50)
                Section_Button_UIStroke.Parent = Section_Button

                Section_Button_TextButton.Name = "Section_Button_TextButton"
                Section_Button_TextButton.Size = UDim2.new(0, 326, 0, 23)
                Section_Button_TextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
                Section_Button_TextButton.BackgroundTransparency = 1
                Section_Button_TextButton.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Button_TextButton.FontSize = Enum.FontSize.Size11
                Section_Button_TextButton.TextSize = 11
                Section_Button_TextButton.Text = data.Name
                Section_Button_TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                Section_Button_TextButton.Font = Enum.Font.Gotham
                Section_Button_TextButton.Parent = Section_Button

                Section_Button_TextButton.MouseButton1Down:Connect(function()
                    TweenService:Create(Section_Button_TextButton, TweenInfo.new(0.2), {Rotation = 360}):Play()
                    callback()
                    task.wait(0.22)
                    Section_Button_TextButton.Rotation = 0
                end)

                local ButtonFunctions = {}

                ButtonFunctions.Update = function(self, Name)
                    data.Name = Name
                    Section_Button_TextButton.Text = data.Name
                end

                return ButtonFunctions
            end

            LibraryFunctions.CreateToggle = function(self, callback, data)
                local Section_Toggle = Instance.new("Frame")
                Section_Toggle.Name = "Section_Toggle"
                Section_Toggle.Size = UDim2.new(0, 326, 0, 23)
                Section_Toggle.BackgroundTransparency = 1
                Section_Toggle.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Toggle.Parent = Section
                Section_Toggle.LayoutOrder = Library.LayoutOrder
                Library.LayoutOrder = Library.LayoutOrder + 1

                local Section_Toggle_UIStroke = Instance.new("UIStroke")
                Section_Toggle_UIStroke.Name = "Section_Toggle_UIStroke"
                Section_Toggle_UIStroke.Color = Color3.fromRGB(50, 50, 50)
                Section_Toggle_UIStroke.Parent = Section_Toggle

                local Section_Toggle_UICorner = Instance.new("UICorner")
                Section_Toggle_UICorner.Name = "Section_Toggle_UICorner"
                Section_Toggle_UICorner.CornerRadius = UDim.new(0, 6)
                Section_Toggle_UICorner.Parent = Section_Toggle

                local Section_Toggle_ClickDetection = Instance.new("TextButton")
                Section_Toggle_ClickDetection.Name = "Section_Toggle_ClickDetection"
                Section_Toggle_ClickDetection.Size = UDim2.new(0, 326, 0, 23)
                Section_Toggle_ClickDetection.BorderColor3 = Color3.fromRGB(27, 42, 53)
                Section_Toggle_ClickDetection.BackgroundTransparency = 1
                Section_Toggle_ClickDetection.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Toggle_ClickDetection.FontSize = Enum.FontSize.Size11
                Section_Toggle_ClickDetection.TextSize = 11
                Section_Toggle_ClickDetection.TextColor3 = Color3.fromRGB(150, 0, 255)
                Section_Toggle_ClickDetection.Text = ""
                Section_Toggle_ClickDetection.Font = Enum.Font.Gotham
                Section_Toggle_ClickDetection.Parent = Section_Toggle

                local Section_Toggle_ToggleName = Instance.new("TextLabel")
                Section_Toggle_ToggleName.Name = "Section_Toggle_ToggleName"
                Section_Toggle_ToggleName.Size = UDim2.new(0, 317, 0, 23)
                Section_Toggle_ToggleName.BackgroundTransparency = 1
                Section_Toggle_ToggleName.Position = UDim2.new(0.0266872, 0, 0, 0)
                Section_Toggle_ToggleName.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Toggle_ToggleName.FontSize = Enum.FontSize.Size11
                Section_Toggle_ToggleName.TextSize = 11
                Section_Toggle_ToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
                Section_Toggle_ToggleName.Text = data.Name
                Section_Toggle_ToggleName.Font = Enum.Font.Gotham
                Section_Toggle_ToggleName.TextXAlignment = Enum.TextXAlignment.Left
                Section_Toggle_ToggleName.Parent = Section_Toggle

                local Section_Toggle_ToggleCheck = Instance.new("Frame")
                Section_Toggle_ToggleCheck.Name = "Section_Toggle_ToggleCheck"
                Section_Toggle_ToggleCheck.Size = UDim2.new(0, 15, 0, 15)
                Section_Toggle_ToggleCheck.Position = UDim2.new(0.933, 0, 0.1599565, 0)
                Section_Toggle_ToggleCheck.BackgroundColor3 = Themes.FindColor(35, 34, 35)
                Section_Toggle_ToggleCheck.Parent = Section_Toggle

                local Section_Toggle_ToggleCheck_UIStroke = Instance.new("UIStroke")
                Section_Toggle_ToggleCheck_UIStroke.Name = "Section_Toggle_ToggleCheck_UIStroke"
                Section_Toggle_ToggleCheck_UIStroke.Color = Color3.fromRGB(50, 50, 50)
                Section_Toggle_ToggleCheck_UIStroke.Parent = Section_Toggle_ToggleCheck

                local Section_Toggle_ToggleCheck_UICorner = Instance.new("UICorner")
                Section_Toggle_ToggleCheck_UICorner.Name = "Section_Toggle_ToggleCheck_UICorner"
                Section_Toggle_ToggleCheck_UICorner.CornerRadius = UDim.new(0, 4)
                Section_Toggle_ToggleCheck_UICorner.Parent = Section_Toggle_ToggleCheck

                local Section_Toggle_ToggleCheck_Checked = Instance.new("ImageLabel")
                Section_Toggle_ToggleCheck_Checked.Name = "Section_Toggle_ToggleCheck_Checked"
                Section_Toggle_ToggleCheck_Checked.Size = UDim2.new(0, 11, 0, 11)
                Section_Toggle_ToggleCheck_Checked.BorderColor3 = Color3.fromRGB(27, 42, 53)
                Section_Toggle_ToggleCheck_Checked.BackgroundTransparency = 1
                Section_Toggle_ToggleCheck_Checked.Position = UDim2.new(0.2, 0, 0.078, 0)
                Section_Toggle_ToggleCheck_Checked.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Toggle_ToggleCheck_Checked.ImageRectOffset = Vector2.new(314, 2)
                Section_Toggle_ToggleCheck_Checked.ImageRectSize = Vector2.new(24, 24)
                Section_Toggle_ToggleCheck_Checked.Image = "rbxassetid://3926305904"
                Section_Toggle_ToggleCheck_Checked.Parent = Section_Toggle_ToggleCheck
                Section_Toggle_ToggleCheck_Checked.ImageTransparency = data.Value and 0 or 1

                Section_Toggle_ClickDetection.MouseButton1Down:Connect(function()
                    data.Value = not data.Value
                    callback(data.Value)
                    TweenService:Create(Section_Toggle_ToggleCheck_Checked, TweenInfo.new(0.2), {ImageTransparency = data.Value and 0 or 1}):Play()
                end)

                local ToggleFunctions = {}

                ToggleFunctions.Update = function(self, State)
                    data.Value = State
                    callback(data.Value)
                    TweenService:Create(Section_Toggle_ToggleCheck_Checked, TweenInfo.new(0.2), {ImageTransparency = data.Value and 0 or 1}):Play()
                end

                return ToggleFunctions
            end

            LibraryFunctions.CreateSlider = function(self, callback, data)
                local Section_Slider = Instance.new("Frame")
                Section_Slider.Name = "Section_Slider"
                Section_Slider.Size = UDim2.new(0, 326, 0, 37)
                Section_Slider.BackgroundTransparency = 1
                Section_Slider.Position = UDim2.new(0.0090361, 0, 0.7225807, 0)
                Section_Slider.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Slider.Parent = Section
                Section_Slider.LayoutOrder = Library.LayoutOrder
                Library.LayoutOrder = Library.LayoutOrder + 1
                
                local Section_Slider_UICorner = Instance.new("UICorner")
                Section_Slider_UICorner.Name = "Section_Slider_UICorner"
                Section_Slider_UICorner.CornerRadius = UDim.new(0, 6)
                Section_Slider_UICorner.Parent = Section_Slider
                
                local Section_Slider_UIStroke = Instance.new("UIStroke")
                Section_Slider_UIStroke.Name = "Section_Slider_UIStroke"
                Section_Slider_UIStroke.Color = Color3.fromRGB(50, 50, 50)
                Section_Slider_UIStroke.Parent = Section_Slider
                
                local Section_Slider_Name = Instance.new("TextLabel")
                Section_Slider_Name.Name = "Section_Slider_Name"
                Section_Slider_Name.Size = UDim2.new(0, 290, 0, 13)
                Section_Slider_Name.BackgroundTransparency = 1
                Section_Slider_Name.Position = UDim2.new(0.015, 0, 0.0539996, 0)
                Section_Slider_Name.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Slider_Name.FontSize = Enum.FontSize.Size10
                Section_Slider_Name.TextSize = 10
                Section_Slider_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
                Section_Slider_Name.Text = data.Name
                Section_Slider_Name.Font = Enum.Font.Gotham
                Section_Slider_Name.TextXAlignment = Enum.TextXAlignment.Left
                Section_Slider_Name.Parent = Section_Slider
                
                local Section_Slider_Total = Instance.new("TextBox")
                Section_Slider_Total.Name = "Section_Slider_Total"
                Section_Slider_Total.Size = UDim2.new(0, 43, 0, 13)
                Section_Slider_Total.BackgroundTransparency = 1
                Section_Slider_Total.Position = UDim2.new(0.86, 0, 0.054, 0)
                Section_Slider_Total.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Slider_Total.FontSize = Enum.FontSize.Size10
                Section_Slider_Total.TextSize = 10
                Section_Slider_Total.TextColor3 = Color3.fromRGB(255, 255, 255)
                Section_Slider_Total.Text = tostring(data.Current) .. "/" .. tostring(data.Max)
                Section_Slider_Total.Font = Enum.Font.Gotham
                Section_Slider_Total.TextXAlignment = Enum.TextXAlignment.Right
                Section_Slider_Total.Parent = Section_Slider
                Section_Slider_Total.PlaceholderText = "..."
                Section_Slider_Total.ZIndex = 5
                
                local Section_Slider_TextButton = Instance.new("TextButton")
                Section_Slider_TextButton.Name = "Section_Slider_TextButton"
                Section_Slider_TextButton.Size = UDim2.new(0, 316, 0, 3)
                Section_Slider_TextButton.Position = UDim2.new(0.015, 0, 0.75, 0)
                Section_Slider_TextButton.BorderSizePixel = 0
                Section_Slider_TextButton.BackgroundColor3 = Themes.FindColor(61, 60, 61)
                Section_Slider_TextButton.AutoButtonColor = false
                Section_Slider_TextButton.FontSize = Enum.FontSize.Size14
                Section_Slider_TextButton.TextSize = 14
                Section_Slider_TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                Section_Slider_TextButton.Text = ""
                Section_Slider_TextButton.Font = Enum.Font.SourceSans
                Section_Slider_TextButton.Parent = Section_Slider

                local Proxy_Slider_Button = Section_Slider_TextButton:Clone()
                Proxy_Slider_Button.Parent = Section_Slider_TextButton.Parent
                Proxy_Slider_Button.BackgroundTransparency = 1
                Proxy_Slider_Button.Size = UDim2.new(0, 316, 1, 0)
                Proxy_Slider_Button.Position = UDim2.new(0.015, 0, 0, 0)
                
                local Section_Slider_Frame = Instance.new("Frame")
                Section_Slider_Frame.Name = "Section_Slider_Frame"
                Section_Slider_Frame.Size = UDim2.new((data.Current - math.abs(data.Min))/(data.Max - math.abs(data.Min)), 0, 0, 3 * iuaghsf)
                Section_Slider_Frame.BorderSizePixel = 0
                Section_Slider_Frame.BackgroundColor3 = Themes.FindColor(80, 81, 82)
                Section_Slider_Frame.Parent = Section_Slider_TextButton

                local UpdatePossible = true

                Section_Slider_Total.Focused:Connect(function()
                    UpdatePossible = false
                end)

                Section_Slider_Total.FocusLost:Connect(function()
                    UpdatePossible = true
                    if tonumber(Section_Slider_Total.Text) then
                        data.Current = tonumber(Section_Slider_Total.Text)
                        Section_Slider_Total.Text = tostring(data.Current) .. "/" .. tostring(data.Max)
                        Section_Slider_Frame.Size = UDim2.new((data.Current - math.abs(data.Min))/(data.Max - math.abs(data.Min)), 0, 0, 3 * iuaghsf)
                        callback(data.Current)
                    else
                        Section_Slider_Total.Text = tostring(data.Current) .. "/" .. tostring(data.Max)
                        Section_Slider_Frame.Size = UDim2.new((data.Current - math.abs(data.Min))/(data.Max - math.abs(data.Min)), 0, 0, 3 * iuaghsf)
                    end
                end)

                local Floor = function(...)
                    return data.Precise and tonumber(string.format("%.2f", ...)) or math.floor(...)
                end

                Proxy_Slider_Button.MouseButton1Down:Connect(function(x, y)
                    UpdatePossible = false
                    Section_Slider_Frame:TweenSize(
                        UDim2.new(0, math.clamp(Mouse.X - Section_Slider_TextButton.AbsolutePosition.X, 0, Section_Slider_TextButton.AbsoluteSize.X), 0, 3 * iuaghsf),
                        Enum.EasingDirection.InOut,
                        Enum.EasingStyle.Linear,
                        0.1,
                        true, function()
                            data.Current = Floor(((Section_Slider_Frame.AbsoluteSize.X / Section_Slider_TextButton.AbsoluteSize.X) * (data.Max - data.Min)) + data.Min)
                            callback(data.Current)
                            Section_Slider_Total.Text = tostring(data.Current) .. "/" .. tostring(data.Max)
                        end
                    )
                    local MouseMoved = Mouse.Move:Connect(function()
                        Section_Slider_Frame:TweenSize(
                            UDim2.new(0, math.clamp(Mouse.X - Section_Slider_TextButton.AbsolutePosition.X, 0, Section_Slider_TextButton.AbsoluteSize.X), 0, 3 * iuaghsf),
                            Enum.EasingDirection.InOut,
                            Enum.EasingStyle.Linear,
                            0.1,
                            true, function()
                                data.Current = Floor(((Section_Slider_Frame.AbsoluteSize.X / Section_Slider_TextButton.AbsoluteSize.X) * (data.Max - data.Min)) + data.Min)
                                callback(data.Current)
                                Section_Slider_Total.Text = tostring(data.Current) .. "/" .. tostring(data.Max)
                            end
                        )
                    end)
                    EndInput = UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            MouseMoved:Disconnect()
                            EndInput:Disconnect()
                            UpdatePossible = true
                        end
                    end)
                end)

                local SliderFunctions = {}

                SliderFunctions.Update = function(self, Value)
                    if UpdatePossible then
                        data.Current = Value
                        Section_Slider_Total.Text = tostring(data.Current) .. "/" .. tostring(data.Max)
                        Section_Slider_Frame.Size = UDim2.new((data.Current - math.abs(data.Min))/(data.Max - math.abs(data.Min)), 0, 0, 3 * iuaghsf)
                    end
                end

                SliderFunctions.Edit = function(self, Min, Max)
                    data.Min = Min
                    data.Max = Max
                    data.Current = data.Min
                    Section_Slider_Total.Text = tostring(data.Current) .. "/" .. tostring(data.Max)
                    Section_Slider_Frame.Size = UDim2.new((data.Current - math.abs(data.Min))/(data.Max - math.abs(data.Min)), 0, 0, 3 * iuaghsf)
                end

                return SliderFunctions
            end

            LibraryFunctions.CreateTextBox = function(self, callback, data)
                local Section_Textbox = Instance.new("Frame")
                Section_Textbox.Name = "Section_Textbox"
                Section_Textbox.Size = UDim2.new(0, 326, 0, 23)
                Section_Textbox.BackgroundTransparency = 1
                Section_Textbox.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Textbox.Parent = Section
                Section_Textbox.LayoutOrder = Library.LayoutOrder
                Library.LayoutOrder = Library.LayoutOrder + 1

                local Section_Textbox_UICorner = Instance.new("UICorner")
                Section_Textbox_UICorner.Name = "Section_Textbox_UICorner"
                Section_Textbox_UICorner.CornerRadius = UDim.new(0, 6)
                Section_Textbox_UICorner.Parent = Section_Textbox

                local Section_Textbox_UIStroke = Instance.new("UIStroke")
                Section_Textbox_UIStroke.Name = "Section_Textbox_UIStroke"
                Section_Textbox_UIStroke.Color = Color3.fromRGB(50, 50, 50)
                Section_Textbox_UIStroke.Parent = Section_Textbox

                local Section_Textbox_TextBox = Instance.new("TextBox")
                Section_Textbox_TextBox.Name = "Section_Textbox_TextBox"
                Section_Textbox_TextBox.Size = UDim2.new(0, 317, 0, 23)
                Section_Textbox_TextBox.BorderColor3 = Color3.fromRGB(27, 42, 53)
                Section_Textbox_TextBox.BackgroundTransparency = 1
                Section_Textbox_TextBox.Position = UDim2.new(0.0266872, 0, 0, 0)
                Section_Textbox_TextBox.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Textbox_TextBox.PlaceholderColor3 = Color3.fromRGB(155, 155, 155)
                Section_Textbox_TextBox.FontSize = Enum.FontSize.Size11
                Section_Textbox_TextBox.TextSize = 11
                Section_Textbox_TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                Section_Textbox_TextBox.Text = data.Name .. " : " .. data.Current
                Section_Textbox_TextBox.Font = Enum.Font.Gotham
                Section_Textbox_TextBox.TextXAlignment = Enum.TextXAlignment.Left
                Section_Textbox_TextBox.PlaceholderText = "..."
                Section_Textbox_TextBox.Parent = Section_Textbox

                Section_Textbox_TextBox.FocusLost:Connect(function()
                    if tonumber(Section_Textbox_TextBox.Text) or not data.NumOnly then
                        data.Current = Section_Textbox_TextBox.Text
                        Section_Textbox_TextBox.Text = data.Name .. " : " .. data.Current
                        callback(data.Current)
                    else
                        Section_Textbox_TextBox.Text = data.Name .. " : " .. data.Current
                    end
                end)

                local TextBoxFunctions = {}

                TextBoxFunctions.Update = function(self, Name, Current)
                    data.Name = Name
                    data.Current = Current
                    Section_Textbox_TextBox.Text = data.Name .. " : " .. data.Current
                    callback(data.Current, true)
                end

                return TextBoxFunctions
            end

            LibraryFunctions.CreateKeyBind = function(self, callback, data)
                local Section_Textbox = Instance.new("Frame")
                Section_Textbox.Name = "Section_Textbox"
                Section_Textbox.Size = UDim2.new(0, 326, 0, 23)
                Section_Textbox.BackgroundTransparency = 1
                Section_Textbox.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Textbox.Parent = Section
                Section_Textbox.LayoutOrder = Library.LayoutOrder
                Library.LayoutOrder = Library.LayoutOrder + 1

                local Section_Textbox_UICorner = Instance.new("UICorner")
                Section_Textbox_UICorner.Name = "Section_Textbox_UICorner"
                Section_Textbox_UICorner.CornerRadius = UDim.new(0, 6)
                Section_Textbox_UICorner.Parent = Section_Textbox

                local Section_Textbox_UIStroke = Instance.new("UIStroke")
                Section_Textbox_UIStroke.Name = "Section_Textbox_UIStroke"
                Section_Textbox_UIStroke.Color = Color3.fromRGB(50, 50, 50)
                Section_Textbox_UIStroke.Parent = Section_Textbox

                local Section_Textbox_TextBox = Instance.new("TextBox")
                Section_Textbox_TextBox.Name = "Section_Textbox_TextBox"
                Section_Textbox_TextBox.Size = UDim2.new(0, 317, 0, 23)
                Section_Textbox_TextBox.BorderColor3 = Color3.fromRGB(27, 42, 53)
                Section_Textbox_TextBox.BackgroundTransparency = 1
                Section_Textbox_TextBox.Position = UDim2.new(0.0266872, 0, 0, 0)
                Section_Textbox_TextBox.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Textbox_TextBox.PlaceholderColor3 = Color3.fromRGB(155, 155, 155)
                Section_Textbox_TextBox.FontSize = Enum.FontSize.Size11
                Section_Textbox_TextBox.TextSize = 11
                Section_Textbox_TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                Section_Textbox_TextBox.Text = data.Name .. " : " .. tostring(data.KeyBind)
                Section_Textbox_TextBox.Font = Enum.Font.Gotham
                Section_Textbox_TextBox.TextXAlignment = Enum.TextXAlignment.Left
                Section_Textbox_TextBox.PlaceholderText = "..."
                Section_Textbox_TextBox.Parent = Section_Textbox

                Section_Textbox_TextBox.Focused:Connect(function()
                    data.Connection = UserInputService.InputEnded:Connect(function(Input)
                        if Input.KeyCode == Enum.KeyCode.Unknown then return end
                        data.KeyBind = Input.KeyCode
                        Section_Textbox_TextBox.Text = tostring(data.KeyBind)
                    end)
                end)

                Section_Textbox_TextBox.FocusLost:Connect(function()
                    data.Connection:Disconnect()
                    Section_Textbox_TextBox.Text = data.Name .. " : " .. tostring(data.KeyBind)
                end)
                
                UserInputService.InputBegan:Connect(function(Input)
                    if Input.KeyCode == data.KeyBind then
                        callback()
                        task.wait(0.5)
                        if UserInputService:IsKeyDown(data.KeyBind) then
                            while UserInputService:IsKeyDown(data.KeyBind) do
                                callback()
                                task.wait()
                            end
                        end
                    end
                end)
            end

            LibraryFunctions.CreateLabel = function(self, data)
                local Section_TextLabel = Instance.new("Frame")
                Section_TextLabel.Name = "Section_TextLabel"
                Section_TextLabel.Size = UDim2.new(0, 326, 0, 23)
                Section_TextLabel.BackgroundTransparency = 1
                Section_TextLabel.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_TextLabel.Parent = Section
                Section_TextLabel.LayoutOrder = Library.LayoutOrder
                Library.LayoutOrder = Library.LayoutOrder + 1

                local Section_TextLabel_UICorner = Instance.new("UICorner")
                Section_TextLabel_UICorner.Name = "Section_TextLabel_UICorner"
                Section_TextLabel_UICorner.CornerRadius = UDim.new(0, 6)
                Section_TextLabel_UICorner.Parent = Section_TextLabel

                local Section_TextLabel_UIStroke = Instance.new("UIStroke")
                Section_TextLabel_UIStroke.Name = "Section_TextLabel_UIStroke"
                Section_TextLabel_UIStroke.Color = Color3.fromRGB(50, 50, 50)
                Section_TextLabel_UIStroke.Parent = Section_TextLabel

                local Section_TextLabel_TextLabel = Instance.new("TextLabel")
                Section_TextLabel_TextLabel.Name = "Section_TextLabel_TextLabel"
                Section_TextLabel_TextLabel.Size = UDim2.new(0, 326, 0, 23)
                Section_TextLabel_TextLabel.BackgroundTransparency = 1
                Section_TextLabel_TextLabel.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_TextLabel_TextLabel.FontSize = Enum.FontSize.Size11
                Section_TextLabel_TextLabel.TextSize = 11
                Section_TextLabel_TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                Section_TextLabel_TextLabel.Text = data.Extra and data.Name .. " : " .. data.Extra or data.Name
                Section_TextLabel_TextLabel.Font = Enum.Font.Gotham
                Section_TextLabel_TextLabel.Parent = Section_TextLabel

                local TextLabelFunctions = {}

                TextLabelFunctions.Update = function(self, Name, Extra)
                    data.Name = Name
                    data.Extra = Extra
                    Section_TextLabel_TextLabel.Text = data.Extra and data.Name .. " : " .. data.Extra or data.Name
                end

                TextLabelFunctions.Destroy = function(self)
                    Section_TextLabel:Destroy()
                end

                return TextLabelFunctions
            end

            LibraryFunctions.CreateDropDown = function(self, callback, data)
                local Section_Dropdown = Instance.new("Frame")
                Section_Dropdown.Name = "Section_Dropdown"
                Section_Dropdown.ZIndex = 2
                Section_Dropdown.Size = UDim2.new(0, 326, 0, 23)
                Section_Dropdown.BackgroundTransparency = 1
                Section_Dropdown.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Dropdown.Parent = Section
                Section_Dropdown.LayoutOrder = Library.LayoutOrder
                Library.LayoutOrder = Library.LayoutOrder + 1
                
                local Section_Dropdown_UIStroke = Instance.new("UIStroke")
                Section_Dropdown_UIStroke.Name = "Section_Dropdown_UIStroke"
                Section_Dropdown_UIStroke.Color = Color3.fromRGB(50, 50, 50)
                Section_Dropdown_UIStroke.Parent = Section_Dropdown
                
                local Section_Dropdown_UICorner = Instance.new("UICorner")
                Section_Dropdown_UICorner.Name = "Section_Dropdown_UICorner"
                Section_Dropdown_UICorner.CornerRadius = UDim.new(0, 6)
                Section_Dropdown_UICorner.Parent = Section_Dropdown
                
                local Section_Dropdown_TextButton = Instance.new("TextButton")
                Section_Dropdown_TextButton.Name = "Section_Dropdown_TextButton"
                Section_Dropdown_TextButton.ZIndex = 2
                Section_Dropdown_TextButton.Size = UDim2.new(0, 326, 0, 23)
                Section_Dropdown_TextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
                Section_Dropdown_TextButton.BackgroundTransparency = 1
                Section_Dropdown_TextButton.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Dropdown_TextButton.FontSize = Enum.FontSize.Size11
                Section_Dropdown_TextButton.TextSize = 11
                Section_Dropdown_TextButton.TextColor3 = Color3.fromRGB(150, 0, 255)
                Section_Dropdown_TextButton.Text = ""
                Section_Dropdown_TextButton.Font = Enum.Font.Gotham
                Section_Dropdown_TextButton.Parent = Section_Dropdown
                
                local Section_Dropdown_TextLabel = Instance.new("TextLabel")
                Section_Dropdown_TextLabel.Name = "Section_Dropdown_TextLabel"
                Section_Dropdown_TextLabel.ZIndex = 2
                Section_Dropdown_TextLabel.Size = UDim2.new(0, 317, 0, 23)
                Section_Dropdown_TextLabel.BackgroundTransparency = 1
                Section_Dropdown_TextLabel.Position = UDim2.new(0.0266872, 0, 0, 0)
                Section_Dropdown_TextLabel.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Dropdown_TextLabel.FontSize = Enum.FontSize.Size11
                Section_Dropdown_TextLabel.TextSize = 11
                Section_Dropdown_TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                Section_Dropdown_TextLabel.Text = data.Name
                Section_Dropdown_TextLabel.Font = Enum.Font.Gotham
                Section_Dropdown_TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                Section_Dropdown_TextLabel.Parent = Section_Dropdown
                
                local Section_Dropdown_ImageLabel = Instance.new("ImageLabel")
                Section_Dropdown_ImageLabel.Name = "Section_Dropdown_ImageLabel"
                Section_Dropdown_ImageLabel.ZIndex = 2
                Section_Dropdown_ImageLabel.Size = UDim2.new(0, 12, 0, 12)
                Section_Dropdown_ImageLabel.BackgroundTransparency = 1
                Section_Dropdown_ImageLabel.Position = UDim2.new(0.945, 0, 0.23, 0)
                Section_Dropdown_ImageLabel.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                Section_Dropdown_ImageLabel.ImageRectOffset = Vector2.new(404, 284)
                Section_Dropdown_ImageLabel.ImageRectSize = Vector2.new(36, 36)
                Section_Dropdown_ImageLabel.Image = "rbxassetid://3926305904"
                Section_Dropdown_ImageLabel.Parent = Section_Dropdown
                Section_Dropdown_ImageLabel.Rotation = 90
                
                local Section_Dropdown_Content = Instance.new("Frame")
                Section_Dropdown_Content.Name = "Section_Dropdown_Content"
                Section_Dropdown_Content.LayoutOrder = 1
                Section_Dropdown_Content.ZIndex = 2
                Section_Dropdown_Content.Visible = false
                Section_Dropdown_Content.Size = UDim2.new(0, 326, 0, 0)
                Section_Dropdown_Content.ClipsDescendants = true
                Section_Dropdown_Content.Position = UDim2.new(0, 0, 1.2173913, 0)
                Section_Dropdown_Content.Active = true
                Section_Dropdown_Content.BackgroundColor3 = Themes.FindColor(20, 20, 20)
                Section_Dropdown_Content.Parent = Section_Dropdown.Parent
                Section_Dropdown_Content.ClipsDescendants = true
                Section_Dropdown_Content.LayoutOrder = Library.LayoutOrder
                Library.LayoutOrder = Library.LayoutOrder + 1
                
                local Section_Dropdown_Content_UIStroke = Instance.new("UIStroke")
                Section_Dropdown_Content_UIStroke.Name = "Section_Dropdown_Content_UIStroke"
                Section_Dropdown_Content_UIStroke.Color = Color3.fromRGB(65, 65, 65)
                Section_Dropdown_Content_UIStroke.Parent = Section_Dropdown_Content
                
                local Section_Dropdown_Content_UICorner = Instance.new("UICorner")
                Section_Dropdown_Content_UICorner.Name = "Section_Dropdown_Content_UICorner"
                Section_Dropdown_Content_UICorner.CornerRadius = UDim.new(0, 6)
                Section_Dropdown_Content_UICorner.Parent = Section_Dropdown_Content
                
                local Section_Dropdown_Content_UIListLayout = Instance.new("UIListLayout")
                Section_Dropdown_Content_UIListLayout.Name = "Section_Dropdown_Content_UIListLayout"
                Section_Dropdown_Content_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                Section_Dropdown_Content_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                Section_Dropdown_Content_UIListLayout.Padding = UDim.new(0, 4)
                Section_Dropdown_Content_UIListLayout.Parent = Section_Dropdown_Content
                
                local Section_Dropdown_Content_UIPadding = Instance.new("UIPadding")
                Section_Dropdown_Content_UIPadding.Name = "Section_Dropdown_Content_UIPadding"
                Section_Dropdown_Content_UIPadding.PaddingTop = UDim.new(0, 3)
                Section_Dropdown_Content_UIPadding.Parent = Section_Dropdown_Content

                table.foreach(data.Content, function(i, v)
                    local Section_Dropdown_Content_Button = Instance.new("Frame")
                    Section_Dropdown_Content_Button.Name = "Section_Dropdown_Content_Button"
                    Section_Dropdown_Content_Button.Size = UDim2.new(0, 316, 0, 18)
                    Section_Dropdown_Content_Button.BackgroundTransparency = 1
                    Section_Dropdown_Content_Button.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                    Section_Dropdown_Content_Button.Parent = Section_Dropdown_Content
                    
                    local UICorner = Instance.new("UICorner")
                    UICorner.CornerRadius = UDim.new(0, 6)
                    UICorner.Parent = Section_Dropdown_Content_Button
                    
                    local TextButton = Instance.new("TextButton")
                    TextButton.Size = UDim2.new(0, 316, 0, 18)
                    TextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    TextButton.BackgroundTransparency = 1
                    TextButton.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                    TextButton.FontSize = Enum.FontSize.Size11
                    TextButton.TextSize = 11
                    TextButton.Text = v.Name or v
                    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextButton.Font = Enum.Font.Gotham
                    TextButton.Parent = Section_Dropdown_Content_Button
                    
                    local UIStroke = Instance.new("UIStroke")
                    UIStroke.Color = Color3.fromRGB(75, 75, 75)
                    UIStroke.Parent = Section_Dropdown_Content_Button

                    TextButton.MouseButton1Down:Connect(function()
                        TweenService:Create(TextButton, TweenInfo.new(0.2), {Rotation = 360}):Play()
                        callback(v.Data or v)
                        Section_Dropdown_TextLabel.Text = data.Name .. " : " .. v
                        task.wait(0.22)
                        TextButton.Rotation = 0
                    end)
                end)

                local Droppped = false

                Section_Dropdown_TextButton.MouseButton1Down:Connect(function()
                    Droppped = not Droppped
                    if Droppped then
                        Section_Dropdown_Content.Visible = true
                    end
                    Section_Dropdown_Content:TweenSize(
                        Droppped and UDim2.new(0, 326 * iuaghsf, 0, Section_Dropdown_Content_UIListLayout.AbsoluteContentSize.Y + 6) or UDim2.new(0, 326 * iuaghsf, 0, 0),
                        Enum.EasingDirection.InOut,
                        Enum.EasingStyle.Linear,
                        0.2,
                        true, function()
                            if not Droppped then
                                Section_Dropdown_Content.Visible = false
                            end
                        end
                    )
                    TweenService:Create(Section_Dropdown_ImageLabel, TweenInfo.new(0.2), {Rotation = Droppped and 0 or 90}):Play()
                end)

                local DropDownFunctions = {}

                DropDownFunctions.Update = function(self, Value)
                    Section_Dropdown_TextLabel.Text = data.Name .. " : " .. Value
                end

                DropDownFunctions.ClearContent = function(self)
                    for i, v in next, Section_Dropdown_Content:GetChildren() do
                        if v.Name == "Section_Dropdown_Content_Button" then
                            v:Destroy()
                        end
                    end
                end

                DropDownFunctions.AddContent = function(self, Data)
                    local Section_Dropdown_Content_Button = Instance.new("Frame")
                    Section_Dropdown_Content_Button.Name = "Section_Dropdown_Content_Button"
                    Section_Dropdown_Content_Button.Size = UDim2.new(0, 316, 0, 18)
                    Section_Dropdown_Content_Button.BackgroundTransparency = 1
                    Section_Dropdown_Content_Button.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                    Section_Dropdown_Content_Button.Parent = Section_Dropdown_Content
                    
                    local UICorner = Instance.new("UICorner")
                    UICorner.CornerRadius = UDim.new(0, 6)
                    UICorner.Parent = Section_Dropdown_Content_Button
                    
                    local TextButton = Instance.new("TextButton")
                    TextButton.Size = UDim2.new(0, 316, 0, 18)
                    TextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    TextButton.BackgroundTransparency = 1
                    TextButton.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                    TextButton.FontSize = Enum.FontSize.Size11
                    TextButton.TextSize = 11
                    TextButton.Text = Data.Name or Data
                    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextButton.Font = Enum.Font.Gotham
                    TextButton.Parent = Section_Dropdown_Content_Button
                    
                    local UIStroke = Instance.new("UIStroke")
                    UIStroke.Color = Color3.fromRGB(75, 75, 75)
                    UIStroke.Parent = Section_Dropdown_Content_Button

                    TextButton.MouseButton1Down:Connect(function()
                        TweenService:Create(TextButton, TweenInfo.new(0.2), {Rotation = 360}):Play()
                        callback(Data.Data or Data)
                        Section_Dropdown_TextLabel.Text = data.Name .. " : " .. (Data.Name or Data)
                        task.wait(0.22)
                        TextButton.Rotation = 0
                    end)
                end

                return DropDownFunctions
            end

            return LibraryFunctions
        end

        LibrarySections.CreateList = function(self, data)
            local List_Section_Name = Instance.new("TextLabel")
            List_Section_Name.Name = "List_Section_Name"
            List_Section_Name.Size = UDim2.new(0, 326, 0, 11)
            List_Section_Name.BackgroundTransparency = 1
            List_Section_Name.Position = UDim2.new(0.0247813, 0, 0, 0)
            List_Section_Name.BackgroundColor3 = Themes.FindColor(255, 255, 255)
            List_Section_Name.FontSize = Enum.FontSize.Size10
            List_Section_Name.TextSize = 10
            List_Section_Name.TextColor3 = Color3.fromRGB(185, 185, 185)
            List_Section_Name.Text = data.Name
            List_Section_Name.Font = Enum.Font.Gotham
            List_Section_Name.TextXAlignment = Enum.TextXAlignment.Left
            List_Section_Name.Parent = Tab
            
            local ListSection = Instance.new("Frame")
            ListSection.Name = "ListSection"
            ListSection.Size = UDim2.new(0, 332, 0, 0)
            ListSection.Position = UDim2.new(0.016035, 0, 0.4518518, 0)
            ListSection.BackgroundColor3 = Themes.FindColor(22, 22, 22)
            ListSection.Parent = Tab
            
            local ListSection_UICorner = Instance.new("UICorner")
            ListSection_UICorner.Name = "ListSection_UICorner"
            ListSection_UICorner.CornerRadius = UDim.new(0, 6)
            ListSection_UICorner.Parent = ListSection
            
            local ListSection_UIStroke = Instance.new("UIStroke")
            ListSection_UIStroke.Name = "ListSection_UIStroke"
            ListSection_UIStroke.Color = Color3.fromRGB(40, 40, 40)
            ListSection_UIStroke.Parent = ListSection
            
            local ListSection_UIListLayout = Instance.new("UIListLayout")
            ListSection_UIListLayout.Name = "ListSection_UIListLayout"
            ListSection_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            ListSection_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListSection_UIListLayout.Padding = UDim.new(0, 5)
            ListSection_UIListLayout.Parent = ListSection
            
            local ListSection_UIPadding = Instance.new("UIPadding")
            ListSection_UIPadding.Name = "ListSection_UIPadding"
            ListSection_UIPadding.PaddingTop = UDim.new(0, 3)
            ListSection_UIPadding.Parent = ListSection

            ListSection_UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                ListSection.Size = UDim2.new(0, 332 * iuaghsf, 0, ListSection_UIListLayout.AbsoluteContentSize.Y + 6)
            end)

            local ListFunctions = {
                Index = 1,
                Lists = {},
                ListData = {},
                StoredData = {}
            }

            ListFunctions.GetListData = function()
                return ListFunctions.StoredData, ListFunctions.Lists, ListFunctions.ListData
            end
            
            ListFunctions.CreateListAtribute = function(self, data)
                local List = Instance.new("Frame")
                List.Name = "List"
                List.Size = UDim2.new(0, 326, 0, 23)
                List.BackgroundTransparency = 1
                List.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                List.Parent = ListSection
                
                local List_UIStroke = Instance.new("UIStroke")
                List_UIStroke.Name = "List_UIStroke"
                List_UIStroke.Color = Color3.fromRGB(50, 50, 50)
                List_UIStroke.Parent = List
                
                local List_UICorner = Instance.new("UICorner")
                List_UICorner.Name = "List_UICorner"
                List_UICorner.CornerRadius = UDim.new(0, 6)
                List_UICorner.Parent = List
                
                local List_TextButton = Instance.new("TextButton")
                List_TextButton.Name = "List_TextButton"
                List_TextButton.Size = UDim2.new(0, 317, 0, 23)
                List_TextButton.BackgroundTransparency = 1
                List_TextButton.Position = UDim2.new(0.0266872, 0, 0, 0)
                List_TextButton.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                List_TextButton.FontSize = Enum.FontSize.Size11
                List_TextButton.TextSize = 11
                List_TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                List_TextButton.Text = data.Name
                List_TextButton.Font = Enum.Font.Gotham
                List_TextButton.TextXAlignment = Enum.TextXAlignment.Left
                List_TextButton.Parent = List
                
                local List_up = Instance.new("ImageButton")
                List_up.Name = "List_up"
                List_up.LayoutOrder = 17
                List_up.ZIndex = 2
                List_up.Size = UDim2.new(0, 12, 0, 12)
                List_up.BackgroundTransparency = 1
                List_up.Position = UDim2.new(0.905, 0, 0.23, 0)
                List_up.ImageRectOffset = Vector2.new(164, 284)
                List_up.Image = "rbxassetid://3926305904"
                List_up.ImageRectSize = Vector2.new(36, 36)
                List_up.Parent = List
                
                local List_down = Instance.new("ImageButton")
                List_down.Name = "List_down"
                List_down.LayoutOrder = 17
                List_down.ZIndex = 2
                List_down.Size = UDim2.new(0, 12, 0, 12)
                List_down.Rotation = 180
                List_down.BackgroundTransparency = 1
                List_down.Position = UDim2.new(0.865, 0, 0.23, 0)
                List_down.ImageRectOffset = Vector2.new(164, 284)
                List_down.Image = "rbxassetid://3926305904"
                List_down.ImageRectSize = Vector2.new(36, 36)
                List_down.Parent = List
                
                local List_remove = Instance.new("ImageButton")
                List_remove.Name = "List_remove"
                List_remove.LayoutOrder = 17
                List_remove.ZIndex = 2
                List_remove.Size = UDim2.new(0, 12, 0, 12)
                List_remove.BackgroundTransparency = 1
                List_remove.Position = UDim2.new(0.945, 0, 0.23, 0)
                List_remove.ImageRectOffset = Vector2.new(284, 4)
                List_remove.Image = "rbxassetid://3926305904"
                List_remove.ImageRectSize = Vector2.new(24, 24)
                List_remove.Parent = List

                table.insert(ListFunctions.Lists, ListFunctions.Index, List)

                List.LayoutOrder = ListFunctions.Index

                ListFunctions.Index = ListFunctions.Index + 1

                ListFunctions.ListData[List] = data.Value

                List_TextButton.MouseButton1Down:Connect(function()
                    ListFunctions.StoredData.Value = data.Value
                    ListFunctions.StoredData.Changed = true
                end)

                List_remove.MouseButton1Down:Connect(function()
                    table.remove(ListFunctions.Lists, List.LayoutOrder)
                    table.foreach(ListFunctions.Lists, function(i, v)
                        v.LayoutOrder = i
                    end)
                    ListFunctions.ListData[List] = nil
                    ListFunctions.Index = #ListFunctions.Lists + 1
                    List:Destroy()
                end)

                List_down.MouseButton1Down:Connect(function()
                    if List.LayoutOrder ~= ListFunctions.Index - 1 then
                        local NewIndex = List.LayoutOrder + 1
                        local OldIndex = List.LayoutOrder

                        local OldList = ListFunctions.Lists[NewIndex]
                        OldList.LayoutOrder = OldIndex

                        local List = ListFunctions.Lists[OldIndex]
                        List.LayoutOrder = NewIndex

                        ListFunctions.Lists[NewIndex] = List
                        ListFunctions.Lists[OldIndex] = OldList
                    end
                end)

                List_up.MouseButton1Down:Connect(function()
                    if List.LayoutOrder > 1 then
                        local NewIndex = List.LayoutOrder - 1
                        local OldIndex = List.LayoutOrder

                        local OldList = ListFunctions.Lists[NewIndex]
                        OldList.LayoutOrder = OldIndex

                        local List = ListFunctions.Lists[OldIndex]
                        List.LayoutOrder = NewIndex

                        ListFunctions.Lists[NewIndex] = List
                        ListFunctions.Lists[OldIndex] = OldList
                    end
                end)

                return List_remove, List_up, List_down
            end

            ListFunctions.CreateCopyListAtribute = function(self, data)
                local CopyableList = Instance.new("Frame")
                CopyableList.Name = "CopyableList"
                CopyableList.Size = UDim2.new(0, 326, 0, 23)
                CopyableList.BackgroundTransparency = 1
                CopyableList.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                CopyableList.Parent = ListSection
                
                local CopyableList_UIStroke = Instance.new("UIStroke")
                CopyableList_UIStroke.Name = "CopyableList_UIStroke"
                CopyableList_UIStroke.Color = Color3.fromRGB(50, 50, 50)
                CopyableList_UIStroke.Parent = CopyableList
                
                local CopyableList_UICorner = Instance.new("UICorner")
                CopyableList_UICorner.Name = "CopyableList_UICorner"
                CopyableList_UICorner.CornerRadius = UDim.new(0, 6)
                CopyableList_UICorner.Parent = CopyableList
                
                local CopyableList_TextButton = Instance.new("TextButton")
                CopyableList_TextButton.Name = "CopyableList_TextButton"
                CopyableList_TextButton.Size = UDim2.new(0, 317, 0, 23)
                CopyableList_TextButton.BackgroundTransparency = 1
                CopyableList_TextButton.Position = UDim2.new(0.0266872, 0, 0, 0)
                CopyableList_TextButton.BackgroundColor3 = Themes.FindColor(255, 255, 255)
                CopyableList_TextButton.FontSize = Enum.FontSize.Size11
                CopyableList_TextButton.TextSize = 11
                CopyableList_TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                CopyableList_TextButton.Text = data.Name
                CopyableList_TextButton.Font = Enum.Font.Gotham
                CopyableList_TextButton.TextXAlignment = Enum.TextXAlignment.Left
                CopyableList_TextButton.Parent = CopyableList
                
                local CopyableList_up = Instance.new("ImageButton")
                CopyableList_up.Name = "CopyableList_up"
                CopyableList_up.LayoutOrder = 17
                CopyableList_up.ZIndex = 2
                CopyableList_up.Size = UDim2.new(0, 12, 0, 12)
                CopyableList_up.BackgroundTransparency = 1
                CopyableList_up.Position = UDim2.new(0.905, 0, 0.23, 0)
                CopyableList_up.ImageRectOffset = Vector2.new(164, 284)
                CopyableList_up.Image = "rbxassetid://3926305904"
                CopyableList_up.ImageRectSize = Vector2.new(36, 36)
                CopyableList_up.Parent = CopyableList
                
                local CopyableList_down = Instance.new("ImageButton")
                CopyableList_down.Name = "CopyableList_down"
                CopyableList_down.LayoutOrder = 17
                CopyableList_down.ZIndex = 2
                CopyableList_down.Size = UDim2.new(0, 12, 0, 12)
                CopyableList_down.Rotation = 180
                CopyableList_down.BackgroundTransparency = 1
                CopyableList_down.Position = UDim2.new(0.865, 0, 0.23, 0)
                CopyableList_down.ImageRectOffset = Vector2.new(164, 284)
                CopyableList_down.Image = "rbxassetid://3926305904"
                CopyableList_down.ImageRectSize = Vector2.new(36, 36)
                CopyableList_down.Parent = CopyableList
                
                local CopyableList_copy = Instance.new("ImageButton")
                CopyableList_copy.Name = "CopyableList_copy"
                CopyableList_copy.LayoutOrder = 17
                CopyableList_copy.ZIndex = 2
                CopyableList_copy.Size = UDim2.new(0, 12, 0, 12)
                CopyableList_copy.BackgroundTransparency = 1
                CopyableList_copy.Position = UDim2.new(0.825, 0, 0.2, 0)
                CopyableList_copy.Image = "http://www.roblox.com/asset/?id=7246179843"
                CopyableList_copy.Parent = CopyableList
                
                local CopyableList_remove = Instance.new("ImageButton")
                CopyableList_remove.Name = "CopyableList_remove"
                CopyableList_remove.LayoutOrder = 17
                CopyableList_remove.ZIndex = 2
                CopyableList_remove.Size = UDim2.new(0, 12, 0, 12)
                CopyableList_remove.BackgroundTransparency = 1
                CopyableList_remove.Position = UDim2.new(0.945, 0, 0.23, 0)
                CopyableList_remove.ImageRectOffset = Vector2.new(284, 4)
                CopyableList_remove.Image = "rbxassetid://3926305904"
                CopyableList_remove.ImageRectSize = Vector2.new(24, 24)
                CopyableList_remove.Parent = CopyableList

                table.insert(ListFunctions.Lists, ListFunctions.Index, CopyableList)

                CopyableList.LayoutOrder = ListFunctions.Index

                ListFunctions.Index = ListFunctions.Index + 1

                ListFunctions.ListData[CopyableList] = data.Value

                CopyableList_TextButton.MouseButton1Down:Connect(function()
                    ListFunctions.StoredData.Value = data.Value
                    ListFunctions.StoredData.Changed = true
                end)

                CopyableList_remove.MouseButton1Down:Connect(function()
                    table.remove(ListFunctions.Lists, CopyableList.LayoutOrder)
                    table.foreach(ListFunctions.Lists, function(i, v)
                        v.LayoutOrder = i
                    end)
                    ListFunctions.Index = #ListFunctions.Lists + 1
                    ListFunctions.ListData[CopyableList] = nil
                    CopyableList:Destroy()
                end)

                CopyableList_down.MouseButton1Down:Connect(function()
                    if CopyableList.LayoutOrder ~= ListFunctions.Index - 1 then
                        local NewIndex = CopyableList.LayoutOrder + 1
                        local OldIndex = CopyableList.LayoutOrder

                        local OldCopyableList = ListFunctions.Lists[NewIndex]
                        OldCopyableList.LayoutOrder = OldIndex

                        local CopyableList = ListFunctions.Lists[OldIndex]
                        CopyableList.LayoutOrder = NewIndex

                        ListFunctions.Lists[NewIndex] = CopyableList
                        ListFunctions.Lists[OldIndex] = OldCopyableList
                    end
                end)

                CopyableList_up.MouseButton1Down:Connect(function()
                    if CopyableList.LayoutOrder > 1 then
                        local NewIndex = CopyableList.LayoutOrder - 1
                        local OldIndex = CopyableList.LayoutOrder

                        local OldCopyableList = ListFunctions.Lists[NewIndex]
                        OldCopyableList.LayoutOrder = OldIndex

                        local CopyableList = ListFunctions.Lists[OldIndex]
                        CopyableList.LayoutOrder = NewIndex

                        ListFunctions.Lists[NewIndex] = CopyableList
                        ListFunctions.Lists[OldIndex] = OldCopyableList
                    end
                end)

                CopyableList_copy.MouseButton1Down:Connect(function()
                    setclipboard(data.Name .. ", " .. tostring(data.Value))
                end)

                return CopyableList_remove, CopyableList_up, CopyableList_down
            end

            for i, v in next, data.Lists do
                if v.CopyableList then
                    ListFunctions.CreateCopyListAtribute(v.data)
                end
                if v.List then
                    ListFunctions.CreateListAtribute(v.data)
                end
            end

            return ListFunctions
        end

        return LibrarySections
    end

    return LibraryTabs, LibraryGui
end

return Library