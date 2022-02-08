import Remotes from "shared/remotes.module";
import { Players } from "@rbxts/services";
import Roact from '@rbxts/roact';

const playerGui = Players.LocalPlayer.FindFirstChild("PlayerGui") as PlayerGui;

const element = (<screengui></screengui>); // placeholder mount
const ele2 = (<screengui></screengui>);
const highScoreEle = (<screengui></screengui>);
let myHandle = Roact.mount(element, playerGui, "timerUI");
let myHandle2 = Roact.mount(ele2, playerGui, "scoreUI");
let myHandle3 = Roact.mount(highScoreEle, playerGui, "highscoreUI");

Remotes.Client.OnEvent("SendTimerToClient", (timer: number) => {
  const newElement = (
    <screengui>
      <textlabel
        Text={"Time Left: \n" + tostring(timer)}
        Size={new UDim2(0,300,0,300)}
        Position={new UDim2(0,150,0,0)}
      />
    </screengui>
  );
  myHandle = Roact.update(myHandle, newElement);
});

Remotes.Client.OnEvent("SendScoreToClient", (score: number) => {
  const newElement = (
    <screengui>
      <textlabel
        Text={"Score: " + tostring(score)}
        Size={new UDim2(0,150,0,150)}
        Position={new UDim2(0,1200,0,0)}
      />
    </screengui>
  )
  myHandle2 = Roact.update(myHandle2, newElement);
})

Remotes.Client.OnEvent("SendHighscoreToClient", (score: number) => {
  const newElement = (
    <screengui>
      <textlabel
        Text={"High Score: \n" + tostring(score)}
        Size={new UDim2(0,150,0,150)}
        Position={new UDim2(0,1200,0,-600)}
      />
    </screengui>
  )
  myHandle3 = Roact.update(myHandle3, newElement);
})
