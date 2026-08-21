class_name CombatDodgeState extends CombatState





func _enter() -> void:

	super()

	entity.body_sprite.animation_finished.connect(_on_body_sprite_animation_finished)

	entity.body_hurtbox._deactivate()

	transition_to(DodgeState)



func _exit() -> void:

	super()

	entity.body_sprite.animation_finished.disconnect(_on_body_sprite_animation_finished)

	animation_component.set_body_dir(movement_component.move_dir, movement_component.is_moving())

	entity.body_hurtbox._activate()






func _on_body_sprite_animation_finished() -> void:

	if combat_component.attack_stored:

		combat_component._try_attack()

	else:

		transition_to(CombatReadyState)