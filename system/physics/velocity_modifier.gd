class_name VelocityModifierOld extends RefCounted


enum ModifierType {

	MULTIPLIER,

	CUMULATIVE,

	OVERRIDE,

}

var modifier_type: ModifierType

var multiplier:= 0.0

var velocity:= Vector2.ZERO



var duration:= -1.0

var decay_rate:= 0.0



var _time_alive:= 0.0




func tick(delta: float) -> void:

	_time_alive += delta

	if decay_rate > 0.0:

		velocity *= clampf(1.0 - decay_rate * delta, 0.0, 1.0)




func is_expired() -> bool:

	if duration >= 0.0 and _time_alive >= duration:

		return true

	if modifier_type == ModifierType.CUMULATIVE and decay_rate > 0.0:

		return velocity.length_squared() < 1.0

	return false



static func new_impulse(vel: Vector2, decay: float) -> VelocityModifierOld:

	var modifier = VelocityModifierOld.new()

	modifier.modifier_type = ModifierType.CUMULATIVE

	modifier.velocity = vel

	modifier.decay_rate = decay

	return modifier



static func new_buff(mult: float, dur: float) -> VelocityModifierOld:

	var modifier = VelocityModifierOld.new()

	modifier.modifier_type = ModifierType.MULTIPLIER

	modifier.multiplier = mult

	modifier.duration = dur

	return modifier



static func new_override(vel: Vector2) -> VelocityModifierOld:

	var modifier = VelocityModifierOld.new()

	modifier.modifier_type = ModifierType.OVERRIDE

	modifier.velocity = vel

	return modifier