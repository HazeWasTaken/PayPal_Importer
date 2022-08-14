Vehicle_Importer = {['Modules/Ui/Library.lua'] = function()
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Library = {
    Module = {
		Functions = {},
		Data = {}
	},
	Data = {},
	Functions = {}
}

Library.Module.Functions.CreateUi = function(self, Name)
    local UiLibrary = {
        Module = {
            Functions = {},
            Data = {}
        },
        Data = {
            MenuOpen = false
        },
        Functions = {}
    }

    local MainUi = Instance.new("ScreenGui")
    MainUi.Name = Name
    MainUi.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    MainUi.Parent = CoreGui

    local Gui = Instance.new("Frame")
    Gui.Name = "Gui"
    Gui.Size = UDim2.new(0, 324, 0, 332)
    Gui.Position = UDim2.new(0, 640, 0, 252)
    Gui.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Gui.Parent = MainUi

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Gui

    local Menu = Instance.new("ImageButton")
    Menu.Name = "menu"
    Menu.LayoutOrder = 4
    Menu.ZIndex = 2
    Menu.Size = UDim2.new(0, 22, 0, 22)
    Menu.BackgroundTransparency = 1
    Menu.Position = UDim2.new(0, 12, 0, 12)
    Menu.ImageRectOffset = Vector2.new(604, 684)
    Menu.Image = "rbxassetid://3926305904"
    Menu.ImageRectSize = Vector2.new(36, 36)
    Menu.Parent = Gui

    local UiName = Instance.new("TextLabel")
    UiName.Size = UDim2.new(0, 137, 0, 22)
    UiName.BackgroundTransparency = 1
    UiName.Position = UDim2.new(0, 42, 0, 12)
    UiName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UiName.FontSize = Enum.FontSize.Size14
    UiName.TextSize = 14
    UiName.TextColor3 = Color3.fromRGB(255, 255, 255)
    UiName.Text = Name
    UiName.Font = Enum.Font.SourceSansBold
    UiName.TextXAlignment = Enum.TextXAlignment.Left
    UiName.Parent = Gui

    local TabName = Instance.new("TextLabel")
    TabName.Size = UDim2.new(0, 97, 0, 22)
    TabName.BackgroundTransparency = 1
    TabName.Position = UDim2.new(1, -119, 0, 12)
    TabName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabName.FontSize = Enum.FontSize.Size14
    TabName.TextSize = 14
    TabName.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabName.Text = ""
    TabName.Font = Enum.Font.SourceSansSemibold
    TabName.TextXAlignment = Enum.TextXAlignment.Right
    TabName.Parent = Gui

    local Tabs = Instance.new("Frame")
    Tabs.Name = "Tabs"
    Tabs.AnchorPoint = Vector2.new(0.5, 0)
    Tabs.Size = UDim2.new(1, -24, 1, -54)
    Tabs.BackgroundTransparency = 0.875
    Tabs.Position = UDim2.new(0.5, 0, 0, 42)
    Tabs.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Tabs.Parent = Gui

    local TabSelecting = Instance.new("Frame")
    TabSelecting.Name = "TabSelecting"
    TabSelecting.ZIndex = 0
    TabSelecting.Visible = false
    TabSelecting.Size = UDim2.new(1, 0, 1, 0)
    TabSelecting.BackgroundTransparency = 0.5
    TabSelecting.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TabSelecting.Parent = Gui

    local UICorner23 = Instance.new("UICorner")
    UICorner23.CornerRadius = UDim.new(0, 10)
    UICorner23.Parent = TabSelecting

    local UICorner19 = Instance.new("UICorner")
    UICorner19.CornerRadius = UDim.new(0, 10)
    UICorner19.Parent = Tabs

    local DragAndResize = Instance.new("LocalScript")
    DragAndResize.Name = "DragAndResize"
    DragAndResize.Parent = Gui

    local TouchedPos = Instance.new("TextButton")
    TouchedPos.Name = "TouchedPos"
    TouchedPos.Size = UDim2.new(0.261, 0, 0.243, 0)
    TouchedPos.BackgroundTransparency = 1
    TouchedPos.Position = UDim2.new(0.739, 0, 0.757, 0)
    TouchedPos.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TouchedPos.FontSize = Enum.FontSize.Size14
    TouchedPos.TextSize = 14
    TouchedPos.TextColor3 = Color3.fromRGB(0, 0, 0)
    TouchedPos.Text = ""
    TouchedPos.Font = Enum.Font.SourceSans
    TouchedPos.Parent = Gui

    local TabSelection = Instance.new("Frame")
    TabSelection.Name = "TabSelection"
    TabSelection.Visible = false
    TabSelection.Size = UDim2.new(0, 15, 1, 0)
    TabSelection.BackgroundTransparency = 0.05
    TabSelection.BorderSizePixel = 0
    TabSelection.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
    TabSelection.Parent = Gui

    local UICorner20 = Instance.new("UICorner")
    UICorner20.CornerRadius = UDim.new(0, 10)
    UICorner20.Parent = TabSelection

    local Frame = Instance.new("Frame")
    Frame.AnchorPoint = Vector2.new(0.5, 1)
    Frame.Size = UDim2.new(1, -24, 1, -54)
    Frame.BackgroundTransparency = 0.7
    Frame.Position = UDim2.new(0.5, 0, 1, -12)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Frame.Parent = TabSelection

    local UICorner21 = Instance.new("UICorner")
    UICorner21.CornerRadius = UDim.new(0, 10)
    UICorner21.Parent = Frame

    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Active = true
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrame.ScrollBarThickness = 5
    ScrollingFrame.Parent = Frame

    local UIListLayout3 = Instance.new("UIListLayout")
    UIListLayout3.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout3.Padding = UDim.new(0, 3)
    UIListLayout3.Parent = ScrollingFrame

    local UIPadding3 = Instance.new("UIPadding")
    UIPadding3.PaddingTop = UDim.new(0, 6)
    UIPadding3.Parent = ScrollingFrame

    UiLibrary.Functions.ToggleTabMenu = function()
        UiLibrary.Data.MenuOpen = not UiLibrary.Data.MenuOpen

        if UiLibrary.Data.MenuOpen then
            TabSelection.Visible = UiLibrary.Data.MenuOpen
        end

        local MenuTween = TweenService:Create(TabSelection, TweenInfo.new(.25, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, UiLibrary.Data.MenuOpen and 180 or 15, 1, 0)
        })

        MenuTween.Completed:Connect(function(playbackState)
            if not UiLibrary.Data.MenuOpen then
                TabSelection.Visible = UiLibrary.Data.MenuOpen
            end
            Frame.Visible = UiLibrary.Data.MenuOpen
        end)

        MenuTween:Play()
    end

    Menu.MouseButton1Down:Connect(UiLibrary.Functions.ToggleTabMenu)
