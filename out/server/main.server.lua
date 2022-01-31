-- Compiled with roblox-ts v1.2.9
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local Workspace = _services.Workspace
local Coin = TS.import(script, game:GetService("ServerScriptService"), "TS", "Coin.module").Coin
local MyTimer = TS.import(script, game:GetService("ServerScriptService"), "TS", "Timer.module").MyTimer
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "remotes.module")
local UserScore = TS.import(script, game:GetService("ServerScriptService"), "TS", "UserScore.module").UserScore
local MATCH_LENGTH = 30
local touchDebounce = false
local beginMatch
Players.PlayerAdded:Connect(function(p)
	UserScore.new(p.Name)
	p.CharacterAdded:Connect(beginMatch)
end)
local generateCoins, countdown
function beginMatch(character)
	generateCoins(character)
	-- dropBarrier(); Unimportant currently
	countdown()
end
local coinTouched
function generateCoins(character)
	local coinF = Instance.new("Folder")
	local _result = character.PrimaryPart
	if _result ~= nil then
		_result = _result.Position
	end
	local pos = _result
	local myCoin = Coin.new(coinF, pos)
	local createdCoin
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
			createdCoin = myCoin:makeCoin()
			createdCoin.Touched:Connect(function(otherPart)
				return coinTouched(otherPart, createdCoin)
			end)
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
coinTouched = TS.async(function(otherPart, coin)
	local playerName
	local playerScore
	if touchDebounce == false then
		touchDebounce = true
		local _result = otherPart.Parent
		if _result ~= nil then
			_result = _result:FindFirstChild("Humanoid")
		end
		if _result ~= nil then
			playerName = otherPart.Parent.Name
			playerScore = UserScore:retrieveUserFromArray(playerName)
			local _playerScore = playerScore
			if not (type(_playerScore) == "nil") then
				playerScore:incrementScore()
				print("Currentscore = " .. tostring(playerScore:getScore()))
			end
			print(otherPart.Name)
			coin:Destroy()
			wait(1)
		else
			print("Invalid; Name: " .. otherPart.Name)
		end
		touchDebounce = false
	end
end)
