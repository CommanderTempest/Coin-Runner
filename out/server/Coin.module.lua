-- Compiled with roblox-ts v1.2.9
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
		local coin = Instance.new("Part")
		coin.Parent = self.parent
		coin.Name = "Coin"
		coin.Size = Vector3.new(2, 2, 2)
		coin.CanCollide = false
		coin.Transparency = 0.5
		coin.Anchored = true
		coin.BrickColor = BrickColor.new("New Yeller")
		coin.Position = self:setCoinOffset()
		print("Running to coinTouched")
		coin.Touched:Connect(function(otherPart)
			return self:coinTouched(otherPart, coin)
		end)
		coin.TouchEnded:Connect(function()
			coin:Destroy()
		end)
		self.prevCoinPos = coin.Position
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
		print(otherPart.Name)
		print("This is valid!")
	end
	Coin.COINS_TO_GENERATE = 30
end
return {
	Coin = Coin,
}
