class_name CombatAttackingState extends CombatState


var attack_entry: AttackEntry


func _enter() -> void:

	super()

	animation_component.set_body_dir(combat_component.current_attack_dir, false)

	attack_entry = combat_component.get_attack_entry()

	if !attack_entry.can_move:

		movement_component.can_move = false

	animation_component.combat_anim_player.play(combat_component.current_attack_animation_name)




func _exit() -> void:

	super()

	movement_component.can_move = true

	animation_component.set_body_dir(movement_component.move_dir, movement_component.is_moving())
