-- Compiled with roblox-ts v1.2.9
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "remotes.module")
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
	function MyTimer:countdown()
		while self.timer > 0 do
			wait(1)
			self:decrementTimer()
			Remotes.Server:Create("SendTimerToClient"):SendToAllPlayers(self.timer)
		end
	end
end
return {
	MyTimer = MyTimer,
}
