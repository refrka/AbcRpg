class_name Sensor extends Area2D


signal entity_entered_sensor(entity: EntityNode)

signal entity_exited_sensor(entity: EntityNode)

signal sensor_entered_sensor(sensor: Sensor)

signal sensor_exited_sensor(sensor: Sensor)




@export var collision_shape: CollisionShape2D




var active:= false

var initialized:= false

var entity: EntityNode


var entities: Array[EntityNode]

var sensors: Array[Sensor]




func _initialize(_entity: EntityNode) -> bool:

	if initialized: return false

	initialized = true

	entity = _entity

	return false




func _reset() -> bool:

	if !initialized: return false

	_deactivate()

	initialized = false

	entity = null

	return true








func get_nearest_entity() -> EntityNode:

	var nearest_entity: EntityNode = null

	var nearest_distance = INF

	for _entity in entities:

		var distance = global_position.distance_to(_entity.global_position)

		if !nearest_entity or distance < nearest_distance:

			nearest_entity = _entity

			nearest_distance = distance

	return nearest_entity









func _connect_signals() -> void:

	if !initialized: return

	body_entered.connect(_on_body_entered_sensor)

	body_exited.connect(_on_body_exited_sensor)

	area_entered.connect(_on_area_entered_sensor)

	area_exited.connect(_on_area_exited_sensor)





func _disconnect_signals() -> void:

	if !initialized: return

	body_entered.disconnect(_on_body_entered_sensor)

	body_exited.disconnect(_on_body_exited_sensor)

	area_entered.disconnect(_on_area_entered_sensor)

	area_exited.disconnect(_on_area_exited_sensor)










func _on_body_entered_sensor(body: PhysicsBody2D) -> void:

	if body == entity or entities.has(body):

		return

	if body is EntityNode:

		entities.append(body)

		entity_entered_sensor.emit(body)




func _on_body_exited_sensor(body: PhysicsBody2D) -> void:

	if entities.has(body):

		entities.erase(body)

		entity_exited_sensor.emit(body)




func _on_area_entered_sensor(area: Area2D) -> void:

	if sensors.has(area):

		return

	if area is Sensor:

		if area.entity == entity:

			return

		sensors.append(area)

		sensor_entered_sensor.emit(area)



func _on_area_exited_sensor(area: Area2D) -> void:

	if !sensors.has(area):

		return

	sensors.erase(area)

	sensor_exited_sensor.emit(area)








func _activate() -> bool:

	if active: return false

	active = true

	collision_shape.disabled = false

	_connect_signals()

	return true





func _deactivate() -> bool:

	if !active: return false

	active = false

	collision_shape.disabled = true

	_disconnect_signals()

	entities.clear()

	sensors.clear()

	return true