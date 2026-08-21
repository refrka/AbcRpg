class_name CombatComponent extends Component






@export var combat_origin: Node2D



var current_attack_config: AttackConfig

var current_attack_index:= 0

var current_attack_dir:= Vector2.ZERO

var current_library_name: String

var current_attack_animation_name: String




var buffer_enabled:= false

var buffered:= false








func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity): return false

	var weapon_slot = entity.inventory.weapon_slot

	if !weapon_slot.is_empty():

		_load_weapon_config(weapon_slot.item_data.item_def)

	return true






func _handle_attack_input(pressed: bool) -> void:

	if pressed:

		if !is_attacking():

			_try_attack()

		else:

			if buffer_enabled:

				_try_buffer()




func _handle_dodge() -> void:

	if is_attacking():

		buffered = false

		var animation_component = entity.get_component(AnimationComponent)

		animation_component.combat_anim_player.play("RESET")

	entity.state_machine.request_state(CombatDodgeState)






func _try_attack() -> void:

	if !_is_attack_index_valid(current_attack_index): return

	if entity.state_machine.get_body_state() is DodgeState:

		return

	_execute_attack()




func _try_buffer() -> void:

	var buffered_index = current_attack_index + 1

	if _is_attack_index_valid(buffered_index):

		buffered = true








func _execute_attack() -> void:

	_set_attack_dir(Game.get_mouse_direction())

	current_attack_animation_name = get_attack_animation_name()

	entity.state_machine.request_state(CombatAttackingState)




func _finish_attack() -> void:

	buffer_enabled = false

	if buffered:

		buffered = false

		current_attack_index += 1

		_execute_attack()

		return

	current_attack_index = 0

	entity.state_machine.request_state(CombatReadyState)





func _enter_combat() -> void:

	entity.state_machine.request_state(CombatReadyState)





func _exit_combat() -> void:

	entity.state_machine.request_state(CombatIdleState)









func _enable_buffer() -> void:

	buffer_enabled = true




func _set_attack_dir(dir: Vector2) -> void:

	current_attack_dir = dir

	combat_origin.rotation = dir.angle()





func _load_weapon_config(weapon_def: WeaponDef) -> void:

	current_attack_config = weapon_def.default_attack_config

	current_library_name = weapon_def.item_id











func get_attack_entry(index:= -1) -> AttackEntry:

	if index == -1:

		index = current_attack_index

	return current_attack_config.get_attack_entry(index)



func get_attack_animation_name() -> String:

	return "%s/attack_%s" % [current_library_name, current_attack_index]






func is_in_combat() -> bool:

	return not entity.state_machine.get_combat_state() is CombatIdleState



func is_attacking() -> bool:

	return entity.state_machine.get_combat_state() is CombatAttackingState




func _is_attack_index_valid(index: int) -> bool:

	if !current_attack_config: return false

	return current_attack_config.attack_set.size() - 1 >= index







func _connect_signals() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.attack_input_pressed.connect(_on_attack_input_pressed)

		input_component.attack_input_released.connect(_on_attack_input_released)

		input_component.dodge_pressed.connect(_on_dodge_pressed)

	var animation_component = entity.get_component(AnimationComponent)

	animation_component.combat_anim_player.animation_finished.connect(_on_combat_animation_finished)







func _disconnect_signals() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.attack_input_pressed.disconnect(_on_attack_input_pressed)

		input_component.attack_input_released.disconnect(_on_attack_input_released)

		input_component.dodge_pressed.disconnect(_on_dodge_pressed)

	var animation_component = entity.get_component(AnimationComponent)

	animation_component.combat_anim_player.animation_finished.disconnect(_on_combat_animation_finished)







func _on_attack_input_pressed() -> void:

	_handle_attack_input(true)



func _on_attack_input_released() -> void:

	_handle_attack_input(false)



func _on_combat_animation_finished(anim_name: StringName) -> void:

	if anim_name == current_attack_animation_name:

		_finish_attack()



func _on_dodge_pressed() -> void:

	_handle_dodge()