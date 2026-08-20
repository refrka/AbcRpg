class_name CombatComponent extends Component






var animation_component: AnimationComponent






var current_attack_index:= 0









func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity): return false

	return true





func _handle_attack_input(pressed: bool) -> void:

	if pressed:

		pass


















func _enter_combat() -> void:

	entity.state_machine.request_state(CombatReadyState)





func _exit_combat() -> void:

	entity.state_machine.request_state(IdleState)















func is_in_combat() -> bool:

	return not entity.state_machine.get_combat_state() is CombatIdleState



func is_attacking() -> bool:

	return entity.state_machine.get_combat_state() is CombatAttackingState








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