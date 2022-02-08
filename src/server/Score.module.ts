/*
Game's not published so nothing in here actually matters right now, sorry.
*/

import { DataStoreService } from "@rbxts/services";

let store = DataStoreService.GetDataStore("highscore");

export function incrementScore(currentScore: number) {currentScore++; return currentScore;}
export function setHighscore(score: number) {store.SetAsync("player1", score);}
export function getHighscore() {return store.GetAsync("player1");}