class_name Modifier extends RefCounted


signal expired


enum ModifierType {

	MULTIPLIER,

	CUMULATIVE,
	
}

var modifier_type: ModifierType

var duration:= 0.0

var decay_rate:= 0.0

var value: Variant

var _time_alive:= 0.0








func _is_expired() -> bool:

	if duration != -1.0 and _time_alive >= duration:

		return true

	if value is Vector2:

		return value.length_squared() <= 1.0

	elif value is float:

		return value <= 0.001

	return true




func tick(delta: float) -> void:

	_time_alive += delta

	if decay_rate > 0.0:

		value *= clampf(1.0 - decay_rate * delta, 0.0, 1.0)

	if _is_expired():

		expired.emit()

