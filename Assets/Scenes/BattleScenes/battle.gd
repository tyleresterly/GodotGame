extends Control

class_name Battle 
@onready var battle_event = $CanvasLayer/BattleEvent
@onready var hp_bars: HBoxContainer  = $CanvasLayer/HPBars
@onready var attack_button: Button = $CanvasLayer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Attack
@onready var fight_timer: Timer = $FightTimer
@onready var generic_animations = preload("res://Assets/Scenes/Animations/generic_animations.tscn").instantiate()

signal on_add_to_queue
signal battle_ended

enum Action { ATTACK }
var party: Array[Entity]
var enemies: Array[Entity]
var turn_queue: Array[BattleAction]


func _ready() -> void:
	battle_event.text = "Fight has started"
	on_add_to_queue.connect(_on_add_to_queue)

func _process(delta: float) -> void:
	if fight_timer.time_left > 0:
		attack_button.disabled = true
	else:
		attack_button.disabled = false
	
func handle_turns():
	turn_queue.sort_custom(func(a: BattleAction, b: BattleAction): return a.entity.stats.speed < a.entity.stats.speed)
	while(!turn_queue.is_empty()):
		fight_timer.start()
		var turn = turn_queue.pop_front()
		await handle_action(turn.entity, turn.target, turn.action)

func set_party(party: Array[Entity]):
	self.party = party
	for party_member in party:
		var label = Label.new()
		label.text = party_member.name + ": " + str(party_member.stats.health)
		$CanvasLayer/HPBars.add_child(label)

		party_member.stats.health_changed.connect(func _on_health_change() -> void:
			label.text = party_member.name + ": " + str(party_member.stats.health)
			)
func set_enemies(enemies: Array[Entity]):
	self.enemies = enemies
	for enemy in enemies:
		var label = Label.new()
		label.text = enemy.name + ": " + str(enemy.stats.health)
		$CanvasLayer/HPBars.add_child(label)
		enemy.stats.health_changed.connect(func _on_health_change() -> void:
			label.text = enemy.name + ": " + str(enemy.stats.health)
			)
		enemy.stats.health_depleted.connect(func _on_health_depleted() -> void:
			enemies.remove_at(enemies.find(enemy))
			for turn in turn_queue:
				if turn.entity == enemy:
					turn_queue.remove_at(turn_queue.find(turn))
				if turn.target == enemy && !turn_queue.is_empty():
					turn.target = enemies[0]
			enemy.on_die.emit()
			if enemies.is_empty():
				battle_ended.emit()
			)
		

func handle_action(char: Entity, target: Entity, action: BattleAction.Action):
	match action:
		Action.ATTACK:
			var dmg = char.stats.base_attack
			target.stats.health -= dmg
			target.stats.health_changed.emit()
			battle_event.text = char.name + " attacked " + target.name + " for " + str(dmg) + " damage!"
			target.sprite.add_child(generic_animations)
			generic_animations.play("damage")
			await generic_animations.animation_finished
			target.sprite.remove_child(generic_animations)
		_:
			pass

func _on_attack_pressed() -> void:
	turn_queue.push_back(BattleAction.new(party[0], enemies[0], BattleAction.Action.ATTACK))
	on_add_to_queue.emit()
	turn_queue.push_back(BattleAction.new(enemies[0], party[0], BattleAction.Action.ATTACK))
	on_add_to_queue.emit()
	
func _on_add_to_queue():
	if len(turn_queue) == (len(party) + len(enemies)):
		handle_turns()
		
func end_battle():
	battle_event.text = "You win!"
	fight_timer.start()
	await fight_timer.timeout
	self.queue_free()
