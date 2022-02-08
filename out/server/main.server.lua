-- Compiled with roblox-ts v1.2.9
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
--[[
	Programmer: krukovv (Discord: Commander-Tempest)
	This game was made to get me acclimated into TypeScript
	Thus, it generally does not look well thought-out and this game is
	made for only one person so I cut corners that I wouldn't cut if more then
	1 were supposed to play
	Known Terrible Ideas (So you don't have to repeat what someone else has said):
	- Using classes for mundane things (timer)
]]
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local Workspace = _services.Workspace
local Coin = TS.import(script, game:GetService("ServerScriptService"), "TS", "Coin.module").Coin
local MyTimer = TS.import(script, game:GetService("ServerScriptService"), "TS", "Timer.module").MyTimer
local MATCH_LENGTH = 30
local beginMatch
Players.PlayerAdded:Connect(function(p)
	p:SetAttribute("score", 0)
	p.CharacterAdded:Connect(beginMatch)
end)
local generateCoins, countdown, endMatch
function beginMatch(character)
	generateCoins(character)
	countdown()
	endMatch()
end
function endMatch()
	local coinF = Workspace:FindFirstChild("coinF")
	local coins = coinF:GetDescendants()
	local _coins = coins
	local _arg0 = function(element)
		element:Destroy()
	end
	-- ▼ ReadonlyArray.forEach ▼
	for _k, _v in ipairs(_coins) do
		_arg0(_v, _k - 1, _coins)
	end
	-- ▲ ReadonlyArray.forEach ▲
end
function generateCoins(character)
	local coinF = Instance.new("Folder")
	coinF.Name = "coinF"
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
		end
	end
end
function countdown()
	local time = MyTimer.new(MATCH_LENGTH)
	time:countdown()
end
