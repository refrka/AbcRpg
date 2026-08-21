class_name CombatDodgeState extends CombatState





func _enter() -> void:

	entity.body_sprite.animation_finished.connect(_on_body_sprite_animation_finished)

	transition_to(DodgeState)



func _exit() -> void:

	entity.body_sprite.animation_finished.disconnect(_on_body_sprite_animation_finished)






func _on_body_sprite_animation_finished() -> void:

	transition_to(CombatReadyState)