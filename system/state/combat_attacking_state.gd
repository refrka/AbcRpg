class_name CombatAttackingState extends CombatState


var attack_entry: AttackEntry


func _enter() -> void:

	attack_entry = combat_component.get_attack_entry()

	if !attack_entry.can_move:

		movement_component.can_move = false

	animation_component.combat_anim_player.play(combat_component.current_attack_animation_name)




func _exit() -> void:

	movement_component.can_move = true

	animation_component.set_body_dir(combat_component.current_attack_dir, false)
