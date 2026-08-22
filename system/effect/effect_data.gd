class_name EffectData extends RefCounted


signal effect_expired


var entity: EntityNode

var active:= false

var effect: Effect

var time_alive:= 0.0







func _start() -> void:

	active = true

	effect._apply_effect(entity)




func _stop() -> void:

	active = false




func _expire() -> void:

	effect_expired.emit()




func _tick(delta: float) -> void:

	if !active: return

	time_alive += delta

	if effect is TickEffect and effect.effect_type == Effect.EffectType.TICK:

		effect._do_tick(entity)




func _on_effect_expired() -> void:

	effect_expired.emit()





static func new_effect(_effect: Effect, _entity: EntityNode) -> EffectData:

	var effect_data = EffectData.new()

	_effect.expired.connect(effect_data._on_effect_expired)

	effect_data.effect = _effect

	return effect_data