extends Node

enum GameStates {RUNNING, PAUSED, MENU}
var current_state:GameStates = GameStates.MENU

var game_controller: GameController
var mission_details: LevelButton
var player: Player
