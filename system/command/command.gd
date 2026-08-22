class_name Command extends Resource


@warning_ignore("unused_signal")

signal command_executed


var data: Dictionary




func _execute(_data:= {}) -> bool:

	data = _data

	return true



static func run(_data:= {}) -> Command:

	return null