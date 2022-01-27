-- Compiled with roblox-ts v1.2.9
local MyTimer
do
	MyTimer = setmetatable({}, {
		__tostring = function()
			return "MyTimer"
		end,
	})
	MyTimer.__index = MyTimer
	function MyTimer.new(...)
		local self = setmetatable({}, MyTimer)
		return self:constructor(...) or self
	end
	function MyTimer:constructor(timer)
		self.timer = timer
	end
	function MyTimer:getTimer()
		return self.timer
	end
	function MyTimer:setTimer(num)
		self.timer = num
	end
	function MyTimer:decrementTimer()
		self.timer -= 1
	end
end
return {
	MyTimer = MyTimer,
}
