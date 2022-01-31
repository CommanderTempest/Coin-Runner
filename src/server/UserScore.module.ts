class UserScore 
{
  private static scoreArray = new Array<UserScore>();
  private score;
  private username;

  constructor(username: string)
  {
    this.score = 0;
    this.username = username;
    if (this.retrieveUserFromArray(this.username) == undefined)
    {
      UserScore.scoreArray.push(this);
    } // end if
  }

  getUsername() {return this.username;}
  getScore() {return this.score;}
  setScore(score: number) {this.score = score;}
  incrementScore() {this.score++;}

  private retrieveUserFromArray(userName: string)
  {
    UserScore.scoreArray.forEach((score: UserScore) => {
      if (score.getUsername() == userName)
      {
        return score;
      } // end if
    }) // end for-each
    return undefined;
  } // end retrieveUserFromArray

  static retrieveUserArray()
  {
    return UserScore.scoreArray;
  } // end retrieveUserArray

  // highscore database functions down here somewhere.
  // submit a user's ID, this is because the userID is permanent, whereas a username can be changed.
} // end UserScore

export {UserScore}