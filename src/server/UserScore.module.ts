import { NamespaceBuilder } from "@rbxts/net/out/definitions/NamespaceBuilder";

class UserScore 
{
  private static scoreArray = new Array<UserScore>();
  private score;
  private username;

  constructor(username: string)
  {
    this.score = 0;
    this.username = username;
    UserScore.scoreArray.push(this);
  }

  getUsername() {return this.username;}
  getScore() {return this.score;}
  setScore(score: number) {this.score = score;}
  incrementScore() {this.score++;}

  static retrieveUserFromArray(userName: string)
  {
    UserScore.scoreArray.forEach((score: UserScore, i: number) => {
      if (score.getUsername() === userName)
      {
        return score;
      } // end if
    }) // end for-each
    //Problem to fix, in main.server.ts, kept saying it couldn't process this unless I returned only userScore, even when checking against, it errored.
    return UserScore.retrieveUserArray()[0];
  } // end retrieveUserFromArray

  static retrieveUserArray()
  {
    return UserScore.scoreArray;
  } // end retrieveUserArray

  // highscore database functions down here somewhere.
  // submit a user's ID, this is because the userID is permanent, whereas a username can be changed.
} // end UserScore

export {UserScore}