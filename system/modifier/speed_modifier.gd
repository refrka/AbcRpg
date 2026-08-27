class_name SpeedModifier extends Modifier









static func new_multiplier(_value: float, _duration: float) -> SpeedModifier:

	var modifier = SpeedModifier.new()

	modifier.value = _value

	modifier.modifier_type = ModifierType.TIMED

	modifier.duration = _duration

	return modifier