import Remotes from "shared/remotes.module";

class MyTimer
{
  private timer: number;    // the seconds elapsed in the match.

  constructor(timer: number)
  {
    this.timer = timer;
  }

  getTimer() : number {return this.timer;}
  setTimer(num: number) {this.timer = num;}
  decrementTimer() {this.timer--;}

  countdown()
  {
    while (this.timer > 0)
    {
      wait(1);
      this.decrementTimer();
      Remotes.Server.Create("SendTimerToClient").SendToAllPlayers(this.timer);
    } // end while
  } // end countdown
} // end MyTimer

export {MyTimer}