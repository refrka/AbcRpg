class_name Modifier extends RefCounted





var duration:= 0.0

var decay_rate:= 0.0

var value: Variant

var _time_alive:= 0.0








func _is_expired() -> bool:

	return true




func tick(delta: float) -> void:

	_time_alive += delta

	if decay_rate > 0.0:

		value *= clampf(1.0 - decay_rate * delta, 0.0, 1.0)

