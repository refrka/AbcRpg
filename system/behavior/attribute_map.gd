class_name AttributeMap extends Resource






@export var fear_curve: Curve

@export var affection_curve: Curve

@export var respect_curve: Curve

@export var attitude_curve: Curve

@export var temperament_curve: Curve




func get_disposition_value(disposition: Disposition) -> float:

	return fear_curve.sample(disposition.fear) \

		* affection_curve.sample(disposition.affection) \

		* respect_curve.sample(disposition.respect)



func get_attitude_value(attitude: float) -> float:

	if !attitude_curve:

		return 1.0

	return attitude_curve.sample(attitude)



func get_temperament_value(temperament: float) -> float:

	if !temperament_curve:

		return 1.0

	return temperament_curve.sample(temperament)



func get_fear_value(fear: float) -> float:

	if !fear_curve:

		return 1.0

	return fear_curve.sample(fear)