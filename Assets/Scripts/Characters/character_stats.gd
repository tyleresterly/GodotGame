class_name CharacterStats extends Resource

@export_category("Stats")
@export var base_max_health := 100
@export var base_attack := 10

## Emitted when [member health] has reached 0.
signal health_depleted
## Emitted whenever [member health] changes.
signal health_changed()

var max_health = base_max_health
var health := base_max_health:
	set(value):
		health = clampi(value, 0, max_health)
		health_changed.emit()
		if health == 0:
			health_depleted.emit()
