class_name AttackEntry extends Resource




@export var can_move:= false

@export var damage_range:= Vector2(1.0, 1.0)

@export var charge_duration:= 0.0

@export var lunge_factor:= 1.5




func get_damage_roll() -> float:

	return randf_range(damage_range.x, damage_range.y)