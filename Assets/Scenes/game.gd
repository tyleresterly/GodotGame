extends Node2D
@onready var npcs_node: Node2D = $DesertScene/NPCs
@onready var player: Player = $DesertScene/Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var npcs: Array[Node] = npcs_node.get_children()
	for npc in npcs:
		if npc.has_signal("on_talk_to_npc"):
			npc.connect("on_talk_to_npc", player.on_talk)
			npc.connect("on_end_talk_to_npc", player.on_end_talk)
			npc.interact_zone.connect("body_entered", player.on_can_interact)
			npc.interact_zone.connect("body_exited", player.on_cant_interact)
		if npc.has_signal("on_fight_npc"):
			npc.connect("on_fight_npc", func():
				var instance = preload("res://Assets/Scenes/BattleScenes/test.tscn").instantiate()
				instance.battle_ended.connect(func(): instance.end_battle())
				self.add_child(instance)
				var party: Array[Entity] = [player]
				var enemies: Array[Entity] = [npc]
				instance.set_party(party)
				instance.set_enemies(enemies)
				)
			npc.connect("on_die", func():
				npc.queue_free()
				)
			
func _process(delta: float) -> void:
	pass
