extends Node

var player_name:String = "____"
var player_id:String

enum GameStates {RUNNING, PAUSED, MENU}
var current_state:GameStates = GameStates.MENU
enum Transitions {NONE, FADE}


var game_controller: GameController
var player: Player
var main_camera: OrthogonalCamera
var mission_details: LevelButton
var current_level: Level
var goal_list_ui:Array[Control]
