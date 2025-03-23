class_name NPC extends Entity
@onready var interact_timer: Timer = $InteractTimer
@onready var interact_zone: Area2D = $InteractZone

var interactable = false
var in_bounds = false

signal on_talk_to_npc
signal on_end_talk_to_npc
signal on_fight_npc 
signal on_die

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_end_talk)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _process(delta: float) -> void:
	super(delta)
	if Input.is_action_just_pressed('interact') and interactable and in_bounds:
		emit_signal("on_talk_to_npc")
		action = ACTION.TALK
		interactable = false
		Dialogic.start(get_meta("Dialogue"))

func _on_interact_timer_timeout() -> void:
	interactable = true
	interact_timer.stop()

func _on_end_talk():
	emit_signal("on_end_talk_to_npc")
	action = ACTION.IDLE
	interact_timer.start()

func _on_interact_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_bounds = true
		interactable = true
		
func _on_interact_zone_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		in_bounds = false
		interactable = false
		
func _on_dialogic_signal(argument: String):
	print(get_meta("fight_signal"), argument)
	if has_meta("fight_signal") and argument == get_meta("fight_signal"):
		print("here")
		on_fight_npc.emit()
