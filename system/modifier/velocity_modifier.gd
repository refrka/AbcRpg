class_name VelocityModifier extends Modifier





func _is_expired() -> bool:

	if decay_rate == 0.0:

		if _time_alive >= duration:

			return true

	return value.length_squared() < 1.0





static func new_impulse(velocity: Vector2, decay: float) -> VelocityModifier:

	var modifier = VelocityModifier.new()

	modifier.value = velocity

	modifier.decay_rate = decay

	return modifier





