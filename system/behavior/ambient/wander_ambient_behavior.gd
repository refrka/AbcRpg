class_name WanderAmbientBehavior extends AmbientBehavior



@export var idle_duration_range:= Vector2(2.0, 4.0)

@export var wander_distance_range:= Vector2(100.0, 400.0)


var idle_timer:= 0.0





func evaluate(_target_disposition: Disposition = null) -> float:

	var score = super(_target_disposition)

	return score








func start() -> void:

	super()

	navigation_component.navigation_finished.connect(_on_navigation_finished)

	_idle()





func stop() -> void:

	super()

	navigation_component.navigation_finished.disconnect(_on_navigation_finished)





func _wander() -> void:

	var distance = _get_wander_distance()

	var direction = _get_wander_direction()

	var target_pos = entity.global_position + (distance * direction)

	navigation_component.set_target_position(target_pos)




func _idle() -> void:

	idle_timer = _get_idle_duration()










func _get_idle_duration() -> float:

	return randf_range(idle_duration_range.x, idle_duration_range.y)



func _get_wander_distance() -> float:

	return randf_range(wander_distance_range.x, wander_distance_range.y)



func _get_wander_direction() -> Vector2:

	return Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))




func _on_navigation_finished() -> void:

	_idle()






func tick(delta: float) -> void:

	if idle_timer > 0.0:

		idle_timer -= delta

		if idle_timer <= 0.0:

			_wander()