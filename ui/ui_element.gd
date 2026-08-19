class_name UIElement extends Control





var active:= true








func _activate() -> void:

	active = true

	show()




func _deactivate() -> void:

	active = false

	hide()