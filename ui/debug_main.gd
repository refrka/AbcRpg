class_name DebugMain extends UIElement



@export var input_overlay: InputOverlay

@onready var input_overlay_state_label:= %InputOverlayStateLabel

@onready var hover_state_label:= %HoverStateLabel

@onready var selected_state_label:= %SelectedStateLabel

@onready var activated_check_box:= %ActivatedCheckBox



func _ready() -> void:

	input_overlay.active_state_changed.connect(_on_input_overlay_active_state_changed)

	input_overlay.hover_state_changed.connect(_on_input_overlay_hover_state_changed)

	input_overlay.selected_state_changed.connect(_on_input_overlay_selected_state_changed)

	input_overlay.input_received.connect(_on_input_overlay_input_received)

	activated_check_box.toggled.connect(_on_activated_check_box_toggled)

	input_overlay._initialize()













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