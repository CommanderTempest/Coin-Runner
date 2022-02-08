/*
Programmer: krukovv (Discord: Commander-Tempest)

This game was made to get me acclimated into TypeScript
Thus, it generally does not look well thought-out and this game is
made for only one person so I cut corners that I wouldn't cut if more then
1 were supposed to play

Known Issues:
 - When touching a coin, the player receives 1 point.
   However, if the player were to touch two coins at once, 
   they only receive 1 point instead of 2.
*/

import { Players, Workspace } from "@rbxts/services";
import { Coin } from "./Coin.module";
import { MyTimer } from "./Timer.module";
import Remotes from "shared/remotes.module";
import { incrementScore } from "./Score.module";

const MATCH_LENGTH = 30; // in seconds
let touchDebounce = false;  // a debounce to prevent touch spam

Players.PlayerAdded.Connect((p: Player) => {
  p.SetAttribute("score", 0);
  p.CharacterAdded.Connect(beginMatch);
});

function beginMatch(character: Model)
{
  generateCoins(character);
  //dropBarrier(); Unimportant currently
  countdown();
} // end beginMatch

function generateCoins(character: Model)
{
  let coinF = new Instance("Folder");
  let pos = character.PrimaryPart?.Position as Vector3;
  let myCoin = new Coin(coinF, pos);
  let createdCoin: Part;

  coinF.Parent = Workspace;

  for (let i = 0; i<Coin.COINS_TO_GENERATE; i++)
  {
    createdCoin = myCoin.makeCoin();
    createdCoin.Touched.Connect((otherPart) => coinTouched(otherPart, createdCoin))
    createdCoin.TouchEnded.Connect((otherPart) => {touchDebounce = false;})
  } // end for loop
} // end generateCoins

function countdown()
{
  let time = new MyTimer(MATCH_LENGTH);
  time.countdown();
} // end countdown

function coinTouched(otherPart: BasePart, coin: Part)
  {
    let playerChar, player, score: number;

    if (touchDebounce === false)
    {
      touchDebounce = true;
      if (otherPart.Parent?.FindFirstChild("Humanoid") !== undefined)
      {
        playerChar = otherPart.Parent;
        player = Players.GetPlayerFromCharacter(playerChar);
        score = player?.GetAttribute("score") as number; 
        score++;
        player?.SetAttribute("score", score);
        Remotes.Server.Create("SendScoreToClient").SendToAllPlayers(score);
        print("Valid! - Currentscore=" + score);
        print("Part - " + otherPart);
        coin.Destroy();
      } 
      else 
      {
        print("Invalid; Name: " + otherPart.Name); 
        touchDebounce = false;
      } // end if
    } // end if - debounce
  } // end coinTouched

