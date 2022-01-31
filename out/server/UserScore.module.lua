-- Compiled with roblox-ts v1.2.9
local UserScore
do
	UserScore = setmetatable({}, {
		__tostring = function()
			return "UserScore"
		end,
	})
	UserScore.__index = UserScore
	function UserScore.new(...)
		local self = setmetatable({}, UserScore)
		return self:constructor(...) or self
	end
	function UserScore:constructor(username)
		self.score = 0
		self.username = username
		local _scoreArray = UserScore.scoreArray
		local _self = self
		-- ▼ Array.push ▼
		_scoreArray[#_scoreArray + 1] = _self
		-- ▲ Array.push ▲
	end
	function UserScore:getUsername()
		return self.username
	end
	function UserScore:getScore()
		return self.score
	end
	function UserScore:setScore(score)
		self.score = score
	end
	function UserScore:incrementScore()
		self.score += 1
	end
	function UserScore:retrieveUserFromArray(userName)
		local _scoreArray = UserScore.scoreArray
		local _arg0 = function(score, i)
			if score:getUsername() == userName then
				return score
			end
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _k, _v in ipairs(_scoreArray) do
			_arg0(_v, _k - 1, _scoreArray)
		end
		-- ▲ ReadonlyArray.forEach ▲
		-- Problem to fix, in main.server.ts, kept saying it couldn't process this unless I returned only userScore, even when checking against, it errored.
		return UserScore:retrieveUserArray()[1]
	end
	function UserScore:retrieveUserArray()
		return UserScore.scoreArray
	end
	UserScore.scoreArray = {}
end
return {
	UserScore = UserScore,
}
