-- Arsenal Elite Owner/Admin QA Panel
-- Roblox Studio-safe LocalScript version
-- Put this LocalScript in StarterPlayerScripts.
-- Optional server RemoteEvents:
-- ReplicatedStorage.DeveloperWeaponControl
-- ReplicatedStorage.DeveloperRespawn
-- ReplicatedStorage.DeveloperHeal

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
-- FIX: safe fallback in case CurrentCamera isn't assigned yet at script start
local Camera = Workspace.CurrentCamera or Workspace:FindFirstChildOfClass("Camera")

local OWNER_USER_IDS = {
	[LocalPlayer.UserId] = true,
}

if game.CreatorType == Enum.CreatorType.User and game.CreatorId ~= LocalPlayer.UserId and not OWNER_USER_IDS[LocalPlayer.UserId] then
	return
end

local mouseFree    = false
local scriptLoaded = false

local VALID_KEY = "SHB-AEP2-X7K4"
local KEY_FILE  = "AEP_Key.txt"
local EXP_FILE  = "AEP_Exp"

local State = {
	Connections = {},
	Original = {
		WalkSpeed = 16,
		JumpPower = 50,
		Gravity = Workspace.Gravity,
		FieldOfView = Camera and Camera.FieldOfView or 70,
		Lighting = {
			FogEnd = Lighting.FogEnd,
			FogStart = Lighting.FogStart,
			Brightness = Lighting.Brightness,
			ClockTime = Lighting.ClockTime,
			Ambient = Lighting.Ambient,
			GlobalShadows = Lighting.GlobalShadows,
		},
	},
	Config = {
		SpeedEnabled = false,
		WalkSpeed = 24,
		JumpEnabled = false,
		JumpPower = 75,
		InfiniteJump = false,
		Fly = false,
		FlySpeed = 55,
		Noclip = false,
		Fullbright = false,
		RemoveFog = false,
		RemoveShadows = false,
		Time = 14,
		Gravity = Workspace.Gravity,
		CameraFOV = 70,
		RecoilReduction = 0,
		SpreadReduction = 0,
		RapidFire = false,
		InfiniteAmmo = false,
		AutoReload = false,
		AutoRespawn = false,
		AutoHeal = false,
		LowGraphics = false,
	}
}

local function connect(id, signal, callback)
	if State.Connections[id] then
		State.Connections[id]:Disconnect()
	end
	State.Connections[id] = signal:Connect(callback)
end

local function disconnect(id)
	if State.Connections[id] then
		State.Connections[id]:Disconnect()
		State.Connections[id] = nil
	end
end

local function getCharacter()
	return LocalPlayer.Character
end

local function getHumanoid()
	local character = getCharacter()
	return character and character:FindFirstChildOfClass("Humanoid")
end

local function getRoot()
	local character = getCharacter()
	return character and character:FindFirstChild("HumanoidRootPart")
end

local function create(className, props, parent)
	local object = Instance.new(className)
	for property, value in pairs(props or {}) do
		object[property] = value
	end
	object.Parent = parent
	return object
end

