class_name DebugMain extends UIElement



@export var input_overlay: UIElement

@export var player_info_panel: UIElement

@export var input_overlay_state_label: Label

@export var hover_state_label: Label

@export var selected_state_label: Label

@export var activated_check_box: CheckBox



@export var idle_state_row: DebugPlayerStateRow

@export var moving_state_row: DebugPlayerStateRow



func _ready() -> void:

	Events.subscribe(PlayerActivatedEvent, _on_player_activated_event)

	Events.subscribe(PlayerDeactivatedEvent, _on_player_deactivated_event)

	activated_check_box.toggled.connect(_on_activated_check_box_toggled)

	input_overlay.active_state_changed.connect(_on_input_overlay_active_state_changed)

	input_overlay.hover_state_changed.connect(_on_input_overlay_hover_state_changed)

	input_overlay.selected_state_changed.connect(_on_input_overlay_selected_state_changed)

	input_overlay._initialize()

	input_overlay._deactivate()

	player_info_panel._initialize()

	player_info_panel._activate()








func _update_player_body_state() -> void:

	var player = Game.get_player()

	match player.state_machine.get_body_state().get_state_script():

		IdleState:

			idle_state_row.select()

			moving_state_row.deselect()

		MovingState:

			idle_state_row.deselect()

			moving_state_row.select()



func _update_player_combat_state() -> void:

	pass








func _on_input_overlay_active_state_changed(state: bool) -> void:

	input_overlay_state_label.text = "%s" % state



func _on_input_overlay_hover_state_changed(state: bool) -> void:
	
	hover_state_label.text = "%s" % state



func _on_input_overlay_selected_state_changed(state: bool) -> void:

	selected_state_label.text = "%s" % state




func _on_input_overlay_input_received(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:

		if input_overlay.selected and input_overlay.allow_deselect:

			input_overlay.deselect()

		else:

			input_overlay.select()



func _on_activated_check_box_toggled(state: bool) -> void:

	if state == true:

		input_overlay._activate()

	else:

		input_overlay._deactivate()




func _on_player_activated_event(_event: Event) -> void:

	var player = Game.get_player()

	player.state_machine.body_state_changed.connect(_on_player_body_state_changed)

	player.state_machine.combat_state_changed.connect(_on_player_combat_state_changed)

	_update_player_body_state()

	_update_player_combat_state()







func _on_player_deactivated_event(_event: Event) -> void:

	var player = Game.get_player()
	
	player.state_machine.body_state_changed.disconnect(_on_player_body_state_changed)

	player.state_machine.combat_state_changed.disconnect(_on_player_combat_state_changed)

	idle_state_row.deselect()

	moving_state_row.deselect()



func _on_player_body_state_changed(_new_state: State) -> void:

	_update_player_body_state()



func _on_player_combat_state_changed(_new_state: State) -> void:

	_update_player_combat_state()