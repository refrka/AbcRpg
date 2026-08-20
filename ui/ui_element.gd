class_name UIElement extends Control


signal active_state_changed(state: bool)

signal selected_state_changed(state: bool)


@export var select_enabled:= false

@export var allow_deselect:= true

@export var element_group: String

@export var default_stylebox: StyleBoxFlat

@export var inactive_stylebox: StyleBoxFlat

@export var hovered_stylebox: StyleBoxFlat

@export var selected_stylebox: StyleBoxFlat



var active:= false

var selected:= false

var locked:= false

var initialized:= false



var element_groups: Array[UIElementGroup]






func _ready() -> void:

	add_to_group("ui_element")








func _initialize() -> bool:

	if initialized: return false

	initialized = true

	_update_visuals()

	return true





func select() -> void:

	if !active or !select_enabled or selected or locked:
		
		return

	_set_selected_state(true)




func deselect() -> void:

	if !active or !select_enabled or !selected:

		return

	_set_selected_state(false)





func get_element_group() -> Array[UIElement]:

	if element_group == "": return [] as Array[UIElement]

	var group: Array[UIElement] = []

	group.assign(get_tree().get_nodes_in_group(element_group))

	return group




func _connect_signals() -> void:

	pass



func _disconnect_signals() -> void:

	pass










func _activate() -> bool:

	if active: return false

	_connect_signals()

	active = true

	_update_visuals()

	active_state_changed.emit(true)

	return true




func _deactivate() -> bool:

	if !active: return false

	_disconnect_signals()

	active = false

	_update_visuals()

	_set_selected_state(false)

	active_state_changed.emit(false)

	return true






func _set_selected_state(state: bool) -> void:

	selected = state

	_update_visuals()

	selected_state_changed.emit(state)





func _update_visuals() -> void:

	pass