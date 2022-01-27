
class Coin {
  static COINS_TO_GENERATE = 30;
  readonly OFFSET = 15;
  private parent;
  private prevCoinPos;

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
    let coin = new Instance("Part");
    coin.Parent = this.parent;
    coin.Name="Coin";
    coin.Size = new Vector3(2,2,2);
    coin.CanCollide = false;
    coin.Transparency = 0.5;
    coin.Anchored = true;
    coin.BrickColor = new BrickColor("New Yeller");
    coin.Position = this.setCoinOffset();
    this.prevCoinPos = coin.Position;
  } // end makeCoin

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
}

export {Coin};