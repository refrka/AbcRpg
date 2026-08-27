class_name Modifier extends RefCounted


signal expired


enum ModifierType {

	TIMED,

	IMPULSE,
	
}

var modifier_type: ModifierType

var duration:= 0.0

var decay_rate:= 0.0

var value: Variant

var _time_alive:= 0.0








func _is_expired() -> bool:

	match modifier_type:
		
		ModifierType.TIMED:

			if duration != -1.0 and _time_alive >= duration:

				return true

		ModifierType.IMPULSE:

			if value is Vector2:

				return value.length_squared() <= 1.0

			elif value is float:

				return value <= 0.001

	return false




func tick(delta: float) -> void:

	_time_alive += delta

	if decay_rate > 0.0:

		value *= clampf(1.0 - decay_rate * delta, 0.0, 1.0)

	if _is_expired():

		expired.emit()

