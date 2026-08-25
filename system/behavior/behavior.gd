@abstract class_name Behavior extends Resource


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

@export var baseline_score:= 0.0

@export var inertia_multiplier:= 1.0




var active:= false

var entity: EntityNode

var behavior_component: BehaviorComponent

var attribute_remap: AttributeRemap

var navigation_component: NavigationComponent



var active_disposition: Disposition





func _initialize(_entity: EntityNode, _behavior_component: BehaviorComponent) -> void:

	entity = _entity

	behavior_component = _behavior_component

	navigation_component = entity.get_component(NavigationComponent)

	attribute_remap = entity.entity_def.behavior_profile.get_remap(behavior_type)




func _receive_damage_package(_damage_package: DamagePackage) -> void:

	pass




func _evaluate(_target_disposition: Disposition = null) -> float:

	var disposition_multiplier = 1.0

	return baseline_score * disposition_multiplier * inertia_multiplier





func _start(target_disposition: Disposition = null) -> void:

	active_disposition = target_disposition




func _stop(_target_disposition: Disposition = null) -> void:

	active_disposition = null








func _get_curve_sample(curve: Curve, value: float, domain_min:= 0.0, domain_max:= 1.0) -> float:

	if !curve: return 1.0

	return curve.sample(value)





func get_display_name() -> String:

	return get_script().get_global_name().trim_suffix("Behavior")






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