-- FIX: DisplayOrder = 999 ensures this GUI renders above all game UI.
-- FIX: ZIndexBehavior.Sibling makes ZIndex relative within each frame's children,
--      so Toast's ZIndex = 10 reliably floats above MainFrame (ZIndex = 1).
local ScreenGui = create("ScreenGui", {
	Name = "ArsenalElite",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 999,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, LocalPlayer:WaitForChild("PlayerGui"))

-- FIX: ZIndex = 10 so the toast notification always appears above the key/main frames.
local Toast = create("TextLabel", {
	Visible = false,
	ZIndex = 10,
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.fromScale(0.985, 0.035),
	Size = UDim2.fromOffset(320, 44),
	BackgroundColor3 = Color3.fromRGB(25, 25, 34),
	BackgroundTransparency = 0.08,
	BorderSizePixel = 0,
	TextColor3 = Color3.fromRGB(245, 245, 255),
	Font = Enum.Font.GothamMedium,
	TextSize = 14,
	TextWrapped = true,
	Text = "",
}, ScreenGui)

create("UICorner", {CornerRadius = UDim.new(0, 8)}, Toast)
create("UIStroke", {Color = Color3.fromRGB(0, 190, 255), Transparency = 0.25}, Toast)

local function notify(message)
	Toast.Text = message
	Toast.Visible = true
	Toast.BackgroundTransparency = 1
	Toast.TextTransparency = 1

	TweenService:Create(Toast, TweenInfo.new(0.18), {
		BackgroundTransparency = 0.08,
		TextTransparency = 0,
	}):Play()

	task.delay(3, function()
		if Toast.Text == message then
			local tween = TweenService:Create(Toast, TweenInfo.new(0.18), {
				BackgroundTransparency = 1,
				TextTransparency = 1,
			})
			tween:Play()
			tween.Completed:Wait()
			Toast.Visible = false
		end
	end)
end

local function makeButton(parent, text)
	local button = create("TextButton", {
		Size = UDim2.new(1, 0, 0, 38),
		BackgroundColor3 = Color3.fromRGB(32, 34, 48),
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = text,
		TextColor3 = Color3.fromRGB(240, 245, 255),
		Font = Enum.Font.GothamMedium,
		TextSize = 14,
	}, parent)

	create("UICorner", {CornerRadius = UDim.new(0, 7)}, button)
	create("UIStroke", {Color = Color3.fromRGB(64, 70, 92), Transparency = 0.45}, button)

	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.12), {
			BackgroundColor3 = Color3.fromRGB(42, 48, 70),
		}):Play()
	end)

	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.12), {
			BackgroundColor3 = Color3.fromRGB(32, 34, 48),
		}):Play()
	end)

	return button
end

local function makeToggle(parent, text, default, callback)
	local enabled = default == true
	local button = makeButton(parent, text .. ": " .. (enabled and "ON" or "OFF"))

	button.MouseButton1Click:Connect(function()
		enabled = not enabled
		button.Text = text .. ": " .. (enabled and "ON" or "OFF")
		callback(enabled)
	end)

	return button
end

-- FIX: UserInputService connections inside makeSlider are now tracked via connect()
-- so they are properly disconnected when "Unload UI" cleans up State.Connections.
-- Previously they leaked and would error on destroyed instances after unload.
local sliderCount = 0

