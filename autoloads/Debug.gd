extends Node



enum DebugState {

	DISABLED,

	ENABLED,

	PASSIVE,

}


var debug_state: DebugState

var debug_root: Control








func _ready() -> void:

	debug_root = get_tree().get_first_node_in_group("debug_root")

	debug_root.hide()








func set_state(new_state: DebugState) -> void:

	debug_state = new_state

	match debug_state:

		DebugState.DISABLED:

			debug_root.hide()

		DebugState.ENABLED:

			debug_root.show()

		DebugState.PASSIVE:

			debug_root.show()










func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("debug"):

		match debug_state:

			DebugState.ENABLED, DebugState.PASSIVE:

				set_state(DebugState.DISABLED)

			DebugState.DISABLED:

				set_state(DebugState.ENABLED)

	if event.is_action_pressed("debug_passive"):

		match debug_state:

			DebugState.DISABLED, DebugState.ENABLED	:

				set_state(DebugState.PASSIVE)

			DebugState.PASSIVE:

				set_state(DebugState.ENABLED)