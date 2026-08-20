class_name InputUIElement extends UIElementRedo


signal hover_state_changed(state: bool)

signal input_received(event: InputEvent)





@export var hover_enabled:= true

@export var input_enabled:= true

@export var linked_panel: PanelContainer


@export var default_stylebox: StyleBoxFlat

@export var hovered_stylebox: StyleBoxFlat



var hovered:= false









func _set_hover_state(state: bool) -> void:

	hovered = state

	_update_visuals()

	hover_state_changed.emit(state)









func _connect_signals() -> void:

	mouse_entered.connect(_on_mouse_entered)

	mouse_exited.connect(_on_mouse_exited)

	gui_input.connect(_on_gui_input)






func _disconnect_signals() -> void:

	mouse_entered.disconnect(_on_mouse_entered)

	mouse_exited.disconnect(_on_mouse_exited)

	gui_input.disconnect(_on_gui_input)





func _handle_input_event(event: InputEvent) -> bool:

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:

		input_received.emit(event)

		return true

	return false




func _update_visuals() -> void:

	if linked_panel:

		var new_stylebox = default_stylebox if !hovered else hovered_stylebox

		if new_stylebox:

			linked_panel.add_theme_stylebox_override("panel", new_stylebox)





func _on_mouse_entered() -> void:

	if !hover_enabled: return
	
	_set_hover_state(true)



func _on_mouse_exited() -> void:

	if !hover_enabled and !hovered:

		return

	_set_hover_state(false)




func _on_gui_input(event: InputEvent) -> void:

	if !input_enabled: return

	_handle_input_event(event)