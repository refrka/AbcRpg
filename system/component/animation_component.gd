class_name AnimationComponent extends Component


signal animation_finished(anim_name: StringName)


@export var anim_player: AnimationPlayer







func _connect_signals() -> void:

	anim_player.animation_finished.connect(_on_animation_finished)




func _disconnect_signals() -> void:

	anim_player.animation_finished.disconnect(_on_animation_finished)




func _on_animation_finished(anim_name: String) -> void:

	animation_finished.emit(anim_name)