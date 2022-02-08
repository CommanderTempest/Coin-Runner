import Net, { Definitions } from "@rbxts/net";

const Remotes = Net.Definitions.Create({
  SendTimerToClient: Definitions.ServerToClientEvent<[timer: number]>(),
  SendScoreToClient: Definitions.ServerToClientEvent<[score: number]>(),
});

export = Remotes;