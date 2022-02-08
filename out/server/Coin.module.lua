-- Compiled with roblox-ts v1.2.9
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "remotes.module")
local touchDebounce = false
local Coin
do
	Coin = setmetatable({}, {
		__tostring = function()
			return "Coin"
		end,
	})
	Coin.__index = Coin
	function Coin.new(...)
		local self = setmetatable({}, Coin)
		return self:constructor(...) or self
	end
	function Coin:constructor(parent, playerPos)
		self.OFFSET = 15
		self.parent = parent
		self.prevCoinPos = playerPos
	end
	function Coin:makeCoin()
		local random
		local coin = Instance.new("Part")
		coin.Parent = self.parent
		coin.Size = Vector3.new(2, 2, 2)
		coin.CanCollide = false
		coin.Transparency = 0.5
		coin.Anchored = true
		random = math.random(0, 10)
		if random < 9 then
			coin = self:makeNormalCoin(coin)
		else
			coin = self:makePowerup(coin)
		end
		coin.Position = self:setCoinOffset()
		coin.Touched:Connect(function(otherPart)
			self:coinTouched(otherPart, coin)
		end)
		coin.TouchEnded:Connect(function()
			touchDebounce = false
		end)
		self.prevCoinPos = coin.Position
		return coin
	end
	function Coin:makeNormalCoin(coin)
		coin.Name = "Coin"
		coin.BrickColor = BrickColor.new("New Yeller")
		return coin
	end
	function Coin:makePowerup(coin)
		coin.Name = "Speed-Power"
		coin.BrickColor = BrickColor.new("Bright violet")
		return coin
	end
	function Coin:setCoinOffset()
		local num1
		local num2
		local num3
		local offset = self.OFFSET
		num1 = math.random(-offset, offset)
		offset -= num1
		num3 = math.random(-offset, offset)
		-- if the coin is too high, randomize lower
		if self.prevCoinPos.Y > 6 then
			num2 = math.random(-5, 0)
		else
			num2 = math.random(0, 5)
		end
		local _prevCoinPos = self.prevCoinPos
		local _vector3 = Vector3.new(num1, num2, num3)
		return _prevCoinPos + _vector3
	end
	function Coin:coinTouched(otherPart, coin)
		local playerChar
		local player
		local score
		local pHumanoid
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
				if coin.Name == "Speed-Power" then
					print("POWERUP RECEIVED!")
					local _result_3 = otherPart.Parent
					if _result_3 ~= nil then
						_result_3 = _result_3:FindFirstChild("Humanoid")
					end
					pHumanoid = _result_3
					pHumanoid.WalkSpeed = 32
				end
				coin:Destroy()
			else
				print("Invalid; Name: " .. otherPart.Name)
				touchDebounce = false
			end
		end
	end
	Coin.COINS_TO_GENERATE = 30
end
return {
	Coin = Coin,
}
