extends Node2D

class_name Entity
@export var char_name: String
@export var stats: EntityStats
@export var has_animations: bool = false
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

enum INTERACTION_TYPE {TALK, NULL}
enum ACTION { WALK, ATTACK, TALK, IDLE }
enum DIRECTION { LEFT, RIGHT, UP, DOWN }

var action = ACTION.IDLE

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if has_animations:
		play_animation()
		
func play_animation():
	match action:
		ACTION.IDLE:
			sprite.play("idle")
		ACTION.TALK:
			sprite.play("talking")
			
			