end

Library.Module.Functions:CreateUi("Bread")

return Library
end,
['Modules/VehicleChecks/VehicleChecks.lua'] = function()
local VehicleChecks = {
	Module = {
		Functions = {},
		Data = {}
	},
	Data = {},
	Functions = {}
}


return VehicleChecks.Module
end,
['undefined/SerializedOutput_ZFdBcd.lua'] = function()


local Tab = Instance.new("ScrollingFrame")
Tab.Name = "Tab"
Tab.Size = UDim2.new(1, 0, 1, 0)
Tab.BackgroundTransparency = 1
Tab.Active = true
Tab.BorderSizePixel = 0
Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab.ScrollBarThickness = 3
Tab.CanvasPosition = Vector2.new(0, 278)
Tab.Parent = Tabs

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 4)
UIPadding.PaddingLeft = UDim.new(0, -1)
UIPadding.Parent = Tab

local Section = Instance.new("Frame")
Section.Name = "Section"
Section.Size = UDim2.new(1, -14, 0, 268)
Section.BackgroundTransparency = 0.975
Section.Position = UDim2.new(0.0232558, 0, 0, 0)
Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section.Parent = Tab

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.AnchorPoint = Vector2.new(0.5, 0)
Content.Size = UDim2.new(1, -13, 0, 230)
Content.BackgroundTransparency = 0.95
Content.Position = UDim2.new(0.5, 0, 0, 30)
Content.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Content.Parent = Section

local Button = Instance.new("TextButton")
Button.Name = "Button"
Button.Size = UDim2.new(1, -14, 0, 28)
Button.BackgroundTransparency = 0.975
Button.Position = UDim2.new(0.0136054, 0, 0, 0)
Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Button.AutoButtonColor = false
Button.FontSize = Enum.FontSize.Size12
Button.TextSize = 12
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamMedium
Button.Parent = Content

local UICorner1 = Instance.new("UICorner")
UICorner1.CornerRadius = UDim.new(0, 6)
UICorner1.Parent = Button

local Theme = Instance.new("LocalScript")
Theme.Name = "Theme"
Theme.Parent = Button

local Toggle = Instance.new("TextButton")
Toggle.Name = "Toggle"
Toggle.Size = UDim2.new(1, -14, 0, 28)
Toggle.BackgroundTransparency = 0.975
Toggle.Position = UDim2.new(0.0136054, 0, 0, 0)
Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle.AutoButtonColor = false
Toggle.FontSize = Enum.FontSize.Size14
Toggle.TextSize = 14
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Text = ""
Toggle.Font = Enum.Font.SourceSans
Toggle.Parent = Content

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 6)
UICorner2.Parent = Toggle

local Name = Instance.new("TextLabel")
Name.Name = "Name"
Name.Size = UDim2.new(0, 192, 0, 28)
Name.BackgroundTransparency = 1
Name.Position = UDim2.new(0, 8, 0, 0)
Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name.FontSize = Enum.FontSize.Size12
Name.TextSize = 12
Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Name.Text = "Toggle (disabled)"
Name.Font = Enum.Font.GothamMedium
Name.TextXAlignment = Enum.TextXAlignment.Left
Name.Parent = Toggle

local Theme1 = Instance.new("LocalScript")
Theme1.Name = "Theme"
Theme1.Parent = Name

local Check = Instance.new("Frame")
Check.Name = "Check"
Check.AnchorPoint = Vector2.new(0.5, 0.5)
Check.Size = UDim2.new(0, 16, 0, 16)
Check.BackgroundTransparency = 1
Check.Position = UDim2.new(1, -16, 0.5, 0)
Check.BackgroundColor3 = Color3.fromRGB(206, 133, 72)
Check.Parent = Toggle

local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 4)
UICorner3.Parent = Check

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(206, 133, 72)
UIStroke.Parent = Check

local Theme2 = Instance.new("LocalScript")
Theme2.Name = "Theme"
Theme2.Parent = UIStroke

local Img = Instance.new("ImageLabel")
Img.Name = "Img"
Img.AnchorPoint = Vector2.new(0.5, 0.5)
Img.Size = UDim2.new(0, 14, 0, 14)
Img.BackgroundTransparency = 1
Img.Position = UDim2.new(0.5, 0, 0.5, 0)
Img.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Img.ImageTransparency = 1
Img.ImageRectOffset = Vector2.new(312, 4)
Img.ImageRectSize = Vector2.new(24, 24)
Img.Image = "rbxassetid://3926305904"
Img.Parent = Check

local Theme3 = Instance.new("LocalScript")
Theme3.Name = "Theme"
Theme3.Parent = Img

local Theme4 = Instance.new("LocalScript")
Theme4.Name = "Theme"
Theme4.Parent = Check

