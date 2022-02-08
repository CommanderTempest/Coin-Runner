import {Players} from "@rbxts/services";
import Remotes from "shared/remotes.module";

let touchDebounce = false;

class Coin {
  static COINS_TO_GENERATE = 30;  // max # of coins to generate
  readonly OFFSET = 15;           // offset between coin spawns

  private parent;                 // parent object of the coin
  private prevCoinPos;            // position of the previous coin

  constructor (parent: Folder, playerPos: Vector3)
  {
    this.parent = parent;
    this.prevCoinPos = playerPos;
  } 

  //********************************************************

  // makeCoin sets all the properties of coin, and calls
  // a helper function to set it's position

  makeCoin()
  {
    let random: number;
    let coin = new Instance("Part");
    coin.Parent = this.parent;

    coin.Size = new Vector3(2,2,2);
    coin.CanCollide = false;
    coin.Transparency = 0.5;
    coin.Anchored = true;

    random = math.random(0,10);

    if (random<9)
    {
      coin = this.makeNormalCoin(coin);
    }
    else 
    {
      coin = this.makePowerup(coin);
    } // end if
  
    coin.Position = this.setCoinOffset();
    coin.Touched.Connect((otherPart) => {this.coinTouched(otherPart, coin)});
    coin.TouchEnded.Connect(() => { touchDebounce = false;})
    this.prevCoinPos = coin.Position;
    return coin;
  } // end makeCoin

  private makeNormalCoin(coin: Part): Part
  {
    coin.Name="Coin";
    coin.BrickColor = new BrickColor("New Yeller");
    return coin;
  }

  private makePowerup(coin: Part): Part
  {
    coin.Name="Speed-Power"
    coin.BrickColor = new BrickColor("Bright violet");
    return coin;
  }

  // *******************************************************
  // ***HELPER FUNCTIONS***

  // setCoinOffset calculates the distance between the previously
  // configured coin and the new one

  private setCoinOffset() : Vector3
  {
    let num1, num2, num3;      // X,Y,Z (randomized)
    let offset = this.OFFSET;  // Distance between coins as they are placed

    num1 = math.random(-offset, offset); // X
    offset -= num1;
    num3 = math.random(-offset, offset); // Z

    // if the coin is too high, randomize lower
    if (this.prevCoinPos.Y > 6)
    {
      num2 = math.random(-5, 0);
    }
    else
    {
      num2 = math.random(0, 5);
    } // end if

    return this.prevCoinPos.add(new Vector3(num1, num2, num3));
  } // end setCoinOffset

  /*
    coinTouched gives the player points, 
    and the walkspeed powerup if they touched a powerup.

    Issue?: This works in here, but has issues with the debounce
    in a server script. The best idea I got is because
    I was indexing coin.Touched in multiple places
    on the same object.
  */

  private coinTouched(otherPart: BasePart, coin: Part)
  {
    let playerChar, player, score: number, pHumanoid: Humanoid;

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

        if (coin.Name === "Speed-Power")
        {
          print("POWERUP RECEIVED!")
          pHumanoid = otherPart.Parent?.FindFirstChild("Humanoid") as Humanoid;
          pHumanoid.WalkSpeed = 32;
        } // end if
        coin.Destroy();
      } 
      else 
      {
        print("Invalid; Name: " + otherPart.Name); 
        touchDebounce = false;
      } // end if
    } // end if - debounce
  } // end coinTouched
} // end Coin

export {Coin};