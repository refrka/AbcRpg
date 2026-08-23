class_name Condition extends Resource


var data: Dictionary



func _evaluate(_data:= {}) -> bool:

	data = _data

	return true





static func run(_data:= {}) -> bool:

	return true