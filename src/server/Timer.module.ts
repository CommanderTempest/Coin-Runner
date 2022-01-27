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
}

export {MyTimer}