local Toggle1 = Instance.new("TextButton")
Toggle1.Name = "Toggle"
Toggle1.Size = UDim2.new(1, -14, 0, 28)
Toggle1.BackgroundTransparency = 0.975
Toggle1.Position = UDim2.new(0.0136054, 0, 0, 0)
Toggle1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle1.AutoButtonColor = false
Toggle1.FontSize = Enum.FontSize.Size14
Toggle1.TextSize = 14
Toggle1.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle1.Text = ""
Toggle1.Font = Enum.Font.SourceSans
Toggle1.Parent = Content

local UICorner4 = Instance.new("UICorner")
UICorner4.CornerRadius = UDim.new(0, 6)
UICorner4.Parent = Toggle1

local Name1 = Instance.new("TextLabel")
Name1.Name = "Name"
Name1.Size = UDim2.new(0, 192, 0, 28)
Name1.BackgroundTransparency = 1
Name1.Position = UDim2.new(0, 8, 0, 0)
Name1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name1.FontSize = Enum.FontSize.Size12
Name1.TextSize = 12
Name1.TextColor3 = Color3.fromRGB(255, 255, 255)
Name1.Text = "Toggle (enabled)"
Name1.Font = Enum.Font.GothamMedium
Name1.TextXAlignment = Enum.TextXAlignment.Left
Name1.Parent = Toggle1

local Theme5 = Instance.new("LocalScript")
Theme5.Name = "Theme"
Theme5.Parent = Name1

local Check1 = Instance.new("Frame")
Check1.Name = "Check"
Check1.AnchorPoint = Vector2.new(0.5, 0.5)
Check1.Size = UDim2.new(0, 18, 0, 18)
Check1.Position = UDim2.new(1, -16, 0.5, 0)
Check1.BackgroundColor3 = Color3.fromRGB(206, 133, 72)
Check1.Parent = Toggle1

local UICorner5 = Instance.new("UICorner")
UICorner5.CornerRadius = UDim.new(0, 6)
UICorner5.Parent = Check1

local UIStroke1 = Instance.new("UIStroke")
UIStroke1.Thickness = 0
UIStroke1.Color = Color3.fromRGB(206, 133, 72)
UIStroke1.Parent = Check1

local Theme6 = Instance.new("LocalScript")
Theme6.Name = "Theme"
Theme6.Parent = UIStroke1

local Img1 = Instance.new("ImageLabel")
Img1.Name = "Img"
Img1.AnchorPoint = Vector2.new(0.5, 0.5)
Img1.Size = UDim2.new(0, 14, 0, 14)
Img1.BackgroundTransparency = 1
Img1.Position = UDim2.new(0.5, 0, 0.5, 0)
Img1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Img1.ImageRectOffset = Vector2.new(312, 4)
Img1.ImageRectSize = Vector2.new(24, 24)
Img1.Image = "rbxassetid://3926305904"
Img1.Parent = Check1

local Theme7 = Instance.new("LocalScript")
Theme7.Name = "Theme"
Theme7.Parent = Img1

local Theme8 = Instance.new("LocalScript")
Theme8.Name = "Theme"
Theme8.Parent = Check1

local Slider = Instance.new("TextButton")
Slider.Name = "Slider"
Slider.Size = UDim2.new(1, -14, 0, 58)
Slider.BackgroundTransparency = 0.975
Slider.Position = UDim2.new(0.0233333, 0, 0.350365, 0)
Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider.AutoButtonColor = false
Slider.FontSize = Enum.FontSize.Size14
Slider.TextSize = 14
Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
Slider.Text = ""
Slider.Font = Enum.Font.SourceSans
Slider.Parent = Content

local UICorner6 = Instance.new("UICorner")
UICorner6.CornerRadius = UDim.new(0, 6)
UICorner6.Parent = Slider

local Value = Instance.new("TextBox")
Value.Name = "Value"
Value.AnchorPoint = Vector2.new(1, 0)
Value.Size = UDim2.new(0, 47, 0, 18)
Value.BackgroundTransparency = 1
Value.Position = UDim2.new(1, -8, 0, 5)
Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Value.FontSize = Enum.FontSize.Size12
Value.TextSize = 12
Value.TextColor3 = Color3.fromRGB(255, 255, 255)
Value.Text = "3/9"
Value.PlaceholderText = "..."
Value.Font = Enum.Font.Gotham
Value.TextXAlignment = Enum.TextXAlignment.Right
Value.Parent = Slider

local Theme9 = Instance.new("LocalScript")
Theme9.Name = "Theme"
Theme9.Parent = Value

local Background = Instance.new("Frame")
Background.Name = "Background"
Background.AnchorPoint = Vector2.new(0.5, 0)
Background.Size = UDim2.new(1, -20, 0, 13)
Background.BorderColor3 = Color3.fromRGB(27, 42, 53)
Background.BackgroundTransparency = 0.9
Background.Position = UDim2.new(0.5, 0, 0.6034483, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.Parent = Slider

local UICorner7 = Instance.new("UICorner")
UICorner7.CornerRadius = UDim.new(0, 4)
UICorner7.Parent = Background

local Indicator = Instance.new("Frame")
Indicator.Name = "Indicator"
Indicator.Size = UDim2.new(0, 53, 1, 0)
Indicator.BackgroundColor3 = Color3.fromRGB(206, 133, 72)
Indicator.Parent = Background

local UICorner8 = Instance.new("UICorner")
UICorner8.CornerRadius = UDim.new(0, 4)
UICorner8.Parent = Indicator

local Knob = Instance.new("Frame")
Knob.Name = "Knob"
Knob.AnchorPoint = Vector2.new(0.5, 0.5)
Knob.Size = UDim2.new(0, 12, 0, 18)
Knob.Position = UDim2.new(1, 0, 0.45, 0)
Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Knob.Parent = Indicator

local UICorner9 = Instance.new("UICorner")
UICorner9.CornerRadius = UDim.new(0, 4)
UICorner9.Parent = Knob

local Theme10 = Instance.new("LocalScript")
Theme10.Name = "Theme"
Theme10.Parent = Knob

local Theme11 = Instance.new("LocalScript")
Theme11.Name = "Theme"
Theme11.Parent = Indicator

local Name2 = Instance.new("TextLabel")
Name2.Name = "Name"
Name2.Size = UDim2.new(0, 192, 0, 28)
Name2.BackgroundTransparency = 1
Name2.Position = UDim2.new(0, 8, 0, 0)
Name2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name2.FontSize = Enum.FontSize.Size12
Name2.TextSize = 12
Name2.TextColor3 = Color3.fromRGB(255, 255, 255)
Name2.Text = "Slider"
Name2.Font = Enum.Font.GothamMedium
Name2.TextXAlignment = Enum.TextXAlignment.Left
Name2.Parent = Slider

local Theme12 = Instance.new("LocalScript")
Theme12.Name = "Theme"
Theme12.Parent = Name2

local UIPadding1 = Instance.new("UIPadding")
UIPadding1.PaddingTop = UDim.new(0, 6)
UIPadding1.PaddingLeft = UDim.new(0, -1)
UIPadding1.Parent = Content

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)
UIListLayout.Parent = Content

