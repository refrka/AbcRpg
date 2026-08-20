class_name InputOverlay extends UIElement


signal hover_state_changed(state: bool)

signal input_received(event: InputEvent)




@export var linked_panel: PanelContainer

@export var hover_enabled:= true

@export var input_enabled:= true



var hovered:= false






func _deactivate() -> bool:

	if !super(): return false

	_set_hover_state(false)

	return true







func _connect_signals() -> void:

	if active: return

	mouse_entered.connect(_on_mouse_entered)

	mouse_exited.connect(_on_mouse_exited)

	gui_input.connect(_on_gui_input)






func _disconnect_signals() -> void:

	if !active: return

	mouse_entered.disconnect(_on_mouse_entered)

	mouse_exited.disconnect(_on_mouse_exited)

	gui_input.disconnect(_on_gui_input)






func set_hover_enabled(state: bool) -> void:

	hover_enabled = state

	if !hover_enabled and hovered:

		_set_hover_state(false)




func set_input_enabled(state: bool) -> void:

	input_enabled = state

	if !input_enabled and selected:

		_set_selected_state(false)





func _set_hover_state(state: bool) -> void:

	if selected: return

	hovered = state

	_update_visuals()

	hover_state_changed.emit(state)







func _update_visuals() -> void:

	if !active and inactive_stylebox:

		linked_panel.add_theme_stylebox_override("panel", inactive_stylebox)

	else:

		if selected and selected_stylebox:

			linked_panel.add_theme_stylebox_override("panel", selected_stylebox)

		elif hovered and hovered_stylebox:

			linked_panel.add_theme_stylebox_override("panel", hovered_stylebox)

		elif default_stylebox:

			linked_panel.add_theme_stylebox_override("panel", default_stylebox)

		else:

			linked_panel.remove_theme_stylebox_override("panel")





func _on_mouse_entered() -> void:

	if !hover_enabled: return
	
	_set_hover_state(true)



func _on_mouse_exited() -> void:

	if !hover_enabled and !hovered:

		return

	_set_hover_state(false)




func _on_gui_input(event: InputEvent) -> void:

	if !input_enabled: return

	input_received.emit(event)