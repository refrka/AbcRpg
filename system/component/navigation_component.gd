class_name NavigationComponent extends Component



@export var nav_agent: NavigationAgent2D



var movement_component: MovementComponent



var target_position: Vector2





func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity): return false

	movement_component = entity.get_component(MovementComponent)

	return true







func set_target_position(position: Vector2) -> void:

	target_position = position

	nav_agent.target_position = position







func _physics_process(delta: float) -> void:

	if !active: return

	if !nav_agent.is_navigation_finished():

		pass

