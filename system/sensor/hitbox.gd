class_name Hitbox extends Sensor



signal hit_detected(entity_node: EntityNode)




var hit_list: Array[Hurtbox]

var ignore_list: Array[EntityNode]


var hit_timer:= 0.0




func clear_hit_list() -> void:

	hit_list.clear()




func _start_timer() -> void:

	hit_timer = 3.0



func _expire_hit() -> void:

	print("expire hit")

	clear_hit_list()

	hit_timer = 0.0

	for area in sensors:

		if area is Hurtbox:

			_hit(area)





func _hit(hurtbox: Hurtbox) -> void:

	hit_list.append(hurtbox)

	hit_detected.emit(hurtbox.entity)

	_start_timer()






func _on_area_entered_sensor(area: Area2D) -> void:

	super(area)

	area = area as Hurtbox

	if !area.active or area.entity == entity or ignore_list.has(area.entity):

		return

	if hit_list.has(area):

		return

	_hit(area)
	





func _process(delta: float) -> void:

	if hit_timer > 0.0:

		hit_timer -= delta

		if hit_timer <= 0.0:

			_expire_hit()