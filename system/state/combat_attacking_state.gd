class_name CombatAttackingState extends CombatState


var attack_entry: AttackEntry


func _enter() -> void:

	super()

	movement_component.set_face_dir(combat_component.current_attack_dir)

	animation_component.set_body_dir(combat_component.current_attack_dir, movement_component.is_moving())

	attack_entry = combat_component.get_attack_entry()

	if !attack_entry.can_move:

		movement_component.can_move = false

	animation_component.combat_anim_player.play(combat_component.current_attack_animation_name)




func _exit() -> void:

	super()

	movement_component.can_move = true

	if movement_component.is_moving():

		animation_component.set_body_dir(movement_component.move_dir, true)
