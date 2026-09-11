class_name InputComponent extends Component


signal break_free_pressed


var input_dir: Vector2


var movement_component: MovementComponent




func initialize(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)








func _unhandled_input(event: InputEvent) -> void:

	if !active:

		return

	if event.is_action_pressed("break_free"):

		break_free_pressed.emit()







func _physics_process(_delta: float) -> void:

	if !active:

		return

	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	movement_component.set_move_dir(input_dir)