class_name Effect extends Resource

@warning_ignore_start("unused_signal")

signal expired


enum EffectType {

	INSTANT,

	PASSIVE,

	TICK,

}


@export var effect_type: EffectType

@export var effect_id: StringName

@export var display_name: String




func _apply_effect(_target_entity: EntityNode) -> void:

	pass



func _stop() -> void:

	pass


func _expire() -> void:

	_stop()

	expired.emit()