class_name SelectableUIElement extends InputUIElement


signal selected_state_changed(state: bool)




@export var select_enabled:= true

@export var allow_deselect:= true

@export var selected_stylebox: StyleBoxFlat

var selected:= false










func select() -> void:

	selected = true

	_update_visuals()

	selected_state_changed.emit(true)



func deselect() -> void:

	selected = false

	_update_visuals()

	selected_state_changed.emit(false)





func _deactivate() -> bool:

	if !super(): return false

	if selected:

		deselect()

	return true






func _handle_input_event(event: InputEvent) -> bool:

	if !super(event) or !select_enabled: return false

	if selected and allow_deselect:

		deselect()

		return true

	var element_group = get_element_group()

	if !element_group.is_empty():

		for element in element_group:

			if element is SelectableUIElement and element.selected:

				element.deselect()

	select()

	return true




func _update_visuals() -> void:

	if linked_panel:

		var new_stylebox = default_stylebox if !selected else selected_stylebox

		if new_stylebox:

			linked_panel.add_theme_stylebox_override("panel", new_stylebox)

	if !selected:

		super()