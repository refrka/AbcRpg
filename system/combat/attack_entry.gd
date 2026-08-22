class_name AttackEntry extends Resource




@export var can_move:= false

@export var damage_range:= Vector2(1.0, 1.0)

@export var lunge_force:= 0.0

@export var movement_penalty:= 0.0


@export var can_hold_charge:= false

@export var can_aim_charge:= false

@export var has_charge:= false



func get_damage_roll() -> float:

	return randf_range(damage_range.x, damage_range.y)