class_name NavigateToPositionCommand extends Command


var entity_node: EntityNode

var target_position: Vector2



func _execute(_data:= {}) -> bool:

	super(_data)

	entity_node = data["entity_node"]

	target_position = data["target_position"]

	var navigation_component = entity_node.get_component(NavigationComponent)

	navigation_component.navigation_completed.connect(_on_navigation_completed)

	navigation_component.set_target_position(target_position)

	return true





static func run(_data:= {}) -> Command:

	var command = NavigateToPositionCommand.new()

	command._execute(_data)

	return command



func _on_navigation_completed() -> void:

	command_executed.emit()


