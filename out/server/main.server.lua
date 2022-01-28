-- Compiled with roblox-ts v1.2.9
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local Workspace = _services.Workspace
local Coin = TS.import(script, game:GetService("ServerScriptService"), "TS", "Coin.module").Coin
local MyTimer = TS.import(script, game:GetService("ServerScriptService"), "TS", "Timer.module").MyTimer
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "remotes.module")
local MATCH_LENGTH = 30
local beginMatch
Players.PlayerAdded:Connect(function(p)
	print("B")
	p.CharacterAdded:Connect(beginMatch)
end)
local generateCoins, countdown
function beginMatch(character)
	generateCoins(character)
	-- dropBarrier(); Unimportant currently
	countdown()
end
function generateCoins(character)
	print("G")
	local coinF = Instance.new("Folder")
	local _result = character.PrimaryPart
	if _result ~= nil then
		_result = _result.Position
	end
	local pos = _result
	local myCoin = Coin.new(coinF, pos)
	coinF.Parent = Workspace
	do
		local i = 0
		local _shouldIncrement = false
		while true do
			if _shouldIncrement then
				i += 1
			else
				_shouldIncrement = true
			end
			if not (i < Coin.COINS_TO_GENERATE) then
				break
			end
			myCoin:makeCoin()
		end
	end
end
function countdown()
	local time = MyTimer.new(MATCH_LENGTH)
	while time:getTimer() > 0 do
		wait(1)
		time:decrementTimer()
		Remotes.Server:Create("SendTimerToClient"):SendToAllPlayers(time:getTimer())
	end
end
