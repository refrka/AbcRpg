class_name BodyDodgingState extends BodyState






func _enter() -> void:

	var dir = movement_component.move_dir

	if dir == Vector2.ZERO:

		dir = movement_component.face_dir

	movement_component.set_move_dir(dir)

	var dodge_impulse = VelocityModifier.new_impulse(dir * 250.0, 22.0)

	movement_component.add_modifier(dodge_impulse)

	movement_component.movement_locked = true

	entity.body_sprite.animation_finished.connect(_on_body_sprite_animation_finished)

	entity.body_collision.disabled = true

	animation_component.set_dodge_dir(dir)






func _exit() -> void:

	movement_component.movement_locked = false

	movement_component.halt()

	movement_component.update_dir()

	entity.body_collision.disabled = false

	entity.body_sprite.animation_finished.disconnect(_on_body_sprite_animation_finished)






func _on_body_sprite_animation_finished() -> void:

	transition_to(BodyIdleState)