import Remotes from "shared/remotes.module";
import { Players } from "@rbxts/services";
import Roact from '@rbxts/roact';

const playerGui = Players.LocalPlayer.FindFirstChild("PlayerGui") as PlayerGui;

const element = (<screengui></screengui>); // placeholder mount
let myHandle = Roact.mount(element, playerGui, "timerUI");

Remotes.Client.OnEvent("SendTimerToClient", (timer: number) => {
  const newElement = (
    <screengui>
      <textlabel
        Text={tostring(timer)}
        Size={new UDim2(0,300,0,300)}
        Position={new UDim2(0,150,0,0)}
      />
    </screengui>
  );
  myHandle = Roact.update(myHandle, newElement);
});
