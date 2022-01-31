import Net, { Definitions } from "@rbxts/net";

const Remotes = Net.Definitions.Create({
  SendTimerToClient: Definitions.ServerToClientEvent<[timer: number]>(),
  UpdateScore: Definitions.ServerToClientEvent<[]>(),
});

export = Remotes;