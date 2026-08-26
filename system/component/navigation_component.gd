class_name NavigationComponent extends Component



@export var nav_agent: NavigationAgent2D




var current_target_position: Vector2

var movement_component: MovementComponent



func initialize(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)







func _connect_signals() -> void:

	nav_agent.navigation_finished.connect(_on_navigation_finished)



func _disconnect_signals() -> void:

	nav_agent.navigation_finished.disconnect(_on_navigation_finished)




func set_target_position(target_position: Vector2) -> void:

	current_target_position = target_position

	nav_agent.target_position = target_position











func _on_navigation_finished() -> void:

	movement_component.halt()








func _physics_process(_delta: float) -> void:

	if !nav_agent.is_navigation_finished():

		var next_position = nav_agent.get_next_path_position()

		var dir = entity.global_position.direction_to(next_position)

		movement_component.set_move_dir(dir)