class_name CombatGrappledState extends CombatRestrainedState







signal broke_free

var break_free_counter:= 0.0





func _enter() -> void:

	super()

	break_free_counter = 0.0





func _connect_signals() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.break_free_pressed.connect(_on_break_free_pressed)





func _disconnect_signals() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.break_free_pressed.disconnect(_on_break_free_pressed)





func _on_break_free_pressed() -> void:

	break_free_counter += 0.38

	if break_free_counter > 1.0:

		broke_free.emit()








func _tick(delta: float) -> void:

	if !active:

		return

	if break_free_counter >= 0.0:

		break_free_counter -= delta

