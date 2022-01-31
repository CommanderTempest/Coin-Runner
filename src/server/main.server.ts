import { Players, Workspace } from "@rbxts/services";
import { Coin } from "./Coin.module";
import { MyTimer } from "./Timer.module";
import Remotes from "shared/remotes.module";
import { UserScore } from "./UserScore.module";

const MATCH_LENGTH = 30; // in seconds
let touchDebounce = false;  // a debounce to prevent touch spam

Players.PlayerAdded.Connect((p: Player) => {
  new UserScore(p.Name);
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
  } // end for loop
} // end generateCoins

function countdown()
{
  let time = new MyTimer(MATCH_LENGTH);

  while (time.getTimer() > 0)
  {
    wait(1);
    time.decrementTimer();
    Remotes.Server.Create("SendTimerToClient").SendToAllPlayers(time.getTimer());
  } // end while
} // end countdown

async function coinTouched(otherPart: BasePart, coin: Part)
  {
    let playerName;
    let playerScore: undefined | UserScore;

    if (touchDebounce === false)
    {
      touchDebounce = true;
      if (otherPart.Parent?.FindFirstChild("Humanoid") !== undefined)
      {
        playerName = otherPart.Parent.Name;
        playerScore = UserScore.retrieveUserFromArray(playerName);

        if (!typeIs(playerScore, "nil"))
        {
          playerScore.incrementScore();
          print("Currentscore = " + playerScore.getScore());
        }
        print(otherPart.Name);
        coin.Destroy();
        wait(1); // placeholder wait, because I can't figure out how to get it to wait until after the coins destroyed to remove debounce
      } // end if
      else {print("Invalid; Name: " + otherPart.Name);}
      touchDebounce = false;
    } // end if - debounce
  } // end coinTouched

