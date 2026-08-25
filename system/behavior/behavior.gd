class_name Behavior extends Resource


@warning_ignore("unused_signal")

signal evaluation_requested


enum BehaviorType {

	AMBIENT,

	CONFLICT,

	PRESERVATION,

	SOCIAL,

}



@export var behavior_type: BehaviorType

@export var display_name: String

@export var requires_disposition:= false

@export var baseline_score:= 1.0

@export var inertia_multiplier:= 1.0




var active:= false

var entity: EntityNode

var attribute_remap: AttributeRemap

var navigation_component: NavigationComponent



var active_disposition: Disposition





func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	navigation_component = entity.get_component(NavigationComponent)

	attribute_remap = entity.entity_def.behavior_profile.get_remap(behavior_type)




func _evaluate(_disposition: Disposition = null) -> float:

	var attribute_miltiplier = _get_attribute_multiplier(_disposition)

	return baseline_score * attribute_miltiplier * inertia_multiplier





func _start(target_disposition: Disposition = null) -> void:

	active_disposition = target_disposition




func _stop(_target_disposition: Disposition = null) -> void:

	active_disposition = null








func _get_attribute_multiplier(disposition: Disposition = null) -> float:

	return _get_fear_multiplier(disposition) * _get_affection_multiplier(disposition) * _get_respect_multiplier(disposition) * _get_attitude_multiplier() * _get_temperament_multiplier()



func _get_fear_multiplier(target_disposition: Disposition = null) -> float:

	var score:= 1.0

	if target_disposition and attribute_remap:

		score = _get_curve_sample(attribute_remap.fear_curve, target_disposition.fear)

	return score



func _get_affection_multiplier(target_disposition: Disposition = null) -> float:

	var score:= 1.0

	if target_disposition and attribute_remap:

		score = _get_curve_sample(attribute_remap.affection_curve, target_disposition.fear)

	return score



func _get_respect_multiplier(target_disposition: Disposition = null) -> float:

	var score:= 1.0

	if target_disposition and attribute_remap:

		score = _get_curve_sample(attribute_remap.respect_curve, target_disposition.fear)

	return score


func _get_attitude_multiplier(target_disposition: Disposition = null) -> float:

	var score:= 1.0

	if target_disposition and attribute_remap:

		score = _get_curve_sample(attribute_remap.attitude_curve, target_disposition.fear)

	return score


func _get_temperament_multiplier(target_disposition: Disposition = null) -> float:

	var score:= 1.0

	if target_disposition and attribute_remap:

		score = _get_curve_sample(attribute_remap.temperament_curve, target_disposition.fear)

	return score



func _get_curve_sample(curve: Curve, value: float, domain_min:= 0.0, domain_max:= 1.0) -> float:

	if !curve: return 1.0

	return curve.sample(clampf(value, domain_min, domain_max))









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