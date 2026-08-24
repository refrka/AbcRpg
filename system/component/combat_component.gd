class_name CombatComponent extends Component






@export var combat_origin: Node2D



var current_attack_config: AttackConfig

var current_attack_index:= 0

var current_attack_dir:= Vector2.ZERO

var current_library_name: String

var current_attack_animation_name: String

var current_target: EntityNode




var buffer_enabled:= false

var buffered:= false

var charge_complete:= false

var attack_stored:= false












func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity): return false

	if entity.inventory:

		var weapon_data = entity.inventory.weapon_data

		if !weapon_data.is_empty():

			_load_weapon_config(weapon_data.item_def)

	return true






func _handle_attack_input(pressed: bool) -> void:

	if pressed:

		if !is_attacking() and !is_flinching():

			_try_attack()

		else:

			if buffer_enabled:

				_try_buffer()

	else:

		attack_stored = false

		if is_charging():

			if charge_complete:

				_complete_charge()

			else:

				_cancel_charge()




func _handle_dodge() -> void:

	if is_dodging() or is_busy(): return

	if is_attacking():

		buffered = false

		_finish_attack()

	entity.state_machine.request_state(CombatDodgeState)






func _try_attack() -> void:

	if !_is_attack_index_valid(current_attack_index): return

	if entity.state_machine.get_body_state() is BodyBusyState:

		return

	if !attack_stored:

		if entity.state_machine.get_body_state() is BodyDodgingState:

			attack_stored = true

			return

	attack_stored = false

	var attack_entry = get_attack_entry()

	if attack_entry.has_charge:

		_start_charge()

	else:

		set_attack_dir(get_attack_dir())

		_execute_attack()




func _try_buffer() -> void:

	var buffered_index = current_attack_index + 1

	if _is_attack_index_valid(buffered_index):

		buffered = true








func _execute_attack() -> void:

	current_attack_animation_name = get_attack_animation_name()

	entity.state_machine.request_state(CombatAttackingState)




func _finish_attack() -> void:

	entity.combat_hitbox.clear_hit_list()

	buffer_enabled = false

	if buffered:

		buffered = false

		current_attack_index += 1

		_execute_attack()

		return

	current_attack_index = 0
	
	current_attack_dir = Vector2.ZERO

	entity.state_machine.request_state(CombatReadyState)






func _start_charge() -> void:

	entity.state_machine.request_state(CombatChargingState)





func _cancel_charge() -> void:

	charge_complete = false

	var animation_component = entity.get_component(AnimationComponent)

	animation_component.combat_anim_player.play("RESET")

	entity.state_machine.request_state(CombatReadyState)





func _complete_charge() -> void:

	charge_complete = false

	_execute_attack()





func _enter_combat() -> void:

	entity.state_machine.request_state(CombatReadyState)





func _exit_combat() -> void:

	entity.state_machine.request_state(CombatIdleState)









func _enable_buffer() -> void:

	buffer_enabled = true



func _fire_projectile() -> void:

	var weapon_data = _get_weapon_data()

	var ammunition_data = weapon_data.ammunition_data

	if ammunition_data.is_empty():

		return

	var ammunition_def = weapon_data.ammunition_data.item_def

	var projectile_node = ProjectileNode.from_ammunition(ammunition_def)

	projectile_node.rotation = current_attack_dir.angle()	

	projectile_node.set_trajectory(current_attack_dir)

	projectile_node.global_position = combat_origin.global_position

	projectile_node.damage_package = _get_damage_package()

	projectile_node.set_projectile_owner(entity)

	entity.add_sibling(projectile_node)

	projectile_node._initialize()

	projectile_node._activate()

	weapon_data.ammunition_data.remove_amount(1)






func _get_weapon_data() -> EquipmentData:

	var weapon_data: EquipmentData = null

	if !entity.inventory.weapon_data.is_empty():

		weapon_data = entity.inventory.weapon_data

	return weapon_data




func _get_damage_package() -> DamagePackage:

	var attack_entry = get_attack_entry()
	
	var damage_package = DamagePackage.from_attack_entry(attack_entry, entity)

	return damage_package




func _load_weapon_config(weapon_def: WeaponDef) -> void:

	current_attack_config = weapon_def.default_attack_config

	current_library_name = weapon_def.item_id





func receive_damage_package(damage_package: DamagePackage) -> void:

	if damage_package.get_total_damage() > 0.0:

		entity.state_machine.request_state(CombatFlinchState)






func get_attack_dir() -> Vector2:

	if entity is Player:

		return Game.get_mouse_direction(combat_origin)

	return Vector2.ZERO




func get_attack_entry(index:= -1) -> AttackEntry:

	if index == -1:

		index = current_attack_index

	return current_attack_config.get_attack_entry(index)



func get_attack_animation_name() -> String:

	return "%s/attack_%s" % [current_library_name, current_attack_index]



func get_charge_animation_name() -> String:

	return "%s/charge_%s" % [current_library_name, current_attack_index]



func set_attack_dir(dir: Vector2) -> void:

	current_attack_dir = dir

	combat_origin.rotation = dir.angle()








func is_in_combat() -> bool:

	return not entity.state_machine.get_combat_state() is CombatIdleState



func is_attacking() -> bool:

	return entity.state_machine.get_combat_state() is CombatAttackingState



func is_charging() -> bool:

	return entity.state_machine.get_combat_state() is CombatChargingState


func is_dodging() -> bool:

	return entity.state_machine.get_combat_state() is CombatDodgeState


func is_busy() -> bool:

	return entity.state_machine.get_body_state() is BodyBusyState



func is_flinching() -> bool:

	var animation_component = entity.get_component(AnimationComponent)

	if animation_component.combat_anim_player.current_animation == "flinch":

		return true

	return entity.state_machine.get_combat_state() is CombatFlinchState




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

	entity.combat_hitbox.hit_detected.connect(_on_combat_hit_detected)







func _disconnect_signals() -> void:

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.attack_input_pressed.disconnect(_on_attack_input_pressed)

		input_component.attack_input_released.disconnect(_on_attack_input_released)

		input_component.dodge_pressed.disconnect(_on_dodge_pressed)

	var animation_component = entity.get_component(AnimationComponent)

	animation_component.combat_anim_player.animation_finished.disconnect(_on_combat_animation_finished)

	entity.combat_hitbox.hit_detected.disconnect(_on_combat_hit_detected)







func _on_attack_input_pressed() -> void:

	_handle_attack_input(true)



func _on_attack_input_released() -> void:

	_handle_attack_input(false)



func _on_combat_animation_finished(anim_name: StringName) -> void:

	if anim_name == current_attack_animation_name:

		_finish_attack()



func _on_dodge_pressed() -> void:

	_handle_dodge()



func _on_combat_hit_detected(hit_entity: EntityNode) -> void:

	var damage_package = _get_damage_package()

	hit_entity.receive_damage_package(damage_package)

