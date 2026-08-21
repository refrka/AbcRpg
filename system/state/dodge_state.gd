class_name DodgeState extends BodyState






func _enter() -> void:

	movement_component.set_move_dir(movement_component.face_dir)

	movement_component.movement_locked = true

	entity.body_sprite.animation_finished.connect(_on_body_sprite_animation_finished)

	animation_component.set_dodge_dir(movement_component.face_dir)



func _exit() -> void:

	movement_component.movement_locked = false

	movement_component.halt()

	movement_component.update_dir()

	entity.body_sprite.animation_finished.disconnect(_on_body_sprite_animation_finished)






func _on_body_sprite_animation_finished() -> void:

	transition_to(IdleState)