class_name CombatComponent extends Component









func _handle_attack_input(pressed: bool) -> void:

	pass

























func _connect_signals() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.attack_input_pressed.connect(_on_attack_input_pressed)

		input_component.attack_input_released.connect(_on_attack_input_released)







func _disconnect_signals() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.attack_input_pressed.disconnect(_on_attack_input_pressed)

		input_component.attack_input_released.disconnect(_on_attack_input_released)







func _on_attack_input_pressed() -> void:

	_handle_attack_input(true)



func _on_attack_input_released() -> void:

	_handle_attack_input(false)