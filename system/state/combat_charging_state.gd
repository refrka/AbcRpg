class_name CombatChargingState extends CombatState



var charge_animation_name: StringName

var current_attack_entry: AttackEntry

var movement_modifier: VelocityModifierOld




func _enter() -> void:

	super()

	combat_component.set_attack_dir(combat_component.get_attack_dir())

	animation_component.set_body_dir(combat_component.current_attack_dir, movement_component.is_moving())

	movement_component.set_face_dir(combat_component.current_attack_dir)

	current_attack_entry = combat_component.get_attack_entry()

	if current_attack_entry.movement_penalty > 0.0:

		movement_modifier = VelocityModifierOld.new_buff(1.0 - current_attack_entry.movement_penalty, -1.0)

		movement_component.add_modifier(movement_modifier)

	charge_animation_name = combat_component.get_charge_animation_name()

	animation_component.combat_anim_player.play(charge_animation_name)

	animation_component.combat_anim_player.animation_finished.connect(_on_combat_animation_finished)







func _exit() -> void:

	super()

	if movement_modifier:

		movement_component.remove_modifier(movement_modifier)

	animation_component.combat_anim_player.animation_finished.disconnect(_on_combat_animation_finished)

	animation_component.set_body_dir(movement_component.face_dir, movement_component.is_moving())





func _on_combat_animation_finished(anim_name: StringName) -> void:

	if anim_name == charge_animation_name:

		if current_attack_entry.can_hold_charge:

			combat_component.charge_complete = true

		else:

			combat_component._complete_charge()





func _tick(_delta: float) -> void:

	if current_attack_entry.can_aim_charge:

		var dir = Game.get_mouse_direction(combat_component.combat_origin)

		combat_component.set_attack_dir(dir)

		animation_component.set_body_dir(dir, movement_component.is_moving())

		movement_component.set_face_dir(dir)