class_name CombatAttackingState extends CombatState


var attack_entry: AttackEntry


func _enter() -> void:

	super()

	movement_component.set_face_dir(combat_component.current_attack_dir)

	animation_component.set_body_dir(combat_component.current_attack_dir, movement_component.is_moving())

	attack_entry = combat_component.get_attack_entry()

	if attack_entry.lunge_force > 0.0:

		var lunge_vector = combat_component.current_attack_dir * attack_entry.lunge_force

		var modifier = VelocityModifier.new_impulse(lunge_vector, 40.0)

		movement_component.add_modifier(modifier)

	animation_component.combat_anim_player.play(combat_component.current_attack_animation_name)




func _exit() -> void:

	super()

	animation_component.combat_anim_player.play("RESET")

	movement_component.can_move = true

	if movement_component.is_moving():

		animation_component.set_body_dir(movement_component.move_dir, true)
