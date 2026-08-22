class_name Hitbox extends Sensor



signal hit_detected(entity_node: EntityNode)




var hit_list: Array[Hurtbox]

var ignore_list: Array[EntityNode]




func clear_hit_list() -> void:

	hit_list.clear()





func _on_area_entered_sensor(area: Area2D) -> void:

	area = area as Hurtbox

	if !area.active or area.entity == entity or ignore_list.has(area.entity):

		return

	if hit_list.has(area):

		return

	hit_list.append(area)

	hit_detected.emit(area.entity)



