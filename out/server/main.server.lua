-- Compiled with roblox-ts v1.2.9
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
--[[
	Programmer: krukovv (Discord: Commander-Tempest)
	This game was made to get me acclimated into TypeScript
	Thus, it generally does not look well thought-out and this game is
	made for only one person so I cut corners that I wouldn't cut if more then
	1 were supposed to play
	Known Issues:
	- When touching a coin, the player receives 1 point.
	However, if the player were to touch two coins at once,
	they only receive 1 point instead of 2.
]]
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local Workspace = _services.Workspace
local Coin = TS.import(script, game:GetService("ServerScriptService"), "TS", "Coin.module").Coin
local MyTimer = TS.import(script, game:GetService("ServerScriptService"), "TS", "Timer.module").MyTimer
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "remotes.module")
local MATCH_LENGTH = 30
local touchDebounce = false
local beginMatch
Players.PlayerAdded:Connect(function(p)
	p:SetAttribute("score", 0)
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
			createdCoin.TouchEnded:Connect(function(otherPart)
				touchDebounce = false
			end)
		end
	end
end
function countdown()
	local time = MyTimer.new(MATCH_LENGTH)
	time:countdown()
end
function coinTouched(otherPart, coin)
	local playerChar
	local player
	local score
	if touchDebounce == false then
		touchDebounce = true
		local _result = otherPart.Parent
		if _result ~= nil then
			_result = _result:FindFirstChild("Humanoid")
		end
		if _result ~= nil then
			playerChar = otherPart.Parent
			player = Players:GetPlayerFromCharacter(playerChar)
			local _result_1 = player
			if _result_1 ~= nil then
				_result_1 = _result_1:GetAttribute("score")
			end
			score = _result_1
			score += 1
			local _result_2 = player
			if _result_2 ~= nil then
				_result_2:SetAttribute("score", score)
			end
			Remotes.Server:Create("SendScoreToClient"):SendToAllPlayers(score)
			print("Valid! - Currentscore=" .. tostring(score))
			print("Part - " .. tostring(otherPart))
			coin:Destroy()
		else
			print("Invalid; Name: " .. otherPart.Name)
			touchDebounce = false
		end
	end
end
