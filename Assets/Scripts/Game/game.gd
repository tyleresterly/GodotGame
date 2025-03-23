extends Node


var scenes: Dictionary[String, String] = {
	'desert': 'uid://j0vauk7yvrpk'
}

var cur_game_scene: GameScene
var game_scene_manager: GameSceneManager

func _ready() -> void:
	SceneManager.change_scene(scenes['desert'])
	var scene = load(scenes['desert'])
	cur_game_scene = scene.instantiate() as GameScene
	game_scene_manager = GameSceneManager.new(cur_game_scene)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
