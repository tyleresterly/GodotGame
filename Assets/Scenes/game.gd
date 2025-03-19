extends Node2D

@onready var npcs_node: Node = $NPCs
@onready var player: Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var npcs: Array[Node] = npcs_node.get_children()
	for npc in npcs:
		if npc.has_signal("on_talk_to_npc"):
			npc.connect("on_talk_to_npc", player.on_talk)
			npc.connect("on_end_talk_to_npc", player.on_end_talk)
			npc.interact_zone.connect("body_entered", player.on_can_interact)
			npc.interact_zone.connect("body_exited", player.on_cant_interact)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
