extends Node2D
var battle_scene = preload("res://Assets/Scenes/BattleScenes/test.tscn")
@onready var bird_ninja: NPC = $BirdNinja
@onready var player: Player = $Player

var battle: Battle
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = battle_scene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	var party: Array[Entity] = [player]
	var enemies: Array[Entity] = [bird_ninja]
	self.add_child(instance)

	instance.set_party(party)
	instance.set_enemies(enemies)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
