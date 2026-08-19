class_name InputComponent extends Component


signal input_dir_updated(dir: Vector2)




var input_dir: Vector2










func _process(_delta: float) -> void:

	if !active:

		return

	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if input_dir != dir:

		input_dir = dir

		input_dir_updated.emit(dir)
