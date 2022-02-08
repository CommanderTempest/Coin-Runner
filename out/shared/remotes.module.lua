-- Compiled with roblox-ts v1.2.9
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _net = TS.import(script, TS.getModule(script, "@rbxts", "net").out)
local Net = _net
local Definitions = _net.Definitions
local Remotes = Net.Definitions.Create({
	SendTimerToClient = Definitions.ServerToClientEvent(),
	SendScoreToClient = Definitions.ServerToClientEvent(),
	SendHighscoreToClient = Definitions.ServerToClientEvent(),
})
return Remotes
