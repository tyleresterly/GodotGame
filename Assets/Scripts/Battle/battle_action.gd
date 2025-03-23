extends Node
class_name BattleAction

enum Action { ATTACK, NULL }

var action: Action
var entity: Entity
var target: Entity

func _init(entity, target, action) -> void:
	self.entity = entity
	self.target = target
	self.action = action 