local UICorner10 = Instance.new("UICorner")
UICorner10.Parent = Content

local Textbox = Instance.new("Frame")
Textbox.Name = "Textbox"
Textbox.Size = UDim2.new(1, -14, 0, 58)
Textbox.ClipsDescendants = true
Textbox.BackgroundTransparency = 0.975
Textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Textbox.Parent = Content

local UICorner11 = Instance.new("UICorner")
UICorner11.CornerRadius = UDim.new(0, 6)
UICorner11.Parent = Textbox

local Name3 = Instance.new("TextLabel")
Name3.Name = "Name"
Name3.Size = UDim2.new(0, 192, 0, 28)
Name3.BackgroundTransparency = 1
Name3.Position = UDim2.new(0, 8, 0, 0)
Name3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name3.FontSize = Enum.FontSize.Size12
Name3.TextSize = 12
Name3.TextColor3 = Color3.fromRGB(255, 255, 255)
Name3.Text = "Textbox"
Name3.Font = Enum.Font.GothamMedium
Name3.TextXAlignment = Enum.TextXAlignment.Left
Name3.Parent = Textbox

local Theme13 = Instance.new("LocalScript")
Theme13.Name = "Theme"
Theme13.Parent = Name3

local MainContent = Instance.new("Frame")
MainContent.Name = "MainContent"
MainContent.AnchorPoint = Vector2.new(0.5, 0)
MainContent.Size = UDim2.new(1, -20, 0.1206897, 13)
MainContent.BorderColor3 = Color3.fromRGB(27, 42, 53)
MainContent.BackgroundTransparency = 0.9
MainContent.Position = UDim2.new(0.5, 0, 0, 28)
MainContent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainContent.Parent = Textbox

local UICorner12 = Instance.new("UICorner")
UICorner12.CornerRadius = UDim.new(0, 4)
UICorner12.Parent = MainContent

local Text = Instance.new("TextBox")
Text.Name = "Text"
Text.Size = UDim2.new(1, -12, 0, 20)
Text.BackgroundTransparency = 1
Text.Position = UDim2.new(0, 12, 0, 0)
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.FontSize = Enum.FontSize.Size12
Text.TextSize = 12
Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Text.Text = ""
Text.PlaceholderText = "..."
Text.Font = Enum.Font.GothamMedium
Text.TextXAlignment = Enum.TextXAlignment.Left
Text.Parent = MainContent

local Theme14 = Instance.new("LocalScript")
Theme14.Name = "Theme"
Theme14.Parent = Text

local UICorner13 = Instance.new("UICorner")
UICorner13.Parent = Section

local Name4 = Instance.new("TextLabel")
Name4.Name = "Name"
Name4.Size = UDim2.new(0, 192, 0, 28)
Name4.BackgroundTransparency = 1
Name4.Position = UDim2.new(0, 10, 0, 0)
Name4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name4.FontSize = Enum.FontSize.Size12
Name4.TextSize = 12
Name4.TextColor3 = Color3.fromRGB(255, 255, 255)
Name4.Text = "Section"
Name4.Font = Enum.Font.GothamMedium
Name4.TextXAlignment = Enum.TextXAlignment.Left
Name4.Parent = Section

local Theme15 = Instance.new("LocalScript")
Theme15.Name = "Theme"
Theme15.Parent = Name4

local Open = Instance.new("TextButton")
Open.Name = "Open"
Open.Size = UDim2.new(1, 0, 0, 28)
Open.BackgroundTransparency = 1
Open.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Open.AutoButtonColor = false
Open.FontSize = Enum.FontSize.Size14
Open.TextSize = 14
Open.TextColor3 = Color3.fromRGB(0, 0, 0)
Open.Text = ""
Open.Font = Enum.Font.SourceSans
Open.Parent = Section

local Indicator1 = Instance.new("ImageLabel")
Indicator1.Name = "Indicator"
Indicator1.AnchorPoint = Vector2.new(1, 0)
Indicator1.Size = UDim2.new(0, 28, 0, 28)
Indicator1.Rotation = 180
Indicator1.BackgroundTransparency = 1
Indicator1.Position = UDim2.new(1, -7, 0.011, 0)
Indicator1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Indicator1.ImageRectOffset = Vector2.new(324, 524)
Indicator1.ImageRectSize = Vector2.new(36, 36)
Indicator1.Image = "rbxassetid://3926307971"
Indicator1.Parent = Section

local Theme16 = Instance.new("LocalScript")
Theme16.Name = "Theme"
Theme16.Parent = Indicator1

local UIListLayout1 = Instance.new("UIListLayout")
UIListLayout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout1.Padding = UDim.new(0, 4)
UIListLayout1.Parent = Tab

