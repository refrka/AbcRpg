class_name AttackEntry extends Resource





@export var damage_range:= Vector2(1.0, 1.0)





func get_damage() -> float:

	return randf_range(damage_range.x, damage_range.y)