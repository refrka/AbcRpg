@abstract class_name Command extends Resource



var data: Dictionary



func execute(_data:= {}) -> bool:

	data = _data

	return true






static func run(_data:= {}) -> bool:

	return true