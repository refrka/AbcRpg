class_name InputComponent extends Component


signal input_dir_updated(dir: Vector2)

signal attack_input_pressed

signal attack_input_released





var input_dir: Vector2










func _unhandled_input(event: InputEvent) -> void:

	if !active: return

	if event.is_action_pressed("attack"):

		attack_input_pressed.emit()

	if event.is_action_released("attack"):

		attack_input_released.emit()








func _process(_delta: float) -> void:

	if !active:

		return

	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if input_dir != dir:

		input_dir = dir

		input_dir_updated.emit(dir)
