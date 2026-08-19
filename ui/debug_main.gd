class_name DebugMain extends UIElement



@export var input_overlay: InputOverlay

@onready var activate_input_overlay_button:= %ActivateInputOverlayButton

@onready var deactivate_input_overlay_button:= %DeactivateInputOverlayButton

@onready var input_overlay_state_label:= %InputOverlayStateLabel

@onready var hover_state_label:= %HoverStateLabel



func _ready() -> void:

	activate_input_overlay_button.pressed.connect(_on_activate_input_overlay_pressed)

	deactivate_input_overlay_button.pressed.connect(_on_deactivate_input_overlay_pressed)

	input_overlay.active_state_changed.connect(_on_input_overlay_active_state_changed)

	input_overlay.hover_state_changed.connect(_on_input_overlay_hover_state_changed)

	input_overlay.input_received.connect(_on_input_overlay_input_received)

	input_overlay._initialize()












func _on_activate_input_overlay_pressed() -> void:

	input_overlay._activate()




func _on_deactivate_input_overlay_pressed() -> void:

	input_overlay._deactivate()



func _on_input_overlay_active_state_changed(state: bool) -> void:

	input_overlay_state_label.text = "%s" % state



func _on_input_overlay_hover_state_changed(state: bool) -> void:
	
	hover_state_label.text = "%s" % state



func _on_input_overlay_input_received(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:

		if input_overlay.selected and input_overlay.allow_deselect:

			input_overlay.deselect()

		else:

			input_overlay.select()