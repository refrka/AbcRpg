class_name CommandSet extends Resource


@export var commands: Array[Command]






func _execute_all(_data:= {}) -> void:

	for command in commands:

		command._execute(_data)