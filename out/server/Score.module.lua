-- Compiled with roblox-ts v1.2.9
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
--[[
	Game's not published so nothing in here actually matters right now, sorry.
]]
local DataStoreService = TS.import(script, TS.getModule(script, "@rbxts", "services")).DataStoreService
local store = DataStoreService:GetDataStore("highscore")
local function incrementScore(currentScore)
	currentScore += 1
	return currentScore
end
local function setHighscore(score)
	store:SetAsync("player1", score)
end
local function getHighscore()
	return store:GetAsync("player1")
end
return {
	incrementScore = incrementScore,
	setHighscore = setHighscore,
	getHighscore = getHighscore,
}
