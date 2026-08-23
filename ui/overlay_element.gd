class_name OverlayElement extends UIElement




@export var pause_game:= false












func _activate() -> bool:

	if !super(): return false

	if pause_game:

		Game.pause()

	return true



func _deactivate() -> bool:

	if !super(): return false

	if pause_game:

		Game.unpause()

	return true




func sleep() -> void:

	active = false

	_disconnect_signals()



func wake() -> void:

	active = true

	_connect_signals()