local Section1 = Instance.new("Frame")
Section1.Name = "Section"
Section1.Size = UDim2.new(1, -14, 0, 330)
Section1.BackgroundTransparency = 0.975
Section1.Position = UDim2.new(0.0232558, 0, 0, 0)
Section1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section1.Parent = Tab

local Content1 = Instance.new("Frame")
Content1.Name = "Content"
Content1.AnchorPoint = Vector2.new(0.5, 0)
Content1.Size = UDim2.new(1, -13, 0, 292)
Content1.BackgroundTransparency = 0.95
Content1.Position = UDim2.new(0.5, 0, 0, 30)
Content1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Content1.Parent = Section1

local CopyList = Instance.new("TextButton")
CopyList.Name = "CopyList"
CopyList.Size = UDim2.new(1, -14, 0, 28)
CopyList.BackgroundTransparency = 0.975
CopyList.Position = UDim2.new(0.0136054, 0, 0, 0)
CopyList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CopyList.AutoButtonColor = false
CopyList.FontSize = Enum.FontSize.Size14
CopyList.TextSize = 14
CopyList.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyList.Text = ""
CopyList.Font = Enum.Font.SourceSans
CopyList.Parent = Content1

local UICorner14 = Instance.new("UICorner")
UICorner14.CornerRadius = UDim.new(0, 6)
UICorner14.Parent = CopyList

local Name5 = Instance.new("TextLabel")
Name5.Name = "Name"
Name5.Size = UDim2.new(0, 192, 0, 28)
Name5.BackgroundTransparency = 1
Name5.Position = UDim2.new(0, 8, 0, 0)
Name5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name5.FontSize = Enum.FontSize.Size12
Name5.TextSize = 12
Name5.TextColor3 = Color3.fromRGB(255, 255, 255)
Name5.Text = "List Copy"
Name5.Font = Enum.Font.GothamMedium
Name5.TextXAlignment = Enum.TextXAlignment.Left
Name5.Parent = CopyList

local Theme17 = Instance.new("LocalScript")
Theme17.Name = "Theme"
Theme17.Parent = Name5

local copy = Instance.new("ImageButton")
copy.Name = "copy"
copy.LayoutOrder = 17
copy.ZIndex = 2
copy.AnchorPoint = Vector2.new(0, 0.5)
copy.Size = UDim2.new(0, 14, 0, 14)
copy.BackgroundTransparency = 1
copy.Position = UDim2.new(1, -70, 0.5, 0)
copy.Image = "http://www.roblox.com/asset/?id=7246179843"
copy.Parent = CopyList

local down = Instance.new("ImageButton")
down.Name = "down"
down.LayoutOrder = 17
down.ZIndex = 2
down.AnchorPoint = Vector2.new(0, 0.5)
down.Size = UDim2.new(0, 14, 0, 14)
down.Rotation = 180
down.BackgroundTransparency = 1
down.Position = UDim2.new(1, -50, 0.5, 0)
down.ImageRectOffset = Vector2.new(164, 284)
down.Image = "rbxassetid://3926305904"
down.ImageRectSize = Vector2.new(36, 36)
down.Parent = CopyList

local remove = Instance.new("ImageButton")
remove.Name = "remove"
remove.LayoutOrder = 17
remove.ZIndex = 2
remove.AnchorPoint = Vector2.new(0, 0.5)
remove.Size = UDim2.new(0, 14, 0, 14)
remove.BackgroundTransparency = 1
remove.Position = UDim2.new(1, -20, 0.5, 0)
remove.ImageRectOffset = Vector2.new(284, 4)
remove.Image = "rbxassetid://3926305904"
remove.ImageRectSize = Vector2.new(24, 24)
remove.Parent = CopyList

local up = Instance.new("ImageButton")
up.Name = "up"
up.LayoutOrder = 17
up.ZIndex = 2
up.AnchorPoint = Vector2.new(0, 0.5)
up.Size = UDim2.new(0, 14, 0, 14)
up.BackgroundTransparency = 1
up.Position = UDim2.new(1, -35, 0.5, 0)
up.ImageRectOffset = Vector2.new(164, 284)
up.Image = "rbxassetid://3926305904"
up.ImageRectSize = Vector2.new(36, 36)
up.Parent = CopyList

local UIPadding2 = Instance.new("UIPadding")
UIPadding2.PaddingTop = UDim.new(0, 6)
UIPadding2.PaddingLeft = UDim.new(0, -1)
UIPadding2.Parent = Content1

local UIListLayout2 = Instance.new("UIListLayout")
UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout2.Padding = UDim.new(0, 4)
UIListLayout2.Parent = Content1

local UICorner15 = Instance.new("UICorner")
UICorner15.Parent = Content1

local IconList = Instance.new("TextButton")
IconList.Name = "IconList"
IconList.Size = UDim2.new(1, -14, 0, 28)
IconList.BackgroundTransparency = 0.975
IconList.Position = UDim2.new(0.0136054, 0, 0, 0)
IconList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IconList.AutoButtonColor = false
IconList.FontSize = Enum.FontSize.Size14
IconList.TextSize = 14
IconList.TextColor3 = Color3.fromRGB(255, 255, 255)
IconList.Text = ""
IconList.Font = Enum.Font.SourceSans
IconList.Parent = Content1

local UICorner16 = Instance.new("UICorner")
UICorner16.CornerRadius = UDim.new(0, 6)
UICorner16.Parent = IconList

local Name6 = Instance.new("TextLabel")
Name6.Name = "Name"
Name6.Size = UDim2.new(0, 192, 0, 28)
Name6.BackgroundTransparency = 1
Name6.Position = UDim2.new(0, 8, 0, 0)
Name6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name6.FontSize = Enum.FontSize.Size12
Name6.TextSize = 12
Name6.TextColor3 = Color3.fromRGB(255, 255, 255)
Name6.Text = "List Custom Icon"
Name6.Font = Enum.Font.GothamMedium
Name6.TextXAlignment = Enum.TextXAlignment.Left
Name6.Parent = IconList

