class_name MovementComponent extends Component



signal move_dir_updated(dir: Vector2)

signal face_dir_updated(dir: Vector2)

signal move_started

signal move_ended



var animation_component: AnimationComponent



var can_move:= true

var movement_locked:= false


var move_dir: Vector2

var face_dir:= Vector2.RIGHT

var current_move_velocity: Vector2

var velocity_override: VelocityModifier

var modifiers: Array[VelocityModifier]





func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity):

		return false

	animation_component = entity.get_component(AnimationComponent)

	return true




func halt() -> void:

	move_dir = Vector2.ZERO

	entity.velocity = Vector2.ZERO




func add_modifier(modifier: VelocityModifier) -> void:

	if modifier.modifier_type == VelocityModifier.ModifierType.OVERRIDE:

		velocity_override = modifier

	else:

		modifiers.append(modifier)



func remove_modifier(modifier: VelocityModifier) -> void:

	if modifiers.has(modifier):

		modifiers.erase(modifier)
	


func update_dir() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component:

		move_dir = input_component.input_dir
















func set_move_dir(dir: Vector2) -> void:

	if dir == move_dir: return

	if movement_locked: return

	move_dir = dir

	move_dir_updated.emit(dir)




func set_face_dir(dir: Vector2) -> void:

	if dir == face_dir or dir == Vector2.ZERO: 
		
		return

	face_dir = dir

	face_dir_updated.emit(dir)



func get_move_speed() -> float:

	var speed = entity.entity_def.move_speed

	for modifier in modifiers:

		if modifier.multiplier != 0.0:

			speed *= modifier.multiplier

	return speed
















func is_moving() -> bool:

	if !can_move:

		return false

	return move_dir != Vector2.ZERO










func _get_impulse_velocity() -> Vector2:

	var total = Vector2.ZERO

	for modifier in modifiers:

		if modifier.modifier_type == VelocityModifier.ModifierType.CUMULATIVE:

			total += modifier.velocity

	return total






func _tick_modifiers(delta: float) -> void:

	for i in range(modifiers.size() - 1, -1, -1):

		modifiers[i].tick(delta)

		if modifiers[i].is_expired():

			modifiers.remove_at(i)




func _connect_signals() -> void:
	
	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.input_dir_updated.connect(_on_input_dir_updated)




func _disconnect_signals() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component and input_component.input_dir_updated.is_connected(_on_input_dir_updated):

		input_component.input_dir_updated.disconnect(_on_input_dir_updated)



func _on_input_dir_updated(dir: Vector2) -> void:

	set_move_dir(dir)




func _physics_process(delta: float) -> void:

	if !active:

		return

	_tick_modifiers(delta)

	var move_velocity:= current_move_velocity

	if !can_move:

		return

	if move_dir == Vector2.ZERO:

		move_velocity = current_move_velocity.move_toward(Vector2.ZERO, 1800.0 * delta)

	else:

		move_velocity = current_move_velocity.move_toward(move_dir * get_move_speed(), 2800.0 * delta)

	if velocity_override:

		move_velocity = velocity_override.velocity

	entity.velocity = move_velocity + _get_impulse_velocity()

	entity.move_and_slide()

	if move_velocity != Vector2.ZERO and current_move_velocity == Vector2.ZERO:

		move_started.emit()

	if move_velocity == Vector2.ZERO and current_move_velocity != Vector2.ZERO:

		move_ended.emit()

	current_move_velocity = entity.velocity