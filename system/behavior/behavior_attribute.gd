class_name BehaviorAttribute extends Resource


enum Attribute {

	ATTITUDE,

	TEMPERAMENT,

	FEAR,

	AFFECTION,

	RESPECT

}


@export var attribute: Attribute

@export var baseline_value:= 0.0



var modifiers: Array[AttributeModifier]





func get_final_value() -> float:

	return (baseline_value + _get_modifier_cumulative()) * _get_modifier_multiplier()



func _get_modifier_cumulative() -> float:

	var value = 0.0
	
	for modifier in modifiers:

		if modifier.modifier_type == Modifier.ModifierType.CUMULATIVE:

			value += modifier.value

	return value



func _get_modifier_multiplier() -> float:

	var value = 1.0

	for modifier in modifiers:

		if modifier.modifier_type == Modifier.ModifierType.MULTIPLIER:

			value *= modifier.value

	return value