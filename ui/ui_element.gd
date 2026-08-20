class_name UIElement extends Control


signal active_state_changed(state: bool)





@export var element_group_name: String

@export var active:= false

@export var initialized:= false





func _initialize() -> bool:

	if initialized: return false

	initialized = true

	_update_visuals()

	if element_group_name != "":

		add_to_group(element_group_name)

	return true





func get_element_group() -> Array[UIElement]:

	if element_group_name == "": return []

	var group: Array[UIElement] = []

	group.assign(get_tree().get_nodes_in_group(element_group_name))

	return group



	
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

	active_state_changed.emit(false)

	return true








func _connect_signals() -> void:

	pass



func _disconnect_signals() -> void:

	pass







func _update_visuals() -> void:

	pass