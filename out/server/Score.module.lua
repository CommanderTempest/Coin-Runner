-- Compiled with roblox-ts v1.2.9
local function incrementScore(currentScore)
	currentScore += 1
	return currentScore
end
local function setHighscore()
end
local function getHighscore()
end
-- this function unlike getHighscore, is retrieving the
-- high score for use within this file only
local function retrieveHighScore()
end
return {
	incrementScore = incrementScore,
	setHighscore = setHighscore,
	getHighscore = getHighscore,
}
