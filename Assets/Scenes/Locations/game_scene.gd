extends Node2D

class_name GameScene
var npcs: Array[Entity]
var player: Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var npc_nodes = find_child('NPCs').get_children()  as Array[Entity]
	npcs.assign(npc_nodes)
	player = find_child('Player') as Player
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