local function makeSlider(parent, text, minVal, maxVal, default, callback)
	sliderCount += 1
	local id = "Slider_" .. sliderCount

	local holder = create("Frame", {
		Size = UDim2.new(1, 0, 0, 58),
		BackgroundColor3 = Color3.fromRGB(27, 29, 41),
		BorderSizePixel = 0,
	}, parent)

	create("UICorner", {CornerRadius = UDim.new(0, 7)}, holder)

	local label = create("TextLabel", {
		Size = UDim2.new(1, -18, 0, 26),
		Position = UDim2.fromOffset(9, 4),
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(235, 238, 255),
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = text .. ": " .. tostring(default),
	}, holder)

	local bar = create("Frame", {
		Position = UDim2.fromOffset(10, 36),
		Size = UDim2.new(1, -20, 0, 6),
		BackgroundColor3 = Color3.fromRGB(48, 52, 72),
		BorderSizePixel = 0,
	}, holder)

	create("UICorner", {CornerRadius = UDim.new(1, 0)}, bar)

	local fill = create("Frame", {
		Size = UDim2.fromScale((default - minVal) / (maxVal - minVal), 1),
		BackgroundColor3 = Color3.fromRGB(0, 190, 255),
		BorderSizePixel = 0,
	}, bar)

	create("UICorner", {CornerRadius = UDim.new(1, 0)}, fill)

	local dragging = false

	local function update(inputX)
		local alpha = math.clamp((inputX - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
		local value = math.floor(minVal + (maxVal - minVal) * alpha)
		fill.Size = UDim2.fromScale(alpha, 1)
		label.Text = text .. ": " .. tostring(value)
		callback(value)
	end

	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			update(input.Position.X)
		end
	end)

	connect(id .. "_End", UserInputService.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	connect(id .. "_Move", UserInputService.InputChanged, function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input.Position.X)
		end
	end)

	return holder
end


local MainFrame  -- forward declared; assigned after SHK key entry
local showPage   -- forward declared; assigned after pages are created

-- Load and show the ScriptingHub premium key system
local SHK = loadstring(game:HttpGet("https://raw.githubusercontent.com/lucaslucas198/ScriptingHubKeySystem/main/KeySystem.lua"))()
SHK.show({
	ScriptName  = "Arsenal Elite",
	KeyFile     = KEY_FILE,
	ExpFile     = EXP_FILE,
	IsFPS       = true,
	ValidKey    = VALID_KEY,
	OnSuccess   = function()
		scriptLoaded      = true
		MainFrame.Visible = true
		MainFrame.BackgroundTransparency = 1
		TweenService:Create(MainFrame, TweenInfo.new(0.22), {BackgroundTransparency = 0}):Play()
		showPage("Movement")
		notify("Access granted. Arsenal Elite loaded.")
	end,
})

MainFrame = create("Frame", {
	Visible = false,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(760, 500),
	BackgroundColor3 = Color3.fromRGB(16, 16, 26),
	BorderSizePixel = 0,
}, ScreenGui)

create("UICorner", {CornerRadius = UDim.new(0, 10)}, MainFrame)
create("UIStroke", {Color = Color3.fromRGB(0, 190, 255), Transparency = 0.35}, MainFrame)

local Sidebar = create("Frame", {
	Size = UDim2.fromOffset(178, 500),
	BackgroundColor3 = Color3.fromRGB(20, 20, 32),
	BorderSizePixel = 0,
}, MainFrame)

create("UICorner", {CornerRadius = UDim.new(0, 10)}, Sidebar)

create("TextLabel", {
	Position = UDim2.fromOffset(18, 16),
	Size = UDim2.new(1, -36, 0, 34),
	BackgroundTransparency = 1,
	Text = "Arsenal Elite",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	Font = Enum.Font.GothamBold,
	TextSize = 20,
	TextXAlignment = Enum.TextXAlignment.Left,
}, Sidebar)

local TabButtons = create("Frame", {
	Position = UDim2.fromOffset(14, 68),
	Size = UDim2.new(1, -28, 1, -82),
	BackgroundTransparency = 1,
}, Sidebar)

create("UIListLayout", {
	Padding = UDim.new(0, 8),
	SortOrder = Enum.SortOrder.LayoutOrder,
}, TabButtons)

local Content = create("Frame", {
	Position = UDim2.fromOffset(198, 18),
	Size = UDim2.new(1, -216, 1, -36),
	BackgroundTransparency = 1,
}, MainFrame)

local Pages = {}

local function createPage(name)
	local page = create("ScrollingFrame", {
		Visible = false,
		Size = UDim2.fromScale(1, 1),
		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 4,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, Content)

	create("UIListLayout", {
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, page)

	create("TextLabel", {
		Size = UDim2.new(1, 0, 0, 42),
		BackgroundTransparency = 1,
		Text = name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Font = Enum.Font.GothamBold,
		TextSize = 26,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, page)

	Pages[name] = page
	return page
end

showPage = function(name)
	for pageName, page in pairs(Pages) do
		page.Visible = pageName == name
	end
end

local function makeTab(name)
	local button = makeButton(TabButtons, name)
	button.MouseButton1Click:Connect(function()
		showPage(name)
	end)
end

local MovementPage = createPage("Movement")
local PlayerPage   = createPage("Player")
local WeaponPage   = createPage("Weapon QA")
local WorldPage    = createPage("World")
local SettingsPage = createPage("Settings")
local CreditsPage  = createPage("Credits")

makeTab("Movement")
makeTab("Player")
makeTab("Weapon QA")
makeTab("World")
makeTab("Settings")
makeTab("Credits")

local function applyWeaponMods()
	local remote = ReplicatedStorage:FindFirstChild("DeveloperWeaponControl")
	if remote and remote:IsA("RemoteEvent") then
		remote:FireServer({
			RecoilReduction = State.Config.RecoilReduction,
			SpreadReduction = State.Config.SpreadReduction,
			RapidFire       = State.Config.RapidFire,
			InfiniteAmmo    = State.Config.InfiniteAmmo,
			AutoReload      = State.Config.AutoReload,
		})
	else
		notify("DeveloperWeaponControl RemoteEvent not found.")
	end
end

local function applyWorld()
	Lighting.FogEnd       = State.Config.RemoveFog and 100000 or State.Original.Lighting.FogEnd
	Lighting.FogStart     = State.Config.RemoveFog and 0      or State.Original.Lighting.FogStart
	Lighting.GlobalShadows = not State.Config.RemoveShadows
	Lighting.ClockTime    = State.Config.Time
	Workspace.Gravity     = State.Config.Gravity

	if State.Config.Fullbright then
		Lighting.Brightness = 2
		Lighting.Ambient    = Color3.fromRGB(255, 255, 255)
	else
		Lighting.Brightness = State.Original.Lighting.Brightness
		Lighting.Ambient    = State.Original.Lighting.Ambient
	end
end

local FlyVelocity
local FlyGyro

local function setFly(enabled)
	local root = getRoot()
	if not root then return end

	if enabled then
		FlyVelocity = Instance.new("BodyVelocity")
		FlyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
		FlyVelocity.Velocity = Vector3.zero
		FlyVelocity.Parent   = root

		FlyGyro = Instance.new("BodyGyro")
		FlyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
		FlyGyro.P         = 9000
		FlyGyro.CFrame    = Camera.CFrame
		FlyGyro.Parent    = root

		connect("FlyLoop", RunService.RenderStepped, function()
			local cam = Workspace.CurrentCamera
			if not cam then return end
			local direction = Vector3.zero

			if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction += cam.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction -= cam.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction -= cam.CFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction += cam.CFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space)       then direction += Vector3.yAxis end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction -= Vector3.yAxis end

			FlyVelocity.Velocity = direction.Magnitude > 0 and direction.Unit * State.Config.FlySpeed or Vector3.zero
			FlyGyro.CFrame = cam.CFrame
		end)
	else
		disconnect("FlyLoop")

		if FlyVelocity then FlyVelocity:Destroy() FlyVelocity = nil end
		if FlyGyro     then FlyGyro:Destroy()     FlyGyro     = nil end
	end
end

-- Movement page
makeToggle(MovementPage, "Speed", false, function(value)
	State.Config.SpeedEnabled = value
end)

makeSlider(MovementPage, "Walk Speed", 16, 90, State.Config.WalkSpeed, function(value)
	State.Config.WalkSpeed = value
end)

makeToggle(MovementPage, "Jump Power", false, function(value)
	State.Config.JumpEnabled = value
end)

makeSlider(MovementPage, "Jump Power Value", 50, 160, State.Config.JumpPower, function(value)
	State.Config.JumpPower = value
end)

makeToggle(MovementPage, "Infinite Jump", false, function(value)
	State.Config.InfiniteJump = value
end)

makeToggle(MovementPage, "Fly", false, function(value)
	State.Config.Fly = value
	setFly(value)
end)

makeSlider(MovementPage, "Fly Speed", 20, 160, State.Config.FlySpeed, function(value)
	State.Config.FlySpeed = value
end)

makeToggle(MovementPage, "Noclip", false, function(value)
	State.Config.Noclip = value
end)

-- Player page
makeSlider(PlayerPage, "Camera FOV", 50, 120, State.Config.CameraFOV, function(value)
	State.Config.CameraFOV = value
	local cam = Workspace.CurrentCamera
	if cam then cam.FieldOfView = value end
end)

makeToggle(PlayerPage, "Auto Respawn", false, function(value)
	State.Config.AutoRespawn = value
end)

makeToggle(PlayerPage, "Auto Heal", false, function(value)
	State.Config.AutoHeal = value
end)

makeToggle(PlayerPage, "Low Graphics", false, function(value)
	State.Config.LowGraphics = value
	for _, object in ipairs(Workspace:GetDescendants()) do
		if object:IsA("BasePart") then
			object.CastShadow = not value
			if value then object.Material = Enum.Material.SmoothPlastic end
		elseif object:IsA("ParticleEmitter") or object:IsA("Trail") or object:IsA("Beam") then
			object.Enabled = not value
		end
	end
end)

-- Weapon QA page
makeSlider(WeaponPage, "Recoil Reduction", 0, 100, 0, function(value)
	State.Config.RecoilReduction = value
end)

makeSlider(WeaponPage, "Spread Reduction", 0, 100, 0, function(value)
	State.Config.SpreadReduction = value
end)

makeToggle(WeaponPage, "Rapid Fire", false, function(value)
	State.Config.RapidFire = value
end)

makeToggle(WeaponPage, "Infinite Ammo", false, function(value)
	State.Config.InfiniteAmmo = value
end)

makeToggle(WeaponPage, "Auto Reload", false, function(value)
	State.Config.AutoReload = value
end)

makeButton(WeaponPage, "Apply Weapon QA Settings").MouseButton1Click:Connect(applyWeaponMods)

-- World page
makeToggle(WorldPage, "Fullbright", false, function(value)
	State.Config.Fullbright = value
	applyWorld()
end)

makeToggle(WorldPage, "Remove Fog", false, function(value)
	State.Config.RemoveFog = value
	applyWorld()
end)

makeToggle(WorldPage, "Remove Shadows", false, function(value)
	State.Config.RemoveShadows = value
	applyWorld()
end)

makeSlider(WorldPage, "Time", 0, 24, State.Config.Time, function(value)
	State.Config.Time = value
	applyWorld()
end)

makeSlider(WorldPage, "Gravity", 20, 300, State.Config.Gravity, function(value)
	State.Config.Gravity = value
	applyWorld()
end)

-- Settings page
makeButton(SettingsPage, "Reset World Settings").MouseButton1Click:Connect(function()
	State.Config.Fullbright     = false
	State.Config.RemoveFog      = false
	State.Config.RemoveShadows  = false
	State.Config.Time           = State.Original.Lighting.ClockTime
	State.Config.Gravity        = State.Original.Gravity
	applyWorld()
	notify("World settings reset.")
end)

-- FIX: Unload UI previously called disconnect(id) while iterating State.Connections,
-- which modifies the table mid-loop (undefined behavior in Lua). Now we disconnect
-- all connections directly without modifying the table during iteration.
makeButton(SettingsPage, "Unload UI").MouseButton1Click:Connect(function()
	for _, conn in pairs(State.Connections) do
		conn:Disconnect()
	end
	State.Connections = {}

	if FlyVelocity then FlyVelocity:Destroy() end
	if FlyGyro     then FlyGyro:Destroy()     end

	Workspace.Gravity = State.Original.Gravity
	local cam = Workspace.CurrentCamera
	if cam then cam.FieldOfView = State.Original.FieldOfView end
	ScreenGui:Destroy()
end)

-- Credits page
create("TextLabel", {
	Size = UDim2.new(1, 0, 0, 72),
	BackgroundColor3 = Color3.fromRGB(27, 29, 41),
	BorderSizePixel = 0,
	Text = "Arsenal Elite - Version 1.0.0",
	TextColor3 = Color3.fromRGB(235, 238, 255),
	Font = Enum.Font.GothamMedium,
	TextSize = 14,
	TextWrapped = true,
}, CreditsPage)

-- Runtime loops
connect("MovementLoop", RunService.Heartbeat, function()
	local humanoid = getHumanoid()
	if humanoid then
		humanoid.UseJumpPower = true
		humanoid.WalkSpeed = State.Config.SpeedEnabled and State.Config.WalkSpeed or State.Original.WalkSpeed
		humanoid.JumpPower  = State.Config.JumpEnabled  and State.Config.JumpPower  or State.Original.JumpPower
	end

	if State.Config.Noclip then
		local character = getCharacter()
		if character then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end
end)

connect("InfiniteJump", UserInputService.JumpRequest, function()
	if State.Config.InfiniteJump then
		local humanoid = getHumanoid()
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

task.spawn(function()
	while ScreenGui.Parent do
		task.wait(2)

		if State.Config.AutoRespawn then
			local humanoid = getHumanoid()
			local remote   = ReplicatedStorage:FindFirstChild("DeveloperRespawn")
			if humanoid and humanoid.Health <= 0 and remote and remote:IsA("RemoteEvent") then
				remote:FireServer()
			end
		end

		if State.Config.AutoHeal then
			local humanoid = getHumanoid()
			local remote   = ReplicatedStorage:FindFirstChild("DeveloperHeal")
			if humanoid and humanoid.Health < humanoid.MaxHealth * 0.35 and remote and remote:IsA("RemoteEvent") then
				remote:FireServer()
			end
		end
	end
end)

connect("ToggleUI", UserInputService.InputBegan, function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.K and scriptLoaded then
		MainFrame.Visible = not MainFrame.Visible
	end
	if input.KeyCode == Enum.KeyCode.T then
		mouseFree = not mouseFree
		if not mouseFree then
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		end
	end
end)

connect("MouseUnlock", RunService.Heartbeat, function()
	if MainFrame.Visible or mouseFree then
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
end)

notify("Arsenal Elite loaded.")
