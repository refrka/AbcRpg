class_name DispositionAttribute extends RefCounted





var value:= 0.0





func _get_multiplier(remap_min: float, remap_max: float) -> float:

	return remap(value, -1.0, 1.0, remap_min, remap_max)