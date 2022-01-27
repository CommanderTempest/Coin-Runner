-- Compiled with roblox-ts v1.2.9
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
local Coin = TS.import(script, game:GetService("ServerScriptService"), "TS", "Coin.module").Coin
local MyTimer = TS.import(script, game:GetService("ServerScriptService"), "TS", "Timer.module").MyTimer
local MATCH_LENGTH = 30
local beginMatch
Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(character)
		return beginMatch
	end)
end)
local generateCoins, countdown
function beginMatch(character)
	generateCoins(character)
	-- dropBarrier();
	countdown()
end
function generateCoins(character)
	local coinF = Instance.new("Folder")
	local _result = character.PrimaryPart
	if _result ~= nil then
		_result = _result.Position
	end
	local pos = _result
	local myCoin = Coin.new(coinF, pos)
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
		-- Give current time to client
	end
end
