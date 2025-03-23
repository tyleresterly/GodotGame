class_name Player extends Entity
const SPEED = 70
var dir = DIRECTION.DOWN
@onready var player: Player = $"."
@onready var interaction_available: Label = $InteractionAvailable

func _ready() -> void:
	print("INSTANTIATE")
	sprite = $AnimatedSprite2D
func _physics_process(delta: float) -> void:
	if action != ACTION.TALK:
		player_movement(delta)	

func player_movement(_delta):
	player.velocity.x = 0
	player.velocity.y = 0
	action = ACTION.IDLE
	if Input.is_action_pressed("right"):
		player.velocity.x = SPEED
		action = ACTION.WALK
		dir = DIRECTION.RIGHT

	if Input.is_action_pressed("left"):
		action = ACTION.WALK
		player.velocity.x = -SPEED
		dir = DIRECTION.LEFT

	if Input.is_action_pressed("up"):
		action = ACTION.WALK
		player.velocity.y = -SPEED
		
	if Input.is_action_pressed("down"):
		action = ACTION.WALK
		player.velocity.y = SPEED
	player.move_and_slide()

func on_talk():
	action = ACTION.TALK

func on_end_talk():
	action = ACTION.IDLE

func on_can_interact(_body: Node2D):
	interaction_available.visible = true
	
func on_cant_interact(_body: Node2D):
	interaction_available.visible = false
func play_animation():
	match action:
		ACTION.WALK:
			match dir:
				DIRECTION.RIGHT:
					sprite.play("walk")
					sprite.flip_h = true
				DIRECTION.LEFT:
					sprite.play("walk")
					sprite.flip_h = false
				_:
					sprite.play("walk")
		ACTION.TALK:
			sprite.play("talking")
		ACTION.IDLE:
			sprite.play("idle")
