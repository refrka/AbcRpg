@abstract class_name Behavior extends Resource



@warning_ignore("unused_signal")

signal evaluation_requested



@export var baseline_value:= 1.0

@export var attribute_map: AttributeMap

var entity: EntityNode

var behavior_component: BehaviorComponent

var target_disposition: Disposition

var last_evaluated_disposition: Disposition







func initialize(_entity: EntityNode, _behavior_component: BehaviorComponent) -> void:

	entity = _entity

	behavior_component = _behavior_component





func evaluate(disposition: Disposition = null) -> float:

	if disposition and disposition != last_evaluated_disposition:

		last_evaluated_disposition = disposition

		last_evaluated_disposition.expired.connect(_on_last_evaluated_disposition_expired, CONNECT_ONE_SHOT)

	print(last_evaluated_disposition, " last eval")

	var attribute_multiplier = _get_attribute_multiplier()

	return baseline_value * attribute_multiplier





func start() -> void:

	pass



func stop() -> void:

	pass



func get_display_name() -> String:

	return get_script().get_global_name().trim_suffix("Behavior")





func _get_attribute_multiplier() -> float:

	var fear = _get_fear_multiplier()

	var affection = _get_affection_multiplier()

	var respect = _get_respect_multiplier()

	var attitude = _get_attitude_multiplier()

	var temperament = _get_temperament_multiplier()

	return fear * affection * respect * attitude * temperament




func _get_fear_multiplier() -> float:

	return 1.0


func _get_affection_multiplier() -> float:

	return 1.0


func _get_respect_multiplier() -> float:

	return 1.0


func _get_attitude_multiplier() -> float:

	return 1.0


func _get_temperament_multiplier() -> float:

	return 1.0






func _on_last_evaluated_disposition_expired() -> void:

	print("its expired")

	last_evaluated_disposition = null





func tick(_delta: float) -> void:

	pass




