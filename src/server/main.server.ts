/*
Programmer: krukovv (Discord: Commander-Tempest)

This game was made to get me acclimated into TypeScript
Thus, it generally does not look well thought-out and this game is
made for only one person so I cut corners that I wouldn't cut if more then
1 were supposed to play

Known Terrible Ideas (So you don't have to repeat what someone else has said):
 - Using classes for mundane things (timer)
*/

import { Players, Workspace } from "@rbxts/services";
import { Coin } from "./Coin.module";
import { MyTimer } from "./Timer.module";
import Remotes from "shared/remotes.module";

const MATCH_LENGTH = 30; // in seconds

Players.PlayerAdded.Connect((p: Player) => {
  p.SetAttribute("score", 0);
  p.CharacterAdded.Connect(beginMatch);
});

function beginMatch(character: Model)
{
  generateCoins(character);
  countdown();
  endMatch();
} // end beginMatch

function endMatch()
{
  let coinF = Workspace.FindFirstChild("coinF") as Folder;
  let coins = coinF.GetDescendants();
  coins.forEach((element) => {
    element.Destroy();
  })
} // end endMatch

function generateCoins(character: Model)
{
  let coinF = new Instance("Folder");
  coinF.Name = "coinF";
  let pos = character.PrimaryPart?.Position as Vector3;
  let myCoin = new Coin(coinF, pos);
  let createdCoin: Part;

  coinF.Parent = Workspace;

  for (let i = 0; i<Coin.COINS_TO_GENERATE; i++)
  {
    createdCoin = myCoin.makeCoin();
  } // end for loop
} // end generateCoins

function countdown()
{
  let time = new MyTimer(MATCH_LENGTH);
  time.countdown();
} // end countdown

