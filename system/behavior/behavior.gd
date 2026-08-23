class_name Behavior extends Resource




@warning_ignore("unused_signal")

signal evaluation_requested


@export var display_name: String

@export var baseline_score:= 1.0

@export var entity_whitelist: Array[EntityDef]

@export var entity_blacklist: Array[EntityDef]



var active:= false




var entity: EntityNode

var movement_component: MovementComponent

var navigation_component: NavigationComponent




var target_disposition: Disposition








func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	movement_component = entity.get_component(MovementComponent)

	navigation_component = entity.get_component(NavigationComponent)





func _evaluate(_target_disposition: Disposition) -> float:

	target_disposition = _target_disposition

	if entity_blacklist.has(target_disposition.target_entity.entity_def):

		return 0.0

	return baseline_score






func _start() -> void:

	_activate()




func _stop() -> void:

	target_disposition = null

	_deactivate()








func _get_final_multiplier(baseline: float) -> float:

	var fear_multiplier:= 1.0

	var affection_multiplier:= 1.0

	var respect_multiplier:= 1.0

	var final_multiplier = baseline

	return final_multiplier








func _connect_signals() -> void:

	pass


func _disconnect_signals() -> void:

	pass



func _activate() -> void:

	if active: return

	active = true
	
	_connect_signals()



func _deactivate() -> void:

	if !active: return

	active = false

	_disconnect_signals()




func _tick(_delta: float) -> void:

	pass