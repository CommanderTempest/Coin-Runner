import { Players } from "@rbxts/services";
import { Coin } from "./Coin.module";
import { MyTimer } from "./Timer.module";

const MATCH_LENGTH = 30; // in seconds

Players.PlayerAdded.Connect((p: Player) => {
  p.CharacterAdded.Connect((character) => beginMatch)
});

function beginMatch(character: Model)
{
  generateCoins(character);
  //dropBarrier();
  countdown();
}

function generateCoins(character: Model)
{
  let coinF = new Instance("Folder");
  let pos = character.PrimaryPart?.Position as Vector3;
  let myCoin = new Coin(coinF, pos);

  for (let i = 0; i<Coin.COINS_TO_GENERATE; i++)
  {
    myCoin.makeCoin();
  } // end for loop
}

function countdown()
{
  let time = new MyTimer(MATCH_LENGTH);

  while (time.getTimer() > 0)
  {
    wait(1);
    time.decrementTimer();
    // Give current time to client
  } // end while
} // end countdown
