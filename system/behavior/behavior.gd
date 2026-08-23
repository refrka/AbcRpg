class_name Behavior extends Resource



@export var display_name: String

@export var baseline_score:= 1.0



var attitude: float

var temperament: float




var data: Dictionary

var active:= false

var entity: EntityNode

var target_entity: EntityNode

var movement_component: MovementComponent

var navigation_component: NavigationComponent



func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	movement_component = entity.get_component(MovementComponent)

	navigation_component = entity.get_component(NavigationComponent)





func _evaluate(_data:= {}) -> float:

	data = _data

	return baseline_score




func _reevaluate(_data:= {}) -> void:

	var behavior_component = entity.get_component(BehaviorComponent)

	behavior_component._choose_behavior(_data)





func _start() -> void:

	_activate()




func _stop() -> void:

	data = {}

	_deactivate()



func _connect_signals() -> void:

	pass


func _disconnect_signals() -> void:

	pass



func _activate() -> void:

	active = true
	
	_connect_signals()



func _deactivate() -> void:

	active = false

	_disconnect_signals()




func _tick(_delta: float) -> void:

	pass