local Theme18 = Instance.new("LocalScript")
Theme18.Name = "Theme"
Theme18.Parent = Name6

local down1 = Instance.new("ImageButton")
down1.Name = "down"
down1.LayoutOrder = 17
down1.ZIndex = 2
down1.AnchorPoint = Vector2.new(0, 0.5)
down1.Size = UDim2.new(0, 14, 0, 14)
down1.Rotation = 180
down1.BackgroundTransparency = 1
down1.Position = UDim2.new(1, -50, 0.5, 0)
down1.ImageRectOffset = Vector2.new(164, 284)
down1.Image = "rbxassetid://3926305904"
down1.ImageRectSize = Vector2.new(36, 36)
down1.Parent = IconList

local Theme19 = Instance.new("LocalScript")
Theme19.Name = "Theme"
Theme19.Parent = down1

local remove1 = Instance.new("ImageButton")
remove1.Name = "remove"
remove1.LayoutOrder = 17
remove1.ZIndex = 2
remove1.AnchorPoint = Vector2.new(0, 0.5)
remove1.Size = UDim2.new(0, 14, 0, 14)
remove1.BackgroundTransparency = 1
remove1.Position = UDim2.new(1, -20, 0.5, 0)
remove1.ImageRectOffset = Vector2.new(284, 4)
remove1.Image = "rbxassetid://3926305904"
remove1.ImageRectSize = Vector2.new(24, 24)
remove1.Parent = IconList

local Theme20 = Instance.new("LocalScript")
Theme20.Name = "Theme"
Theme20.Parent = remove1

local up1 = Instance.new("ImageButton")
up1.Name = "up"
up1.LayoutOrder = 17
up1.ZIndex = 2
up1.AnchorPoint = Vector2.new(0, 0.5)
up1.Size = UDim2.new(0, 14, 0, 14)
up1.BackgroundTransparency = 1
up1.Position = UDim2.new(1, -35, 0.5, 0)
up1.ImageRectOffset = Vector2.new(164, 284)
up1.Image = "rbxassetid://3926305904"
up1.ImageRectSize = Vector2.new(36, 36)
up1.Parent = IconList

local Theme21 = Instance.new("LocalScript")
Theme21.Name = "Theme"
Theme21.Parent = up1

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
ImageLabel.Size = UDim2.new(0, 14, 0, 14)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(1, -70, 0.5, 0)
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.ImageRectOffset = Vector2.new(124, 204)
ImageLabel.ImageRectSize = Vector2.new(36, 36)
ImageLabel.Image = "rbxassetid://3926305904"
ImageLabel.Parent = IconList

local Theme22 = Instance.new("LocalScript")
Theme22.Name = "Theme"
Theme22.Parent = ImageLabel

local List = Instance.new("TextButton")
List.Name = "List"
List.Size = UDim2.new(1, -14, 0, 28)
List.BackgroundTransparency = 0.975
List.Position = UDim2.new(0.0136054, 0, 0, 0)
List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
List.AutoButtonColor = false
List.FontSize = Enum.FontSize.Size14
List.TextSize = 14
List.TextColor3 = Color3.fromRGB(255, 255, 255)
List.Text = ""
List.Font = Enum.Font.SourceSans
List.Parent = Content1

local UICorner17 = Instance.new("UICorner")
UICorner17.CornerRadius = UDim.new(0, 6)
UICorner17.Parent = List

local Name7 = Instance.new("TextLabel")
Name7.Name = "Name"
Name7.Size = UDim2.new(0, 192, 0, 28)
Name7.BackgroundTransparency = 1
Name7.Position = UDim2.new(0, 8, 0, 0)
Name7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name7.FontSize = Enum.FontSize.Size12
Name7.TextSize = 12
Name7.TextColor3 = Color3.fromRGB(255, 255, 255)
Name7.Text = "List Normal"
Name7.Font = Enum.Font.GothamMedium
Name7.TextXAlignment = Enum.TextXAlignment.Left
Name7.Parent = List

local Theme23 = Instance.new("LocalScript")
Theme23.Name = "Theme"
Theme23.Parent = Name7

local down2 = Instance.new("ImageButton")
down2.Name = "down"
down2.LayoutOrder = 17
down2.ZIndex = 2
down2.AnchorPoint = Vector2.new(0, 0.5)
down2.Size = UDim2.new(0, 14, 0, 14)
down2.Rotation = 180
down2.BackgroundTransparency = 1
down2.Position = UDim2.new(1, -50, 0.5, 0)
down2.ImageRectOffset = Vector2.new(164, 284)
down2.Image = "rbxassetid://3926305904"
down2.ImageRectSize = Vector2.new(36, 36)
down2.Parent = List

local Theme24 = Instance.new("LocalScript")
Theme24.Name = "Theme"
Theme24.Parent = down2

local remove2 = Instance.new("ImageButton")
remove2.Name = "remove"
remove2.LayoutOrder = 17
remove2.ZIndex = 2
remove2.AnchorPoint = Vector2.new(0, 0.5)
remove2.Size = UDim2.new(0, 14, 0, 14)
remove2.BackgroundTransparency = 1
remove2.Position = UDim2.new(1, -20, 0.5, 0)
remove2.ImageRectOffset = Vector2.new(284, 4)
remove2.Image = "rbxassetid://3926305904"
remove2.ImageRectSize = Vector2.new(24, 24)
remove2.Parent = List

local Theme25 = Instance.new("LocalScript")
Theme25.Name = "Theme"
Theme25.Parent = remove2

local up2 = Instance.new("ImageButton")
up2.Name = "up"
up2.LayoutOrder = 17
up2.ZIndex = 2
up2.AnchorPoint = Vector2.new(0, 0.5)
up2.Size = UDim2.new(0, 14, 0, 14)
up2.BackgroundTransparency = 1
up2.Position = UDim2.new(1, -35, 0.5, 0)
up2.ImageRectOffset = Vector2.new(164, 284)
up2.Image = "rbxassetid://3926305904"
up2.ImageRectSize = Vector2.new(36, 36)
up2.Parent = List

local Theme26 = Instance.new("LocalScript")
Theme26.Name = "Theme"
Theme26.Parent = up2

local UICorner18 = Instance.new("UICorner")
UICorner18.Parent = Section1

local Name8 = Instance.new("TextLabel")
Name8.Name = "Name"
Name8.Size = UDim2.new(0, 192, 0, 28)
Name8.BackgroundTransparency = 1
Name8.Position = UDim2.new(0, 10, 0, 0)
Name8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name8.FontSize = Enum.FontSize.Size12
Name8.TextSize = 12
Name8.TextColor3 = Color3.fromRGB(255, 255, 255)
Name8.Text = "List"
Name8.Font = Enum.Font.GothamMedium
Name8.TextXAlignment = Enum.TextXAlignment.Left
Name8.Parent = Section1

local Theme27 = Instance.new("LocalScript")
Theme27.Name = "Theme"
Theme27.Parent = Name8

local Open1 = Instance.new("TextButton")
Open1.Name = "Open"
Open1.Size = UDim2.new(1, 0, 0, 28)
Open1.BackgroundTransparency = 1
Open1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Open1.AutoButtonColor = false
Open1.FontSize = Enum.FontSize.Size14
Open1.TextSize = 14
Open1.TextColor3 = Color3.fromRGB(0, 0, 0)
Open1.Text = ""
Open1.Font = Enum.Font.SourceSans
Open1.Parent = Section1

local Indicator2 = Instance.new("ImageLabel")
Indicator2.Name = "Indicator"
Indicator2.AnchorPoint = Vector2.new(1, 0)
Indicator2.Size = UDim2.new(0, 28, 0, 28)
Indicator2.Rotation = 180
Indicator2.BackgroundTransparency = 1
Indicator2.Position = UDim2.new(1, -7, 0.011, 0)
Indicator2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Indicator2.ImageRectOffset = Vector2.new(324, 524)
Indicator2.ImageRectSize = Vector2.new(36, 36)
Indicator2.Image = "rbxassetid://3926307971"
Indicator2.Parent = Section1

local Theme28 = Instance.new("LocalScript")
Theme28.Name = "Theme"
Theme28.Parent = Indicator2

local Frame1 = Instance.new("Frame") -- Tab Selector
Frame1.Size = UDim2.new(1, -12, 0, 26)
Frame1.BackgroundTransparency = 0.5
Frame1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame1.Parent = ScrollingFrame

local UICorner22 = Instance.new("UICorner")
UICorner22.Parent = Frame1

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(1, 0, 1, 0)
TextButton.BackgroundTransparency = 1
TextButton.BorderSizePixel = 0
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.FontSize = Enum.FontSize.Size14
TextButton.TextSize = 14
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.Text = ""
TextButton.Font = Enum.Font.SourceSans
TextButton.Parent = Frame1

local TextLabel2 = Instance.new("TextLabel")
TextLabel2.Size = UDim2.new(1, -6, 1, 0)
TextLabel2.BackgroundTransparency = 1
TextLabel2.Position = UDim2.new(0, 6, 0, 0)
TextLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel2.FontSize = Enum.FontSize.Size12
TextLabel2.TextSize = 12
TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel2.Text = "Tab"
TextLabel2.Font = Enum.Font.GothamMedium
TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
TextLabel2.Parent = Frame1

local Notifications = Instance.new("Frame")
Notifications.Name = "Notifications"
Notifications.AnchorPoint = Vector2.new(0, 0.5)
Notifications.Size = UDim2.new(0, 349, 0, 532)
Notifications.BackgroundTransparency = 1
Notifications.Position = UDim2.new(0.7000775, 0, 0.5, 0)
Notifications.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Notifications.Parent = Phindr

local UIListLayout4 = Instance.new("UIListLayout")
UIListLayout4.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout4.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout4.Padding = UDim.new(0, 6)
UIListLayout4.Parent = Notifications

local BanNotice = Instance.new("Frame")
BanNotice.Name = "BanNotice"
BanNotice.AnchorPoint = Vector2.new(1, 0)
BanNotice.Size = UDim2.new(0, 289, 0, 98)
BanNotice.Position = UDim2.new(1.0714285, -20, 0.4652256, 20)
BanNotice.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
BanNotice.Parent = Notifications

local UICorner24 = Instance.new("UICorner")
UICorner24.CornerRadius = UDim.new(0, 10)
UICorner24.Parent = BanNotice

local Img2 = Instance.new("ImageLabel")
Img2.Name = "Img"
Img2.AnchorPoint = Vector2.new(0, 0.5)
Img2.Size = UDim2.new(0, 46, 0, 46)
Img2.BackgroundTransparency = 1
Img2.Position = UDim2.new(0, 12, 0.5, 0)
Img2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Img2.ImageRectOffset = Vector2.new(364, 324)
Img2.ImageRectSize = Vector2.new(36, 36)
Img2.Image = "rbxassetid://3926305904"
Img2.Parent = BanNotice

local Name9 = Instance.new("TextLabel")
Name9.Name = "Name"
Name9.AnchorPoint = Vector2.new(0, 0.5)
Name9.Size = UDim2.new(0, 217, 0, 15)
Name9.BackgroundTransparency = 1
Name9.Position = UDim2.new(0, 65, 0.2753969, 0)
Name9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name9.FontSize = Enum.FontSize.Size18
Name9.TextSize = 15
Name9.RichText = true
Name9.TextColor3 = Color3.fromRGB(255, 255, 255)
Name9.Text = "Ban notice"
Name9.TextWrapped = true
Name9.Font = Enum.Font.SourceSansBold
Name9.TextWrap = true
Name9.TextXAlignment = Enum.TextXAlignment.Left
Name9.Parent = BanNotice

local Desc = Instance.new("TextLabel")
Desc.Name = "Desc"
Desc.AnchorPoint = Vector2.new(0, 0.5)
Desc.Size = UDim2.new(0, 217, 0, 47)
Desc.BackgroundTransparency = 1
Desc.Position = UDim2.new(0, 65, 0.5909863, 0)
Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Desc.FontSize = Enum.FontSize.Size18
Desc.TextSize = 15
Desc.RichText = true
Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
Desc.Text = "The following toggle (Autorob) you  used was a trap to catch bad apples  and you will be banned shortly :>"
Desc.TextYAlignment = Enum.TextYAlignment.Top
Desc.TextWrapped = true
Desc.Font = Enum.Font.SourceSansSemibold
Desc.TextWrap = true
Desc.TextXAlignment = Enum.TextXAlignment.Left
Desc.Parent = BanNotice

local FileSuccess = Instance.new("Frame")
FileSuccess.Name = "FileSuccess"
FileSuccess.AnchorPoint = Vector2.new(1, 0)
FileSuccess.Size = UDim2.new(0, 289, 0, 90)
FileSuccess.Position = UDim2.new(1.0714285, -20, 0.650376, 20)
FileSuccess.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
FileSuccess.Parent = Notifications

local UICorner25 = Instance.new("UICorner")
UICorner25.CornerRadius = UDim.new(0, 10)
UICorner25.Parent = FileSuccess

local Img3 = Instance.new("ImageLabel")
Img3.Name = "Img"
Img3.AnchorPoint = Vector2.new(0, 0.5)
Img3.Size = UDim2.new(0, 46, 0, 46)
Img3.BackgroundTransparency = 1
Img3.Position = UDim2.new(0, 12, 0.5, 0)
Img3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Img3.ImageRectOffset = Vector2.new(684, 404)
Img3.ImageRectSize = Vector2.new(36, 36)
Img3.Image = "rbxassetid://3926307971"
Img3.Parent = FileSuccess

local Name10 = Instance.new("TextLabel")
Name10.Name = "Name"
Name10.AnchorPoint = Vector2.new(0, 0.5)
Name10.Size = UDim2.new(0, 217, 0, 18)
Name10.BackgroundTransparency = 1
Name10.Position = UDim2.new(0, 65, 0.3365078, 0)
Name10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name10.FontSize = Enum.FontSize.Size18
Name10.TextSize = 15
Name10.RichText = true
Name10.TextColor3 = Color3.fromRGB(255, 255, 255)
Name10.Text = "New file saved!"
Name10.TextWrapped = true
Name10.Font = Enum.Font.SourceSansBold
Name10.TextWrap = true
Name10.TextXAlignment = Enum.TextXAlignment.Left
Name10.Parent = FileSuccess

local Desc1 = Instance.new("TextLabel")
Desc1.Name = "Desc"
Desc1.AnchorPoint = Vector2.new(0, 0.5)
Desc1.Size = UDim2.new(0, 217, 0, 29)
Desc1.BackgroundTransparency = 1
Desc1.Position = UDim2.new(0, 65, 0.6011904, 0)
Desc1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Desc1.FontSize = Enum.FontSize.Size18
Desc1.TextSize = 15
Desc1.RichText = true
Desc1.TextColor3 = Color3.fromRGB(255, 255, 255)
Desc1.Text = "Open <font color=\"rgb(255,75,75)\">workspace/PhindrDir</font> to view any changes made to your folder"
Desc1.TextYAlignment = Enum.TextYAlignment.Top
Desc1.TextWrapped = true
Desc1.Font = Enum.Font.SourceSansSemibold
Desc1.TextWrap = true
Desc1.TextXAlignment = Enum.TextXAlignment.Left
Desc1.Parent = FileSuccess

local Loaded = Instance.new("Frame")
Loaded.Name = "Loaded"
Loaded.AnchorPoint = Vector2.new(1, 0)
Loaded.Size = UDim2.new(0, 180, 0, 70)
Loaded.Position = UDim2.new(1.0714285, -20, 0.8308271, 20)
Loaded.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Loaded.Parent = Notifications

local UICorner26 = Instance.new("UICorner")
UICorner26.CornerRadius = UDim.new(0, 10)
UICorner26.Parent = Loaded

local Img4 = Instance.new("ImageLabel")
Img4.Name = "Img"
Img4.AnchorPoint = Vector2.new(0, 0.5)
Img4.Size = UDim2.new(0, 46, 0, 46)
Img4.BackgroundTransparency = 1
Img4.Position = UDim2.new(0, 12, 0.5, 0)
Img4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Img4.Image = "rbxassetid://5066318998"
Img4.Parent = Loaded

local Name11 = Instance.new("TextLabel")
Name11.Name = "Name"
Name11.AnchorPoint = Vector2.new(0, 0.5)
Name11.Size = UDim2.new(0, 217, 0, 24)
Name11.BackgroundTransparency = 1
Name11.Position = UDim2.new(0, 65, 0.5, 0)
Name11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name11.FontSize = Enum.FontSize.Size18
Name11.TextSize = 15
Name11.RichText = true
Name11.TextColor3 = Color3.fromRGB(255, 255, 255)
Name11.Text = "Phindr Loaded!"
Name11.TextWrapped = true
Name11.Font = Enum.Font.SourceSansBold
Name11.TextWrap = true
Name11.TextXAlignment = Enum.TextXAlignment.Left
Name11.Parent = Loaded

local Theme30 = Instance.new("LocalScript")
Theme30.Name = "Theme"
Theme30.Parent = Phindr

Phindr.Parent = game:GetService("Players").HazeWentMisty.PlayerGui
return Phindr
end,
}
local Loaded, Env: table = {}

import = function(dir)
    if not Loaded[dir] then
        Loaded[dir] = Vehicle_Importer[dir]()
    end
    return Loaded[dir]
end

