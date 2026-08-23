class_name BodyFlinchState extends BodyBusyState




func _enter() -> void:

	super()

	entity.body_hurtbox._deactivate.call_deferred()

	if animation_component.combat_anim_player.is_playing():

		animation_component.combat_anim_player.stop()

	animation_component.combat_anim_player.animation_finished.connect(_on_animation_finished)

	animation_component.combat_anim_player.play("flinch")






func _exit() -> void:

	super()

	entity.body_hurtbox._activate()

	animation_component.combat_anim_player.animation_finished.disconnect(_on_animation_finished)

	animation_component.combat_anim_player.play("RESET")






func _on_animation_finished(_anim_name: StringName) -> void:

	transition_to(CombatReadyState)

	transition_to(BodyIdleState)