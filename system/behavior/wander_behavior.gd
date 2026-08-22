class_name WanderBehavior extends Behavior




@export var idle_duration_range:= Vector2(2.0, 3.0)

@export var wander_distance_range:= Vector2(100.0, 200.0)

@export var wander_speed:= 50.0




var idle:= false

var idle_timer:= 0.0



var navigation_component: NavigationComponent




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	navigation_component = entity.get_component(NavigationComponent)



func _start() -> void:

	super()

	_wander()




func _connect_signals() -> void:

	navigation_component.navigation_completed.connect(_on_navigation_completed)




func _disconnect_signals() -> void:

	navigation_component.navigation_completed.disconnect(_on_navigation_completed)






func _wander() -> void:

	idle = false

	idle_timer = 0.0

	var wander_distance = randf_range(wander_distance_range.x, wander_distance_range.y)

	var wander_dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))

	var target_pos = entity.global_position + (wander_dir * wander_distance)

	navigation_component.set_target_position(target_pos)



func _idle() -> void:

	idle = true

	idle_timer = randf_range(idle_duration_range.x, idle_duration_range.y)





func _on_navigation_completed() -> void:

	_idle()






func _tick(delta: float) -> void:

	if idle and idle_timer > 0.0:

		idle_timer -= delta

		if idle_timer <= 0.0:

			_wander()



