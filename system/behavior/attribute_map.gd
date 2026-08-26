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

	return attitude_curve.sample(attitude)



func get_temperament_value(temperament: float) -> float:

	return temperament_curve.sample(temperament)