class_name Behavior extends Resource




var active:= false

var entity: EntityNode

var movement_component: MovementComponent




func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	movement_component = entity.get_component(MovementComponent)





func _evaluate(_data:= {}) -> float:

	return 1.0



func _start() -> void:

	_activate()


func _end() -> void:

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