extends NPC

@onready var signParticles: GPUParticles2D = $GPUParticles2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signParticles.emitting = false

func _on_interact_zone_body_entered(body: Node2D) -> void:
	super(body)
	if body.name == "Player":
		signParticles.emitting = true
			

func _on_interact_zone_body_exited(body: Node2D) -> void:
	super(body)
	if body.name == "Player":
		signParticles.emitting = false
