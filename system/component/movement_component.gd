class_name MovementComponent extends Component



signal move_dir_updated(dir: Vector2)

signal face_dir_updated(dir: Vector2)




var move_dir: Vector2

var face_dir: Vector2

var current_move_velocity: Vector2



var modifiers: Array[VelocityModifier]





func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity):

		return false

	return true




func _connect_signals() -> void:
	
	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.input_dir_updated.connect(_on_input_dir_updated)




func _disconnect_signals() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component and input_component.input_dir_updated.is_connected(_on_input_dir_updated):

		input_component.input_dir_updated.disconnect(_on_input_dir_updated)




func set_move_dir(dir: Vector2) -> void:

	if dir == move_dir: return

	move_dir = dir

	move_dir_updated.emit(dir)




func set_face_dir(dir: Vector2) -> void:

	if dir == face_dir or dir == Vector2.ZERO: return

	face_dir = dir

	face_dir_updated.emit(dir)







func _on_input_dir_updated(dir: Vector2) -> void:

	set_move_dir(dir)




func _physics_process(delta: float) -> void:

	if !active:

		return

	var move_velocity:= current_move_velocity

	if move_dir == Vector2.ZERO:

		move_velocity = current_move_velocity.move_toward(Vector2.ZERO, 1400.0 * delta)

	else:

		move_velocity = current_move_velocity.move_toward(move_dir * 350.0, 2400.0 * delta)

	entity.velocity = move_velocity

	entity.move_and_slide()

	current_move_velocity = entity.velocity