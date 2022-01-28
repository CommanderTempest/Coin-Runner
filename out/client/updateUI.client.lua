-- Compiled with roblox-ts v1.2.9
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "remotes.module")
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
local element = (Roact.createElement("ScreenGui"))
local myHandle = Roact.mount(element, playerGui, "timerUI")
Remotes.Client:OnEvent("SendTimerToClient", function(timer)
	local newElement = (Roact.createElement("ScreenGui", {}, {
		Roact.createElement("TextLabel", {
			Text = tostring(timer),
			Size = UDim2.new(0, 300, 0, 300),
			Position = UDim2.new(0, 150, 0, 0),
		}),
	}))
	myHandle = Roact.update(myHandle, newElement)
end)
