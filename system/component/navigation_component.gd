class_name NavigationComponent extends Component


signal navigation_completed


@export var nav_agent: NavigationAgent2D



var movement_component: MovementComponent



var target_position: Vector2

var target_entity: EntityNode

var current_path_position: Vector2




var update_timer:= 0.0





func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity): return false

	movement_component = entity.get_component(MovementComponent)

	return true








func set_target_position(position: Vector2) -> void:

	update_timer = 0.0

	if target_position == position: return

	target_position = position

	nav_agent.target_position = position





func set_target_entity(entity_node: EntityNode) -> void:

	target_entity = entity_node





func _on_navigation_finished() -> void:

	movement_component.halt()

	navigation_completed.emit()






func _connect_signals() -> void:

	nav_agent.navigation_finished.connect(_on_navigation_finished)




func _disconnect_signals() -> void:

	nav_agent.navigation_finished.disconnect(_on_navigation_finished)




func _physics_process(delta: float) -> void:

	if !active: return

	if target_entity and update_timer < 0.2:

		update_timer += delta

		if update_timer >= 0.2:

			set_target_position(target_entity.global_position)

	if nav_agent.is_navigation_finished(): return

	current_path_position = nav_agent.get_next_path_position()

	var move_dir = entity.global_position.direction_to(current_path_position)

	movement_component.set_move_dir(move_dir)
