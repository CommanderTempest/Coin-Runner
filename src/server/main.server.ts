import { Players, Workspace } from "@rbxts/services";
import { Coin } from "./Coin.module";
import { MyTimer } from "./Timer.module";
import Remotes from "shared/remotes.module";

const MATCH_LENGTH = 30; // in seconds

Players.PlayerAdded.Connect((p: Player) => {
  print("B");
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
  print("G");
  let coinF = new Instance("Folder");
  let pos = character.PrimaryPart?.Position as Vector3;
  let myCoin = new Coin(coinF, pos);

  coinF.Parent = Workspace;

  for (let i = 0; i<Coin.COINS_TO_GENERATE; i++)
  {
    myCoin.makeCoin